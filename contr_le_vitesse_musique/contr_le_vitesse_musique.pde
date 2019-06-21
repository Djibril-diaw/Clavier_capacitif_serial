/**
 * This is a simple sound file player. Use the mouse position to control playback
 * speed, amplitude and stereo panning.
 */

import processing.sound.*;
  import processing.serial.*;

SoundFile soundfile;

  Serial myPort;      
  int[] serialInArray = new int[6];    // Where we'll put what we receive
  int serialCount = 0;  
  float speed = 1.09;
  float amplitude = 0.6;
  boolean firstContact = false;  
  float xpos = 400;
  float ypos = 400;

void setup() {
  size(800, 800);
  stroke(0);
  

  // Load a soundfile
  soundfile = new SoundFile(this, "daft-punk-veridis-quo.mp3");

  // These methods return useful infos about the file
  println("SFSampleRate= " + soundfile.sampleRate() + " Hz");
  println("SFSamples= " + soundfile.frames() + " samples");
  println("SFDuration= " + soundfile.duration() + " seconds");

  // Play the file in a loop
  soundfile.loop();
  
      String portName = Serial.list()[1];
    myPort = new Serial(this, portName, 9600);  
}      


void mouseDragged() {
  xpos = mouseX;
  ypos = mouseY;}


void draw() {
  
  
fill(255);

  
  background(255);
  
 line(375, 400, 425, 400); 
 line(400, 375, 400, 425); 
  
  ellipse(xpos, ypos, 30, 30 );
  
      speed = xpos/(400/1.09) ;
      amplitude = ypos/(400/0.6);
  
  if (serialInArray[1] == 1) {
    
    float a = xpos;
    xpos = xpos + 0.5;
 
      }
  else if (serialInArray[0] == 1) {

    xpos = xpos - 0.5; 
  }
         
 if (serialInArray[3] == 1) {

    ypos = ypos + 0.5;
       }
  else if (serialInArray[4] == 1) {
    ypos = ypos - 0.5; }
   
  // Map mouseX from 0.25 to 4.0 for playback rate. 1 equals original playback speed,
  // 2 is twice the speed and will sound an octave higher, 0.5 is half the speed and
  // will make the file sound one ocative lower.
  soundfile.rate(speed);

  // Map mouseY from 0.2 to 1.0 for amplitude
  soundfile.amp(amplitude);

  // Map mouseY from -1.0 to 1.0 for left to right panning
 // float panning = map(mouseY, 0, height, -1.0, 1.0);
 // soundfile.pan(panning);
  
 //println ("speed = " + speed);
  println ("amplitude = " + amplitude);
  
}

  void serialEvent(Serial myPort) {
    // read a byte from the serial port:
    int inByte = myPort.read();
    //println(inByte);
    // if this is the first byte received, and it's an A, clear the serial
    // buffer and note that you've had first contact from the microcontroller.
    // Otherwise, add the incoming byte to the array:
    if (firstContact == false) {
      if (inByte == 'A') {
        myPort.clear();          // clear the serial port buffer
        firstContact = true;     // you've had first contact from the microcontroller
        myPort.write('A');       // ask for more
      }
    }
    else {
      // Add the latest byte from the serial port to array:
      serialInArray[serialCount] = inByte;
      serialCount++;

      // If we have 3 bytes:
      if (serialCount > 5 ) {
        // Send a capital A to request new sensor readings:
        myPort.write('A');
        // Reset serialCount:
        serialCount = 0;
      }
    }
  }       
