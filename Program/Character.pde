class GameCharacter extends GameObject implements IUpdate {
  
    private ArrayList<PImage> _spriteSheetBrokenDownInPieces;
    private Animation _animation;
    private float _gravity;
    private Game _game;
    private ICollidable _currentColidableObject;
    private int _jumpTimer;
    private boolean _jump;
    private float _jumpPower;
    private float _gravityEmplifyer;
    private PointSystem _pointSystem;
  
    public GameCharacter(int xPosition, int yPosition, int widthImage, int heightImage, Game game, PointSystem pointSystem){
      super(xPosition, yPosition, widthImage, heightImage, game);
      this._pointSystem = pointSystem;
      _game = game;
      AddToUpdateList();
      _spriteSheetBrokenDownInPieces = new ArrayList<PImage>();
      MakeSpriteSheetArray();
      _animation = new Run(this);
      _gravity = .3;
      _jumpTimer = 0;
      _jump = false;
      _jumpPower = 8;
      _gravityEmplifyer = 0;
    }
    
    public void MakeSpriteSheetArray(){
      for(int i = 0; i < 25; i++){
        PImage _pimage = loadImage("Assets/nick-sprite.png");
        _pimage = _pimage.get(i*170,0,160,350);
        _pimage.resize(80,175);
        _spriteSheetBrokenDownInPieces.add(_pimage);
      }
    }
    
    public void Update(){
      _animation.changeAnimation();

      if (!GravityEffect()) {
        _velocity.y += _gravity;
      } 

      if (GravityEffect()) {
        _velocity.y = 0; 
      }

      if(!GravityEffect() && !JumpEffect()){
        _animation = new Run(this);
        _jump = false;
      }
      
      // If on the ground and "jump" keyy is pressed set my upward velocity to the jump speed!
      if (GravityEffect() && _jump != false)
      {
        _velocity.y = -_jumpPower;
      }
      
      // We check the nextPosition before actually setting the position so we can
      // not move the oldguy if he's colliding.
      PVector nextPosition = new PVector(_position.x, _position.y);
      nextPosition.add(_velocity);
      
      _position.y = nextPosition.y;

      
      _jumpTimer++;
    }
    
    public void AddToUpdateList(){
      _game.AddToUpdateList(this);
    }
    
    public void Jump(){
      if(!_jump){
        this._pointSystem.addJump();
        _animation = new Jump(this);
        _jumpTimer = 0;
        _gravityEmplifyer = 0;
        _jump = true;
      }
    }
    
    public boolean JumpEffect(){
       if(!_jump){
        return false;
      }
      
      if(_jumpTimer > 40){
        return false;
      }
     
      return true;
    }
    
    public void SetCurrentCollidableObject(ICollidable object){
      _currentColidableObject = object;
    }
    
    public boolean GravityEffect(){
      if(_currentColidableObject == null){
        return false;
      }

      if(_currentColidableObject.getPositionY() > _position.y + _height - 15){
          return false;
      }
      
      
      return true;
    }
    
    
    public void changeImage(int spriteFrame){
      _img = _spriteSheetBrokenDownInPieces.get(spriteFrame);
    }
    
    public float GetXPosition(){
      return _position.x;
    }
    
    public float GetYPosition(){
      return _position.y;
    }
    
    public float GetWidth(){
      return _width;
    }
    
    public float GetHeight(){
      return _height;
    }
}