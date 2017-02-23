class Bird extends GameObject implements ICollision{
  
  private int _flySpeed;
  private int _gravity;
  private Rectangle rectangle;
  
  public Bird(int xPosition, int yPosition, int widthImage, int heightImage, Collision collision, Game game){
    super(xPosition, yPosition, widthImage, heightImage, game);
    _img = loadImage("fb-bird.png");
    _flySpeed = 20;
    _gravity = 3;
    rectangle = new Rectangle(xPosition, yPosition, widthImage, heightImage);
    collision.addObject(this);
  }
  
  public void update(){
    
    // Laat de vogel vlieg bij het returnen van true;
    if (keySpacebar()) {
        fly();
    }
    
    gravity();
    blockFloor();
   rectangleUpdate();
  }
  
  // Hiermee wordt de rectangle van de vogel geupdate.
  public void rectangleUpdate(){
    rectangle.setRectangle(_xPosition, _yPosition, _width, _width);
  }
  
  public HashMap getRectangleHashMap(){
    return rectangle.getRectangleHasMap();
  }
  
  // Als er op de spatiebalk wordt gedrukt dan wordt er true gereturned.
  public boolean keySpacebar(){
    if (!keyPressed) {
      return false;
    }
    
    if (key != ' ') {
      return false;
    }
    
    return true;
  }
  
  // Maakt het mogelijk te vliegen voor de vogel.
  public void fly(){
    _yPosition = _yPosition - _flySpeed;
  }
  
  public void gravity(){
    _yPosition = _yPosition + _gravity;
  }
  
  // Hierdoor kan de vogel niet verder vallen dan de onderkant van het scherm.
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