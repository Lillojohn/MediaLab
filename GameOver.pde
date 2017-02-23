class GameOver extends GameObject {
  public GameOver(int xPosition, int yPosition, int widthImage, int heightImage, Game game){
    super(xPosition, yPosition, widthImage, heightImage, game);
    _img = loadImage("gameover.png");
  }
  
  public void drawObject(){
    super.drawObject();
  }
}