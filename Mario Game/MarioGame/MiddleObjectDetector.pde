class MiddleObjectDetector implements IUpdate{
  
  private MarioGame _game;
  private CollidableObjects _collidableobjects;
  private GameCharacter _character;
  
  public MiddleObjectDetector(MarioGame game, CollidableObjects collidableobjects, GameCharacter character) {
    _game = game;
    _collidableobjects = collidableobjects;
    _character = character;
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
    ICollidable highestObject = null;
    for(ICollidable object : GetCollidableObjects()) {
      if(object.getPositionX() + object.getWidth() > _character.GetXPosition() + 20 && object.getPositionX() < _character.GetXPosition() + _character.GetWidth() - 40){
          highestObject = object;
      }
    }
    
    SendObjectToCharacter(highestObject);
  }
  
  public void SendObjectToCharacter(ICollidable object){
    _character.SetCurrentCollidableObject(object);
  }
}