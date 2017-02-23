class Pipe extends GameObject implements ICollision{
  
  private int _pipeTravelSpeed;
  private boolean _destroy;
  private Rectangle rectangleA;
  private Rectangle rectangleB;
  
  public Pipe(int xPosition, int yPosition, int widthImage, int heightImage, Collision collision){
    super(xPosition, yPosition, widthImage, heightImage);
    _img = loadImage("fb-pipes.png");
    _pipeTravelSpeed = 5;
    _destroy = false;
    rectangleA = new Rectangle(xPosition, yPosition, widthImage, (_height / 10 * 4));
    rectangleB = new Rectangle(xPosition, (heightImage / 10 * 6), widthImage, heightImage);
    collision.addObject(this);
  }
  
  public void rectanglesUpdate(){
    rectangleA.setRectangle(_xPosition, _yPosition, _width, (_height / 10 * 4));
    rectangleB.setRectangle(_xPosition, (_height / 10 * 6), _width, _height);
  }
  
  public HashMap getRectangleAHashMap(){
    return rectangleA.getRectangleHasMap();
  }
  
  public HashMap getRectangleBHashMap(){
    return rectangleB.getRectangleHasMap();
  }
  
  public void update(){
    // Zorgt ervoor dat 'Pipe' beweegt.
    move();
    
    // Checkt als 'Pipe' uit het beeld gaat, als dat zo is vernietigd hij.
    if(outOfScreen()){
      destroy();
    }
    
    rectanglesUpdate();
  }
  
  // Return true als de 'Pipe' uit het beeld gaat.
  public boolean outOfScreen(){
    if(_xPosition > (0 - _width)){
      return false;
    }
    
    return true;
  }
  
  // Geeft aan dat 'Pipe' vertienigd mag worden.
  public void destroy(){
    _destroy = true;
  }
  
  public boolean getDestroy(){
    return _destroy;
  }
  
  public void move(){
    _xPosition = _xPosition - _pipeTravelSpeed;
  }
  
  public void drawObject(){
    super.drawObject();
  }
  
  public void collision(){
    
  }
 
}