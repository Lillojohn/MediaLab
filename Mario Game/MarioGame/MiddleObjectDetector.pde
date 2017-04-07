class MiddleObjectDetector implements IUpdate{
  
  private MarioGame _game;
  private CollidableObjects _collidableobjects;
  
  public MiddleObjectDetector(MarioGame game, CollidableObjects collidableobjects) {
    _game = game;
    _collidableobjects = collidableobjects;
    AddToUpdateList();
  }
  
  public void Update(){
    checkCollidableObjectsInMiddle();
  }
  
  public void AddToUpdateList(){
      _game.AddToUpdateList(this);
  }
  
  public ArrayList<ICollidable> GetCollidableObjects(){
    return _collidableobjects.GetICollidableList();
  }
  
  public void checkCollidableObjectsInMiddle(){
    for(ICollidable object : GetCollidableObjects()) {
      println(object.getPositionX() - object.getPositionY());
    }
  }
}