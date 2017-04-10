class Point extends GameObject implements ICollidable{
  
  private Game _game;
  private boolean _outOfScreen;
  private boolean _hit;
  
  public Point(int xPosition, int yPosition, int widthImage, int heightImage, Game game) {
    super(xPosition, yPosition, widthImage, heightImage, game);
    _game = game;
    _img = loadImage("Assets/Munt.png");
    _width = 40;
    _height = 40;
    _img.resize(_width, _height);
    _outOfScreen = false;
    _hit = false;
  }
  
  public void Update(){
    CheckIfOutOfScreen();
    _position.x -= 2;
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
  
  public void SetHit(){
    _hit = true;
    _img = null;
  }
  
  public void CheckIfOutOfScreen(){
    if(_position.x == (0-_width)){
      _outOfScreen = true;
    }
  }
  
  public boolean GetOutOfScreen(){
    return _outOfScreen;
  }
  
  public boolean GetHit(){
    return _hit;
  }
}