class Block extends Floor {
  
  public Block(int xPosition, int yPosition, int widthImage, int heightImage, Game game) {
    super(xPosition, yPosition, widthImage, heightImage, game);
    _img = loadImage("block.jpg");
  }
}