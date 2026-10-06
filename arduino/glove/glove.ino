// Glove System — public release copy.
// Executable logic matches the supplied sketch; network settings are placeholders.
// Keep personal Wi-Fi credentials out of public commits.

#include <Servo.h>
#include <string.h>
#include <WiFiS3.h>       // Arduino UNO R4 WiFi networking library
#include <WiFiUdp.h>      // UDP transport
#include <OSCMessage.h>   // CNMAT OSC library

// -------- Replace these placeholders with your Wi-Fi credentials --------
const char* ssid     = "YOUR_WIFI_SSID";    // 
const char* password = "YOUR_WIFI_PASSWORD";    // 

// -------- Set the receiving computer LAN IPv4 address and UDP port --------
const char* outIp    = "192.0.2.1";  // Placeholder: replace with your computer LAN IP
const int outPort    = 7000;           // Must match udpreceive in GloveRecevier

WiFiUDP Udp;
bool isWifiConnected = false;

// -------- Five independently controlled servos --------
Servo servo1, servo2, servo3, servo4, servo5;

// -------- Servo signal pins (D6 through D2) --------
const int SERVO1_PIN = 6;
const int SERVO2_PIN = 5;
const int SERVO3_PIN = 4;
const int SERVO4_PIN = 3;
const int SERVO5_PIN = 2;

// -------- Per-servo limits and calibration --------
const int SERVO1_MIN = 0,   SERVO1_MAX = 180, SERVO1_TRIM = 0;
const int SERVO2_MIN = 0,   SERVO2_MAX = 180, SERVO2_TRIM = 0;
const int SERVO3_MIN = 0,   SERVO3_MAX = 180, SERVO3_TRIM = 0;
const int SERVO4_MIN = 0,   SERVO4_MAX = 180, SERVO4_TRIM = 0;
const int SERVO5_MIN = 0,   SERVO5_MAX = 180, SERVO5_TRIM = 0;

// External Bluetooth-to-UART receiver baud rate (Serial1 on D0/D1)
const long BT_BAUD = 115200;

// -------- Serial receive buffer --------
const size_t BUF_SIZE = 160;
char   inBuf[BUF_SIZE];
size_t inLen = 0;

// -------- Integer clamp --------
int clampInt(int v, int lo, int hi) {
  if (v < lo) return lo;
  if (v > hi) return hi;
  return v;
}

// -------- Divide by ten, rounding to the nearest integer --------
int div10_round(long v) {
  if (v >= 0) return (int)((v + 5) / 10);
  else        return (int)((v - 5) / 10);
}

// -------- Process one serial frame and send one OSC message --------
void handleFrame(char *frame) {
  // Trim leading and trailing whitespace
  while (*frame==' '||*frame=='\r'||*frame=='\n'||*frame=='\t') frame++;
  size_t L = strlen(frame);
  while (L && (frame[L-1]==' '||frame[L-1]=='\r'||frame[L-1]=='\n'||frame[L-1]=='\t')) frame[--L]='\0';
  if (L == 0) return;

  // Parse comma-separated integers; missing values retain zero
  long v0=0, v1=0, v2=0, v3=0, v4=0; 
  char *tok = strtok(frame, ","); if (tok) { v0 = strtol(tok, nullptr, 10); }
  tok = strtok(nullptr, ",");     if (tok) { v1 = strtol(tok, nullptr, 10); }
  tok = strtok(nullptr, ",");     if (tok) { v2 = strtol(tok, nullptr, 10); }
  tok = strtok(nullptr, ",");     if (tok) { v3 = strtol(tok, nullptr, 10); }
  tok = strtok(nullptr, ",");     if (tok) { v4 = strtol(tok, nullptr, 10); }

  // Round each value after dividing by ten
  int r0 = div10_round(v0);
  int r1 = div10_round(v1);
  int r2 = div10_round(v2);
  int r3 = div10_round(v3);
  int r4 = div10_round(v4);

  // Apply independent trims and limits
  int s1 = clampInt(r0 + SERVO1_TRIM, SERVO1_MIN, SERVO1_MAX);
  int s2 = clampInt(r1 + SERVO2_TRIM, SERVO2_MIN, SERVO2_MAX);
  int s3 = clampInt(r2 + SERVO3_TRIM, SERVO3_MIN, SERVO3_MAX);
  int s4 = clampInt(r3 + SERVO4_TRIM, SERVO4_MIN, SERVO4_MAX);
  int s5 = clampInt(r4 + SERVO5_TRIM, SERVO5_MIN, SERVO5_MAX);

  // Reverse the first four servo commands; keep the fifth direct
  servo1.write(180 - s1);
  servo2.write(180 - s2);
  servo3.write(180 - s3);
  servo4.write(180 - s4);
  servo5.write(s5);

  // Send five calibrated values as arguments of one /servos OSC message
  if (isWifiConnected && WiFi.status() == WL_CONNECTED) {
    OSCMessage msg("/servos"); 
    
    msg.add(s1);
    msg.add(s2);
    msg.add(s3);
    msg.add(s4);
    msg.add(s5);
    
    Udp.beginPacket(outIp, outPort);
    msg.send(Udp); 
    Udp.endPacket();
    msg.empty(); // Release the message contents
  }
}

void setup() {
  Serial.begin(115200);   // USB serial diagnostics
  Serial1.begin(BT_BAUD); // Receive external UART data on D0/D1

  // Attempt Wi-Fi connection; poll up to 20 times at 500 ms intervals
  Serial.print("Connecting to Wi-Fi...");
  WiFi.begin(ssid, password);
  int attempts = 0;
  while (WiFi.status() != WL_CONNECTED && attempts < 20) {
    delay(500);
    Serial.print(".");
    attempts++;
  }
  
  if (WiFi.status() == WL_CONNECTED) {
    isWifiConnected = true;
    Serial.println("\nWi-Fi Connected!");
    Serial.print("Arduino IP address: ");
    Serial.println(WiFi.localIP());
    Udp.begin(2390); // Bind the local UDP socket to port 2390
  } else {
    Serial.println("\nWi-Fi failed! Running in standalone mode (Servos only).");
  }

  // Initialize each servo to a trimmed, clamped 90-degree command
  servo1.attach(SERVO1_PIN);  servo1.write(clampInt(90 + SERVO1_TRIM, SERVO1_MIN, SERVO1_MAX));
  servo2.attach(SERVO2_PIN);  servo2.write(clampInt(90 + SERVO2_TRIM, SERVO2_MIN, SERVO2_MAX));
  servo3.attach(SERVO3_PIN);  servo3.write(clampInt(90 + SERVO3_TRIM, SERVO3_MIN, SERVO3_MAX));
  servo4.attach(SERVO4_PIN);  servo4.write(clampInt(90 + SERVO4_TRIM, SERVO4_MIN, SERVO4_MAX));
  servo5.attach(SERVO5_PIN);  servo5.write(clampInt(90 + SERVO5_TRIM, SERVO5_MIN, SERVO5_MAX));
}

void loop() {
  // Read UART data continuously; ';' terminates a frame
  while (Serial1.available()) {
    char c = (char)Serial1.read();
    if (c == ';') {
      inBuf[inLen] = '\0';
      handleFrame(inBuf);
      inLen = 0;
    } else {
      if (c >= 32 || c=='\r' || c=='\n' || c=='\t' || c==',') {
        if (inLen + 1 < BUF_SIZE) {
          inBuf[inLen++] = c;
        } else {
          inLen = 0; // Reset the buffer index on overflow
        }
      }
    }
  }
}
