private ArrayList<GameObject> listOfGameObjects;
private Collision collision;
private GroupOfPipes groupOfPipes;
private Background background;
private Bird bird;
private GameOver gameOver;
private boolean endGame;


void setup() {
  size(360, 600);
  background(255);
  
  listOfGameObjects = new ArrayList<GameObject>();
  collision = new Collision(this);
  background = new Background(0, 0, width, height, this);
  groupOfPipes = new GroupOfPipes(collision, this);
  bird = new Bird(50, 50, 50, 50, collision, this);
  endGame = false;

  frameRate(30);
}

public void update(){
  // Update alle Objects in de Arraylist 'listOfGameObjects'. 
  for(GameObject object : listOfGameObjects) {
    object.update();
  }
  
  groupOfPipes.update();
  collision.update();
}

// Zorgt ervoor dat het spel voorbij is.
public void gameOver(){
  if(endGame == false){
    gameOver = new GameOver(50, 50, 250, 100, this);
    endGame = true;
  }
}

// Voeg een GameObject of kind daarvan toe aan de ArrayList 'listOfGameObjects'.
public void addToGameObjectList(GameObject object){
  listOfGameObjects.add(object);
}

public void drawObject(){
  // Drawt alle GameObjects in de Arraylist 'listOfGameObjects'.  
  for(GameObject object : listOfGameObjects) {
    object.drawObject();
  }
}

void draw() {
  background(255);

  update();
  drawObject();
}