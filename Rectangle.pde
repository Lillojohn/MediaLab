class Rectangle {
  
  private int _x;
  private int _y;
  private int _width;
  private int _height;
  private HashMap<String, Integer> map = new HashMap<String, Integer>();
  
  public Rectangle(int x, int y, int rectangleWidth, int rectangleHeight){
    _x = x;
    _y = y;
    _width = rectangleWidth;
    _height = rectangleHeight;
    setHashMap();
  }
  
  
  public void setRectangle(int x, int y, int rectangleWidth, int rectangleHeight){
    _x = x;
    _y = y;
    _width = rectangleWidth;
    _height = rectangleHeight;    
    setHashMap();
  }
  
  public void setHashMap(){
    map.put("x", _x);
    map.put("y", _y);
    map.put("rectangleWidth", _width);
    map.put("rectangleHeight", _height);
  }
  
  public HashMap getRectangleHasMap(){
    return map;
  }
}