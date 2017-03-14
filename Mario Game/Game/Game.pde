private Mario Mario;
private ArrayList<GameObject> listOfGameObjects;
private LevelLayer currentLevel;
private Obstacle nextObstacle;

void setup(){
  size(600, 400);
  listOfGameObjects = new ArrayList<GameObject>();
  
  int[] level = {
    1,1,1,1,0,1,1,1,1,1,1,0,1,1,1,1,0,1,1,1,1,0,1,1,1
  };
  
  currentLevel = new LevelLayer(level, this);
  Mario = new Mario(20, 350, 20, 20, this);
  
  frameRate(50);
}

public void update() {
  Mario.update();
  currentLevel.update();
}

// Als er op de spatiebalk wordt gedrukt dan wordt er true gereturned.
void keyPressed(){
  if (key == ' ')
  {
    Mario.jump = 1;
  }
}

void keyReleased() {
  if (key == ' ')
  {
    Mario.jump = 0;
  }
}

void draw(){
  background(99, 134, 251);
  
  // Drawt alle GameObjects in de Arraylist 'listOfGameObjects'.  
  for(GameObject object : listOfGameObjects) {
    object.drawObject();
  }
  
  currentLevel.draw();
  
  update();
}

// Voeg een GameObject of kind daarvan toe aan de ArrayList 'listOfGameObjects'.
public void addToGameObjectList(GameObject object){
  listOfGameObjects.add(object);
}