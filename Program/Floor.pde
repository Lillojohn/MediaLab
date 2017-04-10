class Floor extends GameObject {
  public Floor(int xPosition, int yPosition, int widthImage, int heightImage, Game game) {
    super(xPosition, yPosition, widthImage, heightImage, game);
  }
  
  public void update() {
    _position.x -= 1;
  }
}