class PointSystem implements IUpdate{
  
  private MarioGame _game;
  public PointSystem(MarioGame game){
    _game = game;
    AddToUpdateList();
    
  }
  
  public void Update(){
   
  }
    
  public void AddToUpdateList(){
    _game.AddToUpdateList(this);
  }
  
  
    
}