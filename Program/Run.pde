class Run implements Animation {
  private GameCharacter _character;
  private float _timer;
  private int _xChangeCount;
  
  public Run(GameCharacter character){
    _character = character;
    _timer = 0;
  }
  
  public void changeImage(int spriteFrame){
    _character.changeImage(spriteFrame); 
  };
  
  public void changeAnimation() {    
    _timer++;
    
    
    if(_xChangeCount > 23){
      changeImage(2);
      _timer = 0;
      _xChangeCount = 0;
    }
    
    if(_timer > 0){
      changeImage(_xChangeCount);
      _timer = 0;
      _xChangeCount++;
    }     
  };
}