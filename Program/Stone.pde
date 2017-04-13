class Stone extends Obstacle implements ICollidable {  
  private Game _game;
  
  public Stone(int xPosition, int yPosition, int widthImage, int heightImage, Game game) {
    super(xPosition, yPosition, widthImage, heightImage, game);
    _game = game;
    _img = loadImage("Assets/BlocksOne.png");
    _width = 90;
    _height = 90;
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