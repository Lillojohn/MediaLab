class GameCharacter extends GameObject implements IUpdate {
  
    private ArrayList<PImage> _spriteSheetBrokenDownInPieces;
    private Animation _animation;
    private float _gravity;
    private MarioGame _game;
    private ICollidable _currentColidableObject;
    private int _jumpTimer;
    private boolean _jump;
    private float _jumpPower;
    private float _gravityEmplifyer;
  
    public GameCharacter(int xPosition, int yPosition, int widthImage, int heightImage, MarioGame game){
      super(xPosition, yPosition, widthImage, heightImage, game);
      _game = game;
      AddToUpdateList();
      _spriteSheetBrokenDownInPieces = new ArrayList<PImage>();
      MakeSpriteSheetArray();
      _animation = new Run(this);
      _gravity = 1;
      _jumpTimer = 0;
      _jump = false;
      _jumpPower = 6;
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
      if(!GravityEffect()){
        _position.y += _gravityEmplifyer + _gravity;
        
        if(_jumpTimer > 80){
        _gravityEmplifyer += _gravity + (0.5 * _gravityEmplifyer) - _gravityEmplifyer ;
        }
      }
      
      if(!GravityEffect() && !JumpEffect()){
        _animation = new Run(this);   
      }
      
      if(_jumpTimer > 140){
        _jump = false;
      }

      if(JumpEffect()){
        _position.y -= _jumpPower;
      }
      
      _jumpTimer++;
    }
    
    public void AddToUpdateList(){
      _game.AddToUpdateList(this);
    }
    
    public void Jump(){
      if(!_jump){
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