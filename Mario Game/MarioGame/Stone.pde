class Stone extends Obstacle {  
  public Stone(int xPosition, int yPosition, int widthImage, int heightImage, MarioGame game) {
    super(xPosition, yPosition, widthImage, heightImage, game);
    _img = loadImage("stone.png");
  }
}