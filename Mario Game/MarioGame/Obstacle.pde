class Obstacle extends GameObject implements IUpdate {
  
  private boolean _outOfScreen;
  private MarioGame _game;
  
  public Obstacle(int xPosition, int yPosition, int widthImage, int heightImage, MarioGame game) {
    super(xPosition, yPosition, widthImage, heightImage, game);
    _game = game;
    AddToUpdateList();
    _outOfScreen = false;
  }
  
  public void Update() {
    _position.x -= 1;
    CheckIfOutOfScreen();
  }
  
  public void AddToUpdateList(){
      _game.AddToUpdateList(this);
  }
  
  public void CheckIfOutOfScreen(){
    if(_position.x == (0-_width)){
      _outOfScreen = true;
    }
  }
  
  public float GetXPosition(){
    return _position.x ;
  }
  
  public boolean GetOutOfScreen(){
    return _outOfScreen;
  }
}