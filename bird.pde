class Bird extends GameObject{
  
  private int _flySpeed;
  private int _gravity;
  
  public Bird(int xPosition, int yPosition, int widthImage, int heightImage){
    super(xPosition, yPosition, widthImage, heightImage);
    _img = loadImage("fb-bird.png");
    _flySpeed = 2;
    _gravity = 1;
  }
  
  public void update(){
    
  }
  
  public void fly(){
    _yPosition = _yPosition + _flySpeed;
  }
  
  public void gravity(){
    
  }
  
  void keyPressed() {
    // Als de space geklikt, dan doe je ding
    if (key == ' ') { // = space
      // spring omhoog
      fly();
    }
  }
  
  public void blockFloor(){
    
  }
  
  
  public void drawObject(){
    super.drawObject();
  }
  
}