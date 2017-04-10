int X_POSITION = 0;
int Y_POSITION = 1;

class LevelNumber extends GameObjectFix {
  public LevelNumber(String level, int xPosition, int yPosition, int widthImage, int heightImage) {
    super(xPosition, yPosition, widthImage, heightImage);
    
    this._img = requestImage("assets/levelNumber.png");
  }
  
  public void update(PVector parentPosition, int parentWidth) {
    this._position.x = CalculatePosition(0, parentPosition, parentWidth);
    this._position.y = CalculatePosition(1, parentPosition, parentWidth);
  }
  
  public void draw() {
    super.draw();
    //stroke(0);
    //fill(77, 194, 255);
    //ellipse(this._position.x, this._position.y, this._width, this._height);
  }
  
  public float CalculatePosition(int axis, PVector parentPosition, int parentWidth) {
    if(axis == X_POSITION) {
      return parentPosition.x + parentWidth/2 - this._width/2;
    } else if (axis == Y_POSITION) {
      return parentPosition.y - this._height/2;
    }
    return 0;
  }
}