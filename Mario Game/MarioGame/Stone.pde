class Stone extends Obstacle implements ICollidable {  
  private MarioGame _game;
  
  public Stone(int xPosition, int yPosition, int widthImage, int heightImage, MarioGame game) {
    super(xPosition, yPosition, widthImage, heightImage, game);
    _game = game;
    _img = loadImage("Assets/BlocksOne.png");
    _width = 75;
    _height = 75;
    _img.resize(_width, _height);
    subscribeToCollidableObjects();
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
    _game.addToCollidableObjects(this);
  }
}