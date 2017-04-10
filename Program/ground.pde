class Ground extends GameObject implements ICollidable {
  private Game _game;
  
  public Ground(int xPosition, int yPosition, int widthImage, int heightImage, Game game) {
    super(xPosition, yPosition, widthImage, heightImage, game);
    _img = loadImage("Assets/Ground.png");
    _game = game;
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