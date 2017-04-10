class Hole extends Obstacle implements ICollidable{
  
  private Game _game;
  
  public Hole(int xPosition, int yPosition, int widthImage, int heightImage, Game game) {
    super(xPosition, yPosition, widthImage, heightImage, game);
    _game = game;
    _img = loadImage("Assets/HoleGround.png");
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