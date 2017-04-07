class GameCharacter extends GameObject implements IUpdate {
  
    private ArrayList<PImage> _spriteSheetBrokenDownInPieces;
    private Animation _animation;
    private int _gravity;
    private MarioGame _game;
  
    public GameCharacter(int xPosition, int yPosition, int widthImage, int heightImage, MarioGame game){
      super(xPosition, yPosition, widthImage, heightImage, game);
      _game = game;
      AddToUpdateList();
      _spriteSheetBrokenDownInPieces = new ArrayList<PImage>();
      MakeSpriteSheetArray();
      _animation = new Run(this);
      _gravity = 1;
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
      GravityEffect();
    }
    
    public void AddToUpdateList(){
      _game.AddToUpdateList(this);
    }
    
    public void Jump(){
      _animation = new Jump(this);
      
    }
    
    public void GravityEffect(){
      _position.y += _gravity;
    }
    
    
    public void changeImage(int spriteFrame){
      _img = _spriteSheetBrokenDownInPieces.get(spriteFrame);
    }
    
    public float GetXPosition(){
      return _position.x;
    }
}