class Jump implements Animation {
  private GameCharacter _character;
  
  public Jump(GameCharacter character){
    _character = character;
    changeImage(24);
  }
  
  public void changeImage(int spriteFrame){
    _character.changeImage(spriteFrame);
  };
  
  public void changeAnimation() {
    
  };
}