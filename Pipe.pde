class Pipe extends GameObject{
  
  private int _pipeTravelSpeed;
  private boolean _destroy;
  
  public Pipe(int xPosition, int yPosition, int widthImage, int heightImage){
    super(xPosition, yPosition, widthImage, heightImage);
    _img = loadImage("fb-pipes.png");
    _pipeTravelSpeed = 5;
    _destroy = false;
  }
  
  public void update(){
    // Zorgt ervoor dat 'Pipe' beweegt.
    move();
    
    // Checkt als 'Pipe' uit het beeld gaat, als dat zo is vernietigd hij.
    if(outOfScreen()){
      destroy();
    }
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
 
}