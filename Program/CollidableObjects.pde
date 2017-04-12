class CollidableObjects {
  
  private ArrayList<ICollidable> _collidableObjects;

  public CollidableObjects(){
    _collidableObjects = new ArrayList<ICollidable>();
  }
  
  public void AddToList(ICollidable object){
    _collidableObjects.add(object);
  }
  
  public ArrayList<ICollidable> GetICollidableList(){
    return _collidableObjects;
  }
  
}