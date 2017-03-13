class GameObject{
  protected PImage _img;
  protected PVector _position;
  protected PVector _velocity;
  protected int _width;
  protected int _height;
  
  public GameObject(int xPosition, int yPosition, int widthImage, int heightImage, MarioGame game){
    _img = null;
    _position = new PVector(xPosition, yPosition);
    _velocity = new PVector(0, 0);
    _width = widthImage;
    _height = heightImage;
    
    // Hiermee worden de GameObjects toegevoegd aan de GameObjectList.
    game.addToGameObjectList(this);
  }
  
  public void update(){
    
  }
  
  public void drawObject(){
    image (_img, _position.x, _position.y, _width, _height);
  }
}