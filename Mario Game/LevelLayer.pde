class LevelLayer {
  private ArrayList<GameObject> listOfObstacles;
  
  public LevelLayer(int[] objects, Game game) {
    listOfObstacles = new ArrayList<GameObject>();
    
    int xPosition = 0;
    for(int i = 0; i < objects.length; i++) {
      if(objects[i] == 1) {
        addObject(new Block(xPosition, 370, 30, 30, game));
        xPosition += 30;
      } else if (objects[i] == 0) {
        addObject(new Hole(xPosition, 370, 100, 30, game));
        xPosition += 100;
      }
    }
  }
  
  public void update() {
    // Drawt alle GameObjects in de Arraylist 'listOfGameObjects'.  
    for(GameObject obstacle : listOfObstacles) {
      obstacle.update();
    }
  }
  
  public void draw() {
    // Drawt alle GameObjects in de Arraylist 'listOfGameObjects'.  
    for(GameObject obstacle : listOfObstacles) {
      obstacle.drawObject();
    }
  }
  
  public void addObject(GameObject object) {
    listOfObstacles.add(object);
  }
}