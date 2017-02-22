class GameObject{
  protected PImage _img;
  protected int _xPosition;
  protected int _yPosition;
  protected int _width;
  protected int _height;
  
  public GameObject(int xPosition, int yPosition, int widthImage, int heightImage){
    _img = null;
    _xPosition = xPosition;
    _yPosition = yPosition;
    _width = widthImage;
    _height = heightImage;
  }
  
  public void update(){
    
  }
  
  public void drawObject(){
    image (_img, _xPosition, _yPosition, _width, _height);
  }
}