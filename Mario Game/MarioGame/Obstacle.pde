class Obstacle extends GameObject {
  public Obstacle(int xPosition, int yPosition, int widthImage, int heightImage, MarioGame game) {
    super(xPosition, yPosition, widthImage, heightImage, game);
  }
  
  public void update() {
    _position.x -= 1;
  }
}