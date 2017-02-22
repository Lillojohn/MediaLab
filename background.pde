class Background extends GameObject{
  public Background(int xPosition, int yPosition, int widthImage, int heightImage){
    super(xPosition, yPosition, widthImage, heightImage);
    _img = loadImage("fb-bg.png");;
  }
  
  public void drawObject(){
    super.drawObject();
  }
}