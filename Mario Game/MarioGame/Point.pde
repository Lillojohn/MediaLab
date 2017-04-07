class Point extends GameObject implements ICollidable{
  
  private MarioGame _game;
  private boolean _outOfScreen;
  
  public Point(int xPosition, int yPosition, int widthImage, int heightImage, MarioGame game) {
    super(xPosition, yPosition, widthImage, heightImage, game);
    _game = game;
    _img = loadImage("Assets/Munt.png");
    _width = 40;
    _height = 40;
    _img.resize(_width, _height);
    _outOfScreen = false;
  }
  
  public void Update(){
    CheckIfOutOfScreen();
    _position.x -= 1;
  }
  
  public float getPositionX(){
    return _position.x;
  };
  
  public float getPositionY(){
    return _position.y;
  };
  
  public int getWidth(){
    return _width;
  };
  
  public int getHeight(){
    return _height;
  };
  
  public void subscribeToCollidableObjects(){
    
  }
  
  public void CheckIfOutOfScreen(){
    if(_position.x == (0-_width)){
      _outOfScreen = true;
    }
  }
  
  public boolean GetOutOfScreen(){
    return _outOfScreen;
  }
}