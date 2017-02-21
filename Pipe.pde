class Pipe extends gameObject{
  
  private int _pipeTravelSpeed;
  
  public Pipe(int xPosition, int yPosition, int widthImage, int heightImage){
      super(xPosition, yPosition, widthImage, heightImage);
      _img = loadImage("fb-pipes.png");
      _pipeTravelSpeed = 5;
      _xPosition = _xPosition * 4;
  }
  
  public void update(){
      //_pipeTravelSpeed = _pipeTravelSpeed + _pipeTravelSpeed;
      //println(_pipeTravelSpeed );
      println(_xPosition);
  }
  
  public void drawObject(){
      super.drawObject();
  }
 
}