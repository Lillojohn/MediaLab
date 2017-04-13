class GameThumbnail extends GameObjectFix {
  public boolean selected = false;
  private int _maxWidth;
  private int _minWidth;
  private LevelNumber _LevelNumber;
  
  public GameThumbnail(String thumbnail, int xPosition, int yPosition, int widthImage, int heightImage) {
    super(xPosition, yPosition, widthImage, heightImage);
    this._img = loadImage(thumbnail);
    this._img.resize(widthImage, heightImage);
    this._maxWidth = widthImage + widthImage/8;
    this._minWidth = widthImage;
    
    // Initiate level number
    int levelWidth = 65;
    int levelHeight = 65;
    int levelXPosition = xPosition + widthImage/2 - levelWidth/2;
    int levelYPosition = yPosition - levelHeight/2;
    
    this._LevelNumber = new LevelNumber("1", levelXPosition, levelYPosition, levelWidth, levelHeight);
  }
  
  public void update() {
    super.update();
    
    this.selected = this.isSelected();
    
    // if(this.selected && this._width <= this._maxWidth) {
    //   this.grow();
    // } else if(!this.selected && this._width >= this._minWidth) {
    //   this.minimize();
    // }
    
    // Update LevelNumber
    this._LevelNumber.update(this._position, this._width);
    
    this.updatePosition();
  }
  
  public void draw() {
    
    if(this.selected) {
      tint(255, 255);
      //this.grow();
    } else if(!this.selected) {
      tint(255, 127);
    }
    
    super.draw();
    
    this._LevelNumber.draw();
  }
  
  public void updatePosition() {
    float targetX = this._position.x - 4;
    float dx = targetX - this._position.x;
    this._position.x += dx; 
  }
  
  private void grow() {
    this._height += 1;
    this._width += 2;
    this._position.y -= 0.5;
    this._position.x -= 1;
  }
  
  private void minimize() {
    this._height -= 1;
    this._width -= 2;
    this._position.y += 0.5;
    this._position.x += 1;
  }
  
  public boolean isSelected() {
    float leftPositionX = this._position.x;
    float rightPositionX = this._position.x + this._width;
    int middle = width/2;
    
    if((int) leftPositionX < middle && (int) rightPositionX > middle) {
      return true;
    }
    
    return false;
  }
  
  public PVector getPosition() {
    return this._position;
  }
  
  public int getWidth() {
    return this._width;
  }
}