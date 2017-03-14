import processing.serial.*;

private Mario Mario;
private ArrayList<GameObject> listOfGameObjects;
private LevelLayer currentLevel;
private ObstacleManager _obstacleManager;
private float _jumpPercentage;
private Serial myPort;  // The serial port


void setup(){
  size(600, 400);
  listOfGameObjects = new ArrayList<GameObject>();
  _jumpPercentage = 0;
  
  int[] level = {
    1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
    1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
    1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
    1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
  };
  
  currentLevel = new LevelLayer(level, this);
  Mario = new Mario(20, 350, 20, 20, this);
  
  _obstacleManager = new ObstacleManager(this, Mario);
  
  // List all the available serial ports
  printArray(Serial.list());
  // Open the port you are using at the rate you want:
  myPort = new Serial(this, Serial.list()[3], 9600);
  
  frameRate(50);
}

public void update() {
  Mario.update();
  unJump();
  while (myPort.available() > 0) {
    String inBuffer = myPort.readString();
    if (inBuffer != null && inBuffer.contains("jump")) {
      jump();
      println("Jumping");
    }
  }
  currentLevel.update();
  _obstacleManager.update();
}

// Als er op de spatiebalk wordt gedrukt dan wordt er true gereturned.
void keyPressed(){
  if (key == ' ')
  {
    _obstacleManager.setResumeIsTrue(_jumpPercentage);
    _jumpPercentage = 0; 
    jump();
  }
}

void keyReleased() {
  if (key == ' ')
  {
    unJump();
  }
}

void jump() {
  Mario.jump = 1;
}

void unJump() {
  Mario.jump = 0;
}

void draw(){
  background(99, 134, 251);
 
    
  // Drawt alle GameObjects in de Arraylist 'listOfGameObjects'.  
  for(GameObject object : listOfGameObjects) {
    object.drawObject();
  }
  
     
  if(_jumpPercentage < 90) {
    update();
  }
  
  
    currentLevel.draw();
}

public void SetJumpPercentage(float percentage){
  _jumpPercentage = percentage;
}

// Voeg een GameObject of kind daarvan toe aan de ArrayList 'listOfGameObjects'.
public void addToGameObjectList(GameObject object){
  listOfGameObjects.add(object);
}