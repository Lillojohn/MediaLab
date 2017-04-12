import processing.serial.*;

private IState state;
private Serial myPort;  // The serial port

void setup() {
  frameRate(60);
  fullScreen();
  //size(1200, 675);
  this.state = new Carousel(this);
  
  // List all the available serial ports
  //printArray(Serial.list());
  // Open the port you are using at the rate you want:
  myPort = new Serial(this, Serial.list()[3], 9600);
}

void update() {
  state.update();   
  
  // Check if port is available and jump is printed in serial.
  while (myPort.available() > 0) {
    String inBuffer = myPort.readString();
    if (inBuffer != null && inBuffer.contains("jump")) {
      this.state.action("jump");
    }
  }
}

void draw() {
  state.draw(); 
  this.update();
}

void keyPressed() {
  this.state.keyPressHandle(key);
}

void keyReleased() {
  this.state.keyReleaseHandle(key);
}

void changeState(IState state) {
  this.state = state;
}