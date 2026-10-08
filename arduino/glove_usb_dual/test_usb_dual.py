"""Execute the shipped sketch logic with simulated Arduino ports, not hardware."""
from pathlib import Path
import subprocess
import tempfile

root = Path(__file__).resolve().parent
arduino = r'''
#pragma once
#include <cstdint>
#include <cstddef>
#include <deque>
#include <string>
#include <cassert>
#define SERIAL_8N1 0
#define LED_BUILTIN 13
#define OUTPUT 1
#define HIGH 1
#define LOW 0
inline uint32_t clockMs=0;
inline int ledState=0;
inline uint32_t irqMask=0;
inline uint32_t __get_PRIMASK(){return irqMask;}
inline void __disable_irq(){irqMask=1;}
inline void __set_PRIMASK(uint32_t v){irqMask=v;}
inline uint32_t millis(){return clockMs;}
inline void pinMode(int,int){}
inline void digitalWrite(int,int v){ledState=v;}
class Stream{public:virtual ~Stream()=default;virtual int available()=0;virtual int read()=0;};
class FakePort:public Stream{public:
 std::deque<int> input;std::string output;int room=4096;unsigned long baud=0;
 int available()override{return input.size();}
 int read()override{if(input.empty())return -1;int v=input.front();input.pop_front();return v;}
 void begin(unsigned long b){baud=b;}
 int availableForWrite(){
#ifdef NO_USB
 return 0; // Actual UNO R4 WiFi UART inherits Print's zero-returning default.
#else
 return room;
#endif
 }
 size_t write(const uint8_t*b,size_t n){output.append((const char*)b,n);room-=n;return n;}
 void feed(const std::string&s){for(unsigned char c:s)input.push_back(c);}
};
inline FakePort Serial,Serial1;
class UART:public FakePort{protected:bool init_ok=false;public:int tx,rx;bool succeeds=true;
 UART(int t,int r):tx(t),rx(r){}
 void begin(unsigned long b,int){baud=b;init_ok=succeeds;}
};
'''
soft = r'''
#pragma once
#include "Arduino.h"
class SoftwareSerial:public FakePort{public:int rx,tx;bool succeeds=true;
 SoftwareSerial(int r,int t,size_t):rx(r),tx(t){}
 int begin(unsigned long b,int){baud=b;return succeeds?1:0;}
 int read()override{assert(irqMask==1);return FakePort::read();}
};
'''
servo = r'''
#pragma once
class Servo{public:int pin=-1,value=-1;int attach(int p){pin=p;return 1;}void write(int v){value=v;}};
'''
test = r'''
#include <cassert>
#include <iostream>
#include "@SKETCH@"
int checks=0;
void pass(){++checks;}
void clear(){hands[0]=HandState{};hands[1]=HandState{};clockMs=100;Serial.output.clear();Serial.room=4096;Serial1.input.clear();rightGlove.input.clear();}
void feed(int h,const std::string&s){for(char c:s)receiveByte(h,c);}
const std::string frame="1800,1600,1500,1490,1345,0000,0000,0000,0000,0000,0000";
int main(){
 setup();assert(rightReady&&rightGlove.rx==11&&rightGlove.tx==10&&Serial.baud==115200&&Serial1.baud==115200&&ledState==LOW);pass();
 assert(servo1.pin==6&&servo5.pin==2&&servo1.value==90);pass();
 int v[5]={};assert(parseFrame(frame.c_str(),v)&&v[4]==1345);pass();
 assert(parseFrame((" \r\n"+frame+"\t ").c_str(),v));pass();
 assert(!parseFrame("1,2,3,4,5,0,0,0,0,0",v));pass();
 assert(!parseFrame((frame+",0").c_str(),v));pass();
 assert(!parseFrame("1,2,3,4,5,0,0,0,0,0,no",v));pass();
 assert(!parseFrame("1,2,3,4,5,0,0,0,0,0,9999999999999999999999",v));pass();
 assert(!parseFrame("1801,2,3,4,5,0,0,0,0,0,0",v)&&!parseFrame("-1,2,3,4,5,0,0,0,0,0,0",v));pass();
 assert(!parseFrame("1,2,3,4,5,0,0,0,0,0,2147483648",v));pass();
 v[0]=777;assert(!parseFrame("1,2,3,4,5,0,0,0,0,0,",v)&&v[0]==777);pass();
 clear();feed(0,frame+";");assert(hands[0].pending&&!hands[1].pending&&servo1.value==0&&servo5.value==135);pass();
 feed(1,"1700,1520,1494,1580,1321,0,0,0,0,0,0;");assert(hands[1].angles[0]==1700&&hands[0].angles[0]==1800&&servo1.value==0);pass();
 sendPending(0);sendPending(1);assert(Serial.output=="L,180.0,160.0,150.0,149.0,134.5;\nR,170.0,152.0,149.4,158.0,132.1;\n");pass();
 Serial.output.clear();clockMs+=1000;sendPending(0);assert(Serial.output.empty());pass();
 clear();feed(0,std::string(200,'1')+","+frame+";");assert(!hands[0].pending);feed(0,frame+";");assert(hands[0].pending);pass();
 clear();feed(0,std::string("12\0",3)+frame+";");assert(!hands[0].pending);feed(0,frame+";");assert(hands[0].pending);pass();
 clear();Serial.room=0;feed(0,frame+";");sendPending(0);assert(hands[0].pending&&Serial.output.empty()&&servo5.value==135);Serial.room=4096;sendPending(0);assert(!hands[0].pending);pass();
 clear();Serial.room=0;feed(0,frame+";");feed(0,"1000,1000,1000,1000,1000,0,0,0,0,0,0;");Serial.room=4096;sendPending(0);assert(Serial.output=="L,100.0,100.0,100.0,100.0,100.0;\n");pass();
 clear();feed(0,frame+";");clockMs+=101;sendPending(0);assert(!hands[0].pending&&Serial.output.empty());pass();
 clear();feed(0,frame+";");sendPending(0);Serial.output.clear();clockMs+=5;feed(0,frame+";");sendPending(0);assert(Serial.output.empty()&&hands[0].pending);clockMs+=15;sendPending(0);assert(!Serial.output.empty());pass();
 clear();Serial1.feed(std::string(200,'1'));rightGlove.feed(frame+";");loop();assert(Serial1.available()==0&&rightGlove.available()==0&&!Serial.output.empty());pass();
 clear();clockMs=5;hands[0].sentAt=UINT32_MAX-30;feed(0,frame+";");sendPending(0);assert(!Serial.output.empty());pass();
 clear();rightGlove.succeeds=false;setup();assert(!rightReady&&ledState==HIGH);clockMs=2000;Serial1.feed(frame+";");loop();assert(Serial.output.find("L,")!=std::string::npos&&Serial.output.find("#ERROR,RIGHT_SERIAL_INIT;")!=std::string::npos);pass();
 rightGlove.succeeds=true;setup();clear();
 const std::string newer="1000,1100,1200,1300,1030,0,0,0,0,0,0;";
 rightGlove.feed(frame+";"+frame+";"+newer);loop();
 assert(Serial.output.find("R,100.0,110.0,120.0,130.0,103.0;\n")==0&&Serial.output.find("R,180.")==std::string::npos&&hands[1].validFrames==3&&hands[1].queuePeak>64);pass();
 clear();Serial1.feed(frame+";"+newer);rightGlove.feed(frame+";"+newer);loop();
 assert(hands[0].angles[4]==1030&&hands[1].angles[4]==1030&&hands[0].validFrames==2&&hands[1].validFrames==2&&Serial1.available()==0&&rightGlove.available()==0);pass();
 clear();rightGlove.feed(std::string(1500,'1'));loop();assert(rightGlove.available()==1500-RIGHT_DRAIN_LIMIT);pass();
 clear();feed(1,"1,2;"+std::string(200,'1')+";"+newer);assert(hands[1].badFrames==2&&hands[1].validFrames==1&&hands[1].angles[4]==1030);pass();
 rightGlove.feed("a");irqMask=0;assert(readRightByte()=='a'&&irqMask==0);rightGlove.feed("b");irqMask=1;assert(readRightByte()=='b'&&irqMask==1);irqMask=0;pass();
 std::cout<<"PASS: "<<checks<<" actual-sketch checks with simulated ports; no hardware test\n";
}
'''
bridge_test = r'''
#include <cassert>
#include <iostream>
#include "@SKETCH@"
int main(){
 setup();int checks=0;
 assert(Serial.availableForWrite()==0);++checks;
 const std::string frame="1800,1600,1500,1490,1345,0,0,0,0,0,0;";
 clockMs=100;Serial1.feed(frame);rightGlove.feed(frame);loop();
 assert(Serial.output.find("L,180.0,160.0,150.0,149.0,134.5;")!=std::string::npos);++checks;
 assert(Serial.output.find("R,180.0,160.0,150.0,149.0,134.5;")!=std::string::npos);++checks;
 assert(!hands[0].pending&&!hands[1].pending);++checks;
 Serial.output.clear();clockMs=1100;loop();
 assert(Serial.output=="#STATUS,USB3,L,"+std::to_string(frame.size())+",1,0,"+std::to_string(frame.size())+",R,"+std::to_string(frame.size())+",1,0,"+std::to_string(frame.size())+";\n");++checks;
 assert(Serial.output.find("L,180.")==std::string::npos);++checks;
 Serial.output.clear();clockMs=2100;rightReady=false;loop();
 assert(Serial.output.find("#ERROR,RIGHT_SERIAL_INIT;")!=std::string::npos);++checks;
 assert(Serial.output.find("#STATUS,USB3,L,")!=std::string::npos);++checks;
 std::cout<<"PASS: "<<checks<<" UNO R4 WiFi bridge checks with zero availableForWrite; no hardware test\n";
}
'''
hardware_test = r'''
#include <cassert>
#include <iostream>
#include "@SKETCH@"
int main(){
 setup();int checks=0;
 assert(rightReady&&rightGlove.rx==12&&rightGlove.tx==11&&rightGlove.baud==115200);++checks;
 const std::string frame="1800,1600,1500,1490,1345,0,0,0,0,0,0;";
 clockMs=100;Serial1.feed(frame);rightGlove.feed(frame+frame);loop();
 assert(hands[0].validFrames==1&&hands[1].validFrames==2);++checks;
 assert(Serial.output.find("R,180.0,160.0,150.0,149.0,134.5;")!=std::string::npos);++checks;
 rightGlove.succeeds=false;setup();assert(!rightReady&&ledState==HIGH);++checks;
 std::cout<<"PASS: "<<checks<<" hardware-UART option checks; no physical timing test\n";
}
'''
with tempfile.TemporaryDirectory(prefix="glove-usb-check-") as folder:
    temp = Path(folder)
    for name, content in {"Arduino.h": arduino, "SoftwareSerial.h": soft, "Servo.h": servo,
                          "test.cpp": test.replace("@SKETCH@", str(root / "glove_usb_dual.ino"))}.items():
        (temp / name).write_text(content)
    binary = temp / "test"
    subprocess.run(["/usr/bin/clang++", "-std=c++17", "-DARDUINO_UNOR4_WIFI", "-I", str(temp),
                    str(temp / "test.cpp"), "-o", str(binary)], check=True)
    subprocess.run([str(binary)], check=True)
    (temp / "hardware.cpp").write_text(hardware_test.replace("@SKETCH@", str(root / "glove_usb_dual.ino")))
    subprocess.run(["/usr/bin/clang++", "-std=c++17", "-DARDUINO_UNOR4_WIFI", "-DNO_USB", "-DRIGHT_USE_HARDWARE_UART=1", "-I", str(temp),
                    str(temp / "hardware.cpp"), "-o", str(binary)], check=True)
    subprocess.run([str(binary)], check=True)
    (temp / "bridge.cpp").write_text(bridge_test.replace("@SKETCH@", str(root / "glove_usb_dual.ino")))
    subprocess.run(["/usr/bin/clang++", "-std=c++17", "-DARDUINO_UNOR4_WIFI", "-DNO_USB", "-I", str(temp),
                    str(temp / "bridge.cpp"), "-o", str(binary)], check=True)
    subprocess.run([str(binary)], check=True)
