class Collision {
  private ArrayList<ICollision> collisionObjects;
  
  public Collision(){
    collisionObjects = new ArrayList<ICollision>();
  }
  
  public void ping(){
    for(ICollision object : collisionObjects) {
      object.collision();
    }
    
    
  }
  
  public void addObject(ICollision object){
    collisionObjects.add(object);
  }
  
  public void update(){
    checkForCollisionBetweenBirdandPipes();
  }
  
  public boolean calculateCollision(HashMap mapA, HashMap mapB){
    
    if((int) mapA.get("x") > (int) mapB.get("x") + (int) mapB.get("rectangleWidth")){
      return false;
    }
    
    if((int) mapA.get("x") + (int) mapA.get("rectangleWidth") < (int) mapB.get("x")){
      return false;
    } 
    
    if((int) mapA.get("y") > (int) mapB.get("y") + (int) mapB.get("rectangleHeight")){
      return false;
    }
    
    if((int) mapA.get("y") + (int) mapA.get("rectangleHeight") < (int) mapB.get("y")){
      return false;
    }
    
    return true;
  }
  
  
  public void checkForCollisionBetweenBirdandPipes(){
    for(ICollision object : collisionObjects) {
      if(object instanceof Bird){
        
        for(ICollision objectTwo : collisionObjects) {
          if(object != objectTwo){
            
            HashMap birdMap =  ((Bird)object).getRectangleHashMap();
            
            HashMap pipeMapA = ((Pipe)objectTwo).getRectangleAHashMap();
            HashMap pipeMapB = ((Pipe)objectTwo).getRectangleBHashMap();
            
            if(calculateCollision(birdMap, pipeMapA) || calculateCollision(birdMap, pipeMapB)){
               ping();
            }
            
          }
        }
        
      }
    }
  }
}