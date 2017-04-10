class GameObjectFix{
  protected PImage _img;
  protected PVector _position;
  protected PVector _velocity;
  protected int _width;
  protected int _height;
  
  public GameObjectFix(int xPosition, int yPosition, int widthImage, int heightImage){
    _img = null;
    _position = new PVector(xPosition, yPosition);
    _velocity = new PVector(0, 0);
    _width = widthImage;
    _height = heightImage;
  
  }
  
  public void update(){
    
  }

  public void draw() {
    try {
      image (_img, _position.x, _position.y, _width, _height); 
    } catch (Exception e){
      
    }
  }  
}