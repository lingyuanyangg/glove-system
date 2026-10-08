// Dual Manu-5D receiver for Arduino UNO R4 WiFi, Arduino core 1.6.0.
// LEFT:  module TXD -> D0 (Serial1 RX); module RXD <- D1 (optional).
// RIGHT: module TXD -> D12 (hardware RX); module RXD <- D11 (optional).
// This variant uses SCI0 on D11 TX / D12 RX, with no SoftwareSerial.
// Power both supplied receiver modules from 3.3 V, share GND, match UART levels.
// USB output: L,180.0,160.0,150.0,149.0,134.5;\n (or R,...).
// Input: exactly 11 integers, comma-separated, terminated by ';'.
// The first five integers are angles in tenths of a degree; other fields ignored.
// No Wi-Fi, OSC, String allocation, blocking USB startup wait or delay().
// UNO R4 WiFi Serial uses the ESP32 bridge UART; short bulk writes wait for TX.

#include <Arduino.h>
#ifndef RIGHT_USE_HARDWARE_UART
#define RIGHT_USE_HARDWARE_UART 1 // Right input uses the D12 hardware UART.
#endif
#if RIGHT_USE_HARDWARE_UART != 0 && RIGHT_USE_HARDWARE_UART != 1
#error "RIGHT_USE_HARDWARE_UART must be 0 (D11 software RX) or 1 (D12 hardware RX)."
#endif
#if !RIGHT_USE_HARDWARE_UART
#include <SoftwareSerial.h>
#endif
#include <Servo.h>
#include <errno.h>
#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>

#if !defined(ARDUINO_UNOR4_WIFI)
#error "Select Arduino UNO R4 WiFi. SoftwareSerial pin support differs by board."
#endif

#if RIGHT_USE_HARDWARE_UART
#define RIGHT_RX_PIN 12
#define RIGHT_TX_PIN 11
#else
#define RIGHT_RX_PIN 11
#define RIGHT_TX_PIN 10
#endif
#ifndef ENABLE_SERVOS
#define ENABLE_SERVOS 1       // Set to 0 for a data-only receiver.
#endif
#define SERVO_HAND 0          // 0 = left, 1 = right; one existing five-servo hand.

#if RIGHT_RX_PIN == 10
#error "D10 has no RX interrupt on UNO R4 WiFi. Use D11 RX and D10 TX."
#endif
#if SERVO_HAND != 0 && SERVO_HAND != 1
#error "SERVO_HAND must be 0 (left) or 1 (right)."
#endif

const unsigned long BT_BAUD = 115200;
const unsigned long USB_BAUD = 115200;
const uint32_t OUTPUT_INTERVAL_MS = 20; // Maximum 50 fresh frames/s per hand.
const uint32_t PENDING_MAX_AGE_MS = 100;
const size_t FRAME_CAPACITY = 160;
const size_t READ_CHUNK = 32; // Interleave input work before either USB write.
const size_t LEFT_DRAIN_LIMIT = 512;
const size_t RIGHT_DRAIN_LIMIT = RIGHT_USE_HARDWARE_UART ? 512 : 1023;

#if RIGHT_USE_HARDWARE_UART
class RightHardwareUART : public UART {
public:
  RightHardwareUART() : UART(RIGHT_TX_PIN, RIGHT_RX_PIN) {}
  bool start(unsigned long baud) { begin(baud, SERIAL_8N1); return init_ok; }
};
RightHardwareUART rightGlove;
#else
SoftwareSerial rightGlove(RIGHT_RX_PIN, RIGHT_TX_PIN, 1024);
#endif
bool rightReady = false;

struct HandState {
  char frame[FRAME_CAPACITY];
  size_t length;
  bool discardUntilDelimiter;
  int angles[5]; // Nonnegative tenths of a degree, 0..1800.
  bool pending;
  uint32_t receivedAt;
  uint32_t sentAt;
  uint32_t rxBytes;
  uint32_t validFrames;
  uint32_t badFrames;
  uint32_t queuePeak;
};
HandState hands[2] = {};

// Independent angle calibration. Values are tenths of a degree.
const int TRIM[2][5] = {{0, 0, 0, 0, 0}, {0, 0, 0, 0, 0}};

#if ENABLE_SERVOS
Servo servo1, servo2, servo3, servo4, servo5;
#endif

bool whitespace(char c) {
  return c == ' ' || c == '\t' || c == '\r' || c == '\n';
}

bool parseFrame(const char *text, int result[5]) {
  int temporary[5];
  const char *p = text;
  for (int field = 0; field < 11; ++field) {
    while (whitespace(*p)) ++p;
    const char *number = p;
    if (*number == '+' || *number == '-') ++number;
    if (*number < '0' || *number > '9') return false;
    errno = 0;
    char *end = nullptr;
    const long value = strtol(p, &end, 10);
    if (end == p || errno == ERANGE || value < INT32_MIN || value > INT32_MAX)
      return false;
    p = end;
    while (whitespace(*p)) ++p;
    if (field < 5) {
      if (value < 0 || value > 1800) return false;
      temporary[field] = static_cast<int>(value);
    }
    if (field < 10) {
      if (*p != ',') return false;
      ++p;
    } else if (*p != '\0') {
      return false;
    }
  }
  // Never replace a working hand state with a partial/malformed frame.
  for (int i = 0; i < 5; ++i) result[i] = temporary[i];
  return true;
}

void moveServos(const int angles[5]) {
#if ENABLE_SERVOS
  // First four servo directions are reversed; the thumb is direct.
  servo1.write(180 - (angles[0] + 5) / 10);
  servo2.write(180 - (angles[1] + 5) / 10);
  servo3.write(180 - (angles[2] + 5) / 10);
  servo4.write(180 - (angles[3] + 5) / 10);
  servo5.write((angles[4] + 5) / 10);
#else
  (void)angles;
#endif
}

void acceptFrame(uint8_t hand) {
  int values[5];
  HandState &state = hands[hand];
  if (!parseFrame(state.frame, values)) { state.badFrames++; return; }
  for (int i = 0; i < 5; ++i) {
    int corrected = values[i] + TRIM[hand][i];
    if (corrected < 0) corrected = 0;
    if (corrected > 1800) corrected = 1800;
    state.angles[i] = corrected;
  }
  state.validFrames++;
  state.receivedAt = millis();
  state.pending = true;
  if (hand == SERVO_HAND) moveServos(state.angles);
}

void receiveByte(uint8_t hand, char c) {
  HandState &state = hands[hand];
  state.rxBytes++;
  if (c == ';') {
    if (!state.discardUntilDelimiter) {
      state.frame[state.length] = '\0';
      if (state.length) acceptFrame(hand);
    } else state.badFrames++;
    state.length = 0;
    state.discardUntilDelimiter = false;
  } else if (!state.discardUntilDelimiter) {
    if ((!whitespace(c) && (c < 32 || c > 126)) ||
        state.length + 1 >= FRAME_CAPACITY) {
      // Drop the WHOLE overflowing/binary frame, including its remaining suffix.
      state.length = 0;
      state.discardUntilDelimiter = true;
    } else {
      state.frame[state.length++] = c;
    }
  }
}

int readRightByte() {
#if RIGHT_USE_HARDWARE_UART
  return rightGlove.read();
#else
  // Core 1.6.0's SoftwareSerial RingBuffer updates a shared _size with
  // non-atomic ++/-- in DMA RX and main code. Protect only this short read,
  // restoring prior interrupt state; never mask interrupts for parsing/TX.
  const uint32_t mask = __get_PRIMASK();
  __disable_irq();
  const int byte = rightGlove.read();
  __set_PRIMASK(mask);
  return byte;
#endif
}

void drainInputs() {
  // Drain the queue present at entry, not just its oldest 64 bytes. Work is
  // bounded by ring capacities and alternating 32-byte slices. Coalesce all
  // complete frames before sending USB, so a burst emits the latest pose.
  size_t remaining[2] = {static_cast<size_t>(Serial1.available()),
                        rightReady ? static_cast<size_t>(rightGlove.available()) : 0};
  for (uint8_t h=0; h<2; ++h) {
    if (remaining[h] > hands[h].queuePeak) hands[h].queuePeak = remaining[h];
    const size_t limit = h ? RIGHT_DRAIN_LIMIT : LEFT_DRAIN_LIMIT;
    if (remaining[h] > limit) remaining[h] = limit;
  }
  static uint8_t first = 0;
  while (remaining[0] || remaining[1]) {
    for (uint8_t j=0; j<2; ++j) {
      const uint8_t h = first ^ j;
      size_t count = remaining[h] < READ_CHUNK ? remaining[h] : READ_CHUNK;
      while (count--) {
        const int byte = h ? readRightByte() : Serial1.read();
        if (byte < 0) { remaining[h] = 0; break; }
        --remaining[h];
        receiveByte(h, static_cast<char>(byte));
      }
    }
  }
  first ^= 1;
}

int formatOutput(char *line, size_t capacity, uint8_t hand) {
  const int *a = hands[hand].angles;
  return snprintf(line, capacity, "%c,%d.%d,%d.%d,%d.%d,%d.%d,%d.%d;\n",
                  hand == 0 ? 'L' : 'R',
                  a[0]/10, a[0]%10, a[1]/10, a[1]%10,
                  a[2]/10, a[2]%10, a[3]/10, a[3]%10, a[4]/10, a[4]%10);
}

bool writeUsbFrame(char *line, size_t length) {
#ifdef NO_USB
  // UNO R4 WiFi core 1.6.0 maps Serial to UART through the ESP32 USB bridge.
  // UART inherits Print::availableForWrite(), which returns 0, so it MUST NOT
  // be used as a transmit gate here. The mutable buffer selects UART bulk write.
  return Serial.write(reinterpret_cast<uint8_t *>(line), length) == length;
#else
  // Native USB CDC cores do expose usable transmit-buffer space.
  if (Serial.availableForWrite() < static_cast<int>(length)) return false;
  return Serial.write(reinterpret_cast<uint8_t *>(line), length) == length;
#endif
}

void sendPending(uint8_t hand) {
  HandState &state = hands[hand];
  const uint32_t now = millis();
  if (!state.pending) return;
  if (static_cast<uint32_t>(now - state.receivedAt) > PENDING_MAX_AGE_MS) {
    state.pending = false;
    return;
  }
  if (static_cast<uint32_t>(now - state.sentAt) < OUTPUT_INTERVAL_MS) return;
  char line[40];
  const int count = formatOutput(line, sizeof(line), hand);
  if (count <= 0 || count >= static_cast<int>(sizeof(line))) return;
  if (!writeUsbFrame(line, static_cast<size_t>(count))) return;
  state.pending = false;
  state.sentAt = now;
}

void reportRightFault() {
  static uint32_t previous = 0;
  const uint32_t now = millis();
  if (rightReady || static_cast<uint32_t>(now - previous) < 1000) return;
  char error[] = "#ERROR,RIGHT_SERIAL_INIT;\n";
  if (writeUsbFrame(error, sizeof(error)-1)) {
    previous = now;
  }
}

void reportStatus() {
  static uint32_t previous = 0;
  const uint32_t now = millis();
  if (static_cast<uint32_t>(now - previous) < 1000) return;
  char line[144];
  const int count = snprintf(line, sizeof(line),
      "#STATUS,USB3,L,%lu,%lu,%lu,%lu,R,%lu,%lu,%lu,%lu;\n",
      static_cast<unsigned long>(hands[0].rxBytes),
      static_cast<unsigned long>(hands[0].validFrames),
      static_cast<unsigned long>(hands[0].badFrames),
      static_cast<unsigned long>(hands[0].queuePeak),
      static_cast<unsigned long>(hands[1].rxBytes),
      static_cast<unsigned long>(hands[1].validFrames),
      static_cast<unsigned long>(hands[1].badFrames),
      static_cast<unsigned long>(hands[1].queuePeak));
  if (count > 0 && count < static_cast<int>(sizeof(line)) &&
      writeUsbFrame(line, static_cast<size_t>(count))) previous = now;
}

void setup() {
  Serial.begin(USB_BAUD); // USB connector via UNO R4 WiFi's onboard bridge.
  Serial1.begin(BT_BAUD);
#if RIGHT_USE_HARDWARE_UART
  rightReady = rightGlove.start(BT_BAUD);
#else
  rightReady = rightGlove.begin(BT_BAUD, SERIAL_8N1) != 0;
#endif
  pinMode(LED_BUILTIN, OUTPUT);
  digitalWrite(LED_BUILTIN, rightReady ? LOW : HIGH);
#if ENABLE_SERVOS
  servo1.attach(6); servo1.write(90);
  servo2.attach(5); servo2.write(90);
  servo3.attach(4); servo3.write(90);
  servo4.attach(3); servo4.write(90);
  servo5.attach(2); servo5.write(90);
#endif
}

void loop() {
  drainInputs();
  // Alternate output priority so one hand cannot monopolize a busy USB buffer.
  static uint8_t first = 0;
  sendPending(first);
  sendPending(first ^ 1);
  first ^= 1;
  reportRightFault();
  reportStatus();
}
