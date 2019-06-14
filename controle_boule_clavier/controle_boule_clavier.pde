
  import processing.serial.*;


  int fgcolor;           // Fill color
  Serial myPort;      
  int[] serialInArray = new int[6];    // Where we'll put what we receive
  int serialCount = 0;  
  boolean firstContact = false;  
  boolean button = false;
  int size = 25;
  
     void setup() {
       size(400, 400);
       stroke(0);
       background(192, 64, 0);
    String portName = Serial.list()[1];
    myPort = new Serial(this, portName, 9600);       
     } 

     void draw() {
       if (button == true) {
         noStroke(); noFill(); }
       else if (button == false) {
         stroke (0); }
       println("draw");
       if (serialInArray[3] == 1) {
         size = size + 1; }
       else if (serialInArray[4] == 1) {
         size = size - 1; }
       ellipse(mouseX, mouseY, size, size );
    
     }
     void mouseClicked ()
     { if (mouseButton == RIGHT) {
       background(192, 64, 0); }
   //   else if (mouseButton == LEFT) {
   //     ellipse(mouseX, mouseY, 25, 25 );
   //   fill(192, 64, 0); stroke(192, 64, 0); }       
     }
  /*   void mouseDragged() {
      if (mouseButton == LEFT) {
        println("Dragged");
        ellipse(mouseX, mouseY, 25, 25 );
      fill(192, 64, 0); stroke(192, 64, 0); }
     } */
     void mousePressed() {
       if (mouseButton == LEFT) {
         button = true; }
     }
     void mouseReleased() {
       if (mouseButton == LEFT) {
         button = false; }
     }
     
  void serialEvent(Serial myPort) {
    // read a byte from the serial port:
    int inByte = myPort.read();
    println(inByte);
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
        if (serialInArray[0] == 1) {
          fill(255, 0, 0); }
        else if (serialInArray[1] == 1) {
          fill(0, 255, 0); }
         else if (serialInArray[2] == 1) { 
           fill(0, 0, 255); }
         else {
           fill(255, 255, 255); }

        // print the values (for debugging purposes only):
        println(serialInArray[0] + "\t" + serialInArray[1] + "\t" + serialInArray[2]);

        // Send a capital A to request new sensor readings:
        myPort.write('A');
        // Reset serialCount:
        serialCount = 0;
      }
    }
  }     
