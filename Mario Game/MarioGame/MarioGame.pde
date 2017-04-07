import processing.serial.*;

private GameCharacter character;
private ArrayList<GameObject> listOfGameObjects;
private ObstacleManager _obstacleManager;
private float _jumpPercentage;
private Serial myPort;  // The serial port
private Ground _ground;
private MiddleObjectDetector _middleObjectDetector;
private CollidableObjects _collidableObjects;
private ArrayList<IUpdate> _objectsThatUpdate;
private Background _background;
private PointManager _pointmanager;


void setup(){
  size(900, 700);
  _objectsThatUpdate = new ArrayList<IUpdate>();
  listOfGameObjects = new ArrayList<GameObject>();
  _collidableObjects =  new CollidableObjects();
  _jumpPercentage = 0;
  
  _background = new Background(0, 0, width, height, this);
  
  //currentLevel = new LevelLayer(this);
  character = new GameCharacter((width/2) - 20, 330, 80, 175, this);
  
  
  _obstacleManager = new ObstacleManager(this, character);
  _ground = new Ground(0,height - 200, width, 200, this);
  // List all the available serial ports
  printArray(Serial.list());
  // Open the port you are using at the rate you want:
  myPort = new Serial(this, Serial.list()[3], 9600);
  
  _middleObjectDetector = new MiddleObjectDetector(this, _collidableObjects, character);
  
  _pointmanager = new PointManager(this, character);
  
  frameRate(50);
}

public void update() {
  // Drawt alle GameObjects in de Arraylist 'listOfGameObjects'.  
  for(IUpdate object : _objectsThatUpdate) {
    object.Update();
  }
}

// Als er op de spatiebalk wordt gedrukt dan wordt er true gereturned.
void keyPressed(){
  if (key == ' ')
  {
    _obstacleManager.setResumeIsTrue(_jumpPercentage);
    _jumpPercentage = 0; 
    character.Jump();
  }
}


void draw(){
  background(99, 134, 251);
 
    
  // Drawt alle GameObjects in de Arraylist 'listOfGameObjects'.  
  for(GameObject object : listOfGameObjects) {
    object.drawObject();
  }
  
     
  if(_jumpPercentage < 81) {
    update();
  }
  
  
    //currentLevel.draw();
}

public void SetJumpPercentage(float percentage){
  _jumpPercentage = percentage;
}

// Voeg een GameObject of kind daarvan toe aan de ArrayList 'listOfGameObjects'.
public void addToGameObjectList(GameObject object){
  listOfGameObjects.add(object);
}

public void addToCollidableObjects(ICollidable object){
  _collidableObjects.AddToList(object);
}

public void AddToUpdateList(IUpdate object){
  _objectsThatUpdate.add(object);
}