class Background extends GameObject{
  public Background(int xPosition, int yPosition, int widthImage, int heightImage, Game game){
    super(xPosition, yPosition, widthImage, heightImage, game);
    _img = loadImage("fb-bg.png");;
  }
  
  public void drawObject(){
    super.drawObject();
  }
}