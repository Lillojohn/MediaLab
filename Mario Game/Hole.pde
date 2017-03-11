class Hole extends Obstacle {
  public Hole(int xPosition, int yPosition, int widthImage, int heightImage, Game game) {
    super(xPosition, yPosition, widthImage, heightImage, game);
    _img = loadImage("block.jpg");
  }
}