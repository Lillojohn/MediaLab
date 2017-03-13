class Block extends Floor {
  
  public Block(int xPosition, int yPosition, int widthImage, int heightImage, MarioGame game) {
    super(xPosition, yPosition, widthImage, heightImage, game);
    _img = loadImage("block.jpg");
  }
}