class Mario extends GameObject {
  private int jump;
  private float _gravity;
  private int _ground;
  private int _jumpSpeed;
  
  public Mario(int xPosition, int yPosition, int widthImage, int heightImage, MarioGame game) {
    super(xPosition, yPosition, widthImage, heightImage, game);
    _img = loadImage("mariostand.png");
    _gravity = .3;
    _ground = 340;
    _jumpSpeed = 10;
    jump = 0;
  }
  
  public void drawObject() {
    super.drawObject();
  }
  
  public void update() {
    
    if (_position.y < _ground) {
      _velocity.y += _gravity;
    } else {
      _velocity.y = 0; 
    }
    
    // If on the ground and "jump" keyy is pressed set my upward velocity to the jump speed!
    if (_position.y >= _ground && jump != 0)
    {
      _velocity.y = -_jumpSpeed;
    }
    
    // We check the nextPosition before actually setting the position so we can
    // not move the oldguy if he's colliding.
    PVector nextPosition = new PVector(_position.x, _position.y);
    nextPosition.add(_velocity);
    
    _position.y = nextPosition.y;
  
    translate(_position.x, _position.y);
    scale(0,1);
  }
  
  public void changeSpriteSpreadsheet(){
    
  }
  
  public float GetXPosition(){
    return _position.x ;
  }
  
  
  
}