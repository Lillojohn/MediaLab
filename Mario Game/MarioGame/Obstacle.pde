class Obstacle extends GameObject {
  
  private boolean _outOfScreen;
  
  public Obstacle(int xPosition, int yPosition, int widthImage, int heightImage, MarioGame game) {
    super(xPosition, yPosition, widthImage, heightImage, game);
    _outOfScreen = false;
  }
  
  public void update() {
    _position.x -= 1;
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