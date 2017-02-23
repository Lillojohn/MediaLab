class Bird extends GameObject implements ICollision{
  
  private int _flySpeed;
  private int _gravity;
  private Rectangle rectangle;
  
  public Bird(int xPosition, int yPosition, int widthImage, int heightImage, Collision collision){
    super(xPosition, yPosition, widthImage, heightImage);
    _img = loadImage("fb-bird.png");
    _flySpeed = 20;
    _gravity = 3;
    rectangle = new Rectangle(xPosition, yPosition, widthImage, heightImage);
    collision.addObject(this);
  }
  
  public void update(){
    if (keySpacebar()) {
        fly();
    }
    
    gravity();
    blockFloor();
    rectangleUpdate();
  }
  
  public void rectangleUpdate(){
    rectangle.setRectangle(_xPosition, _yPosition, _width, _width);
  }
  
  public HashMap getRectangleHashMap(){
    return rectangle.getRectangleHasMap();
  }
  
  public boolean keySpacebar(){
    if (!keyPressed) {
      return false;
    }
    
    if (key != ' ') {
      return false;
    }
    
    return true;
  }
  
  public void fly(){
    _yPosition = _yPosition - _flySpeed;
  }
  
  public void gravity(){
    _yPosition = _yPosition + _gravity;
  }
  
  public void blockFloor(){
    if((_yPosition - _height) > height){
      _yPosition = height - _height;
    }
  }
  
  
  public void drawObject(){
    super.drawObject();
  }
  
  public void collision(){
    bird._flySpeed = 0;
  }
}