class Obstacle extends GameObject {
  
  private boolean _outOfScreen;
  private Game _game;
  
  public Obstacle(int xPosition, int yPosition, int widthImage, int heightImage, Game game) {
    super(xPosition, yPosition, widthImage, heightImage, game);
    _game = game;
    _outOfScreen = false;
  }
  
  public void Update() {
    _position.x -= 2;
    CheckIfOutOfScreen();
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