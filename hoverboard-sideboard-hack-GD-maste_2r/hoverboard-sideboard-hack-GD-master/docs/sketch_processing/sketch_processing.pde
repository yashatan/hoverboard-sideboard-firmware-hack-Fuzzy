/*
    hoverboard-sidebboard-hack MPU6050 IMU - 3D Visualization Example. Use with VARIANT_DEBUG.
    Copyright (C) 2020-2021 Emanuel FERU
*/
import processing.serial.*;
import java.awt.event.KeyEvent;
import java.io.IOException;
PShape can1, can2, can3, can4;
Serial myPort;
float roll, pitch,yaw;
int idx = 0;

String data="";
String check="";

void setup() {
  size (1400, 800, P3D);      
  printArray(Serial.list());                 // List all the available serial ports    
  myPort = new Serial(this, "COM5", 38400);   // starts the serial communication
  myPort.bufferUntil('\n');
  can1 = createCan(7,200,200,1);
  can2 = createCan(7,200,200,2);
  can3 = createCan(7,200,200,3);
  can4 = createCan(7,200,200,4);
}

void draw() {
 
  // If no data is received, send 'e' command to read the Euler angles
  if(idx != -1 && myPort.available() == 0) {    
    idx++;
    if(idx > 20) {
      myPort.write('e');
      idx = -1;
    }
  } else {
    idx = -1;
  }
  
  // Display text
  translate(width/2, height/2, 0); //<>//
  background(51);
  textSize(22);
  text("Roll: " + roll + "     Pitch: " + pitch + "     Yaw: " + yaw, -200, 300);
  
  // Rotate the object
  rotateX(radians(roll));
  rotateZ(radians(-pitch));
  rotateY(radians(yaw));
  
  // 3D 0bject  
  // Draw box with text
  fill(35, 133, 54);     // Make board GREEN
  box (426, 30, 220);
  textSize(25);
  fill(255, 255, 255);
  text("MPU-6052c", -90, 10, 111);
  
  // Add other boxes
  translate(-50, -18, -30);
  fill(100, 100, 100);
  box (20, 5, 20); 
  // MPU-6050
  
 // translate(-70, 0, 0);
  fill(100, 100, 100);
  
  
  translate(70, 0, 0);
  box (40, 5, 40);     // GD32
  
  translate(20, 0, -70);
  lights();
  shape(can1);  
  translate(-18, 0, 0);
  shape(can2); 
  translate(-18, 0, 0);
  shape(can3);
  translate(-18, 0, 0);
  shape(can4);
  
  fill(250, 250, 250);
  translate(54, 0, 0);
  translate(-50, 0, 200);
  box (40, 40, 15);     // Color Led connector
  translate(-45, 0, 0);
  box (40, 40, 15); // Blue Led connector
  translate(95, 0, 0);
  box (50, 40, 15); 

}

// Read data from the Serial Port
void serialEvent (Serial myPort) { 
  // reads the data from the Serial Port up to the character '\n' and puts it into the String variable "data".
  data = myPort.readStringUntil('\n');
  // if you got any bytes other than the linefeed:
  if (data != null) {
    data = trim(data);
    // split the string at " " (character space)
    String items[] = split(data, ' ');
    if (items.length > 5) {
      //--- Roll,Pitch in degrees
      roll  = float(items[2]) / 100;
      pitch = float(items[4]) / 100;
      yaw   = float(items[6]) / 100;
    }
  }
}
PShape createCan(float r, float h, int detail, int mau) {
 
  textureMode(NORMAL);
  PShape sh = createShape();

  sh.beginShape(QUAD_STRIP);
   switch(mau){
    case 1 :
    sh.fill(0,0,0);
    break;
    case 2 :
    sh.fill(0,255,0);
    break;
    case 3 :
    sh.fill(0,0,255);
    break;
    case 4 :
    sh.fill(255,0,0);
    break;
  }
  sh.noStroke();
  
  for (int i = 0; i <= detail; i++) {
    float angle = TWO_PI / detail;
    float x = sin(i * angle);
    float z = cos(i * angle);
    float u = float(i) / detail;
    sh.normal(x, 0, z);
    sh.vertex(x * r, -h/2, z * r, u, 0);
    sh.vertex(x * r,10, z * r, u, 1);
  }
  sh.endShape();
  return sh;
}
