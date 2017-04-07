class PointManager implements IUpdate {
  private ArrayList<Point> _pointList;
  private MarioGame _game;
  private int _pointTimer;
  
  public PointManager(MarioGame game, GameCharacter character){
    _game = game;
    AddToUpdateList();
    _pointTimer = 0;
    _pointList = new ArrayList<Point>();
  }
  
  public void Update(){
    if(PointTiming()){
      spawnPoint();
      _pointTimer = 0;
    }
    
    for(Point object : _pointList) {
      object.Update();
    }
    _pointTimer++;
  }
  
  public boolean PointTiming(){
    if(_pointTimer < 100){
      return false;
    }
    
    return true;
  }
  
  // Kijkt naar alle points als er iets vernietigd moet worden.
  public void clearPoints(){
    for(int i = 0; i < _pointList.size(); i++) {
       if(_pointList.get(i).GetOutOfScreen()){
         destroyPoins(i);
       }
    }
  }
  
  // Vernietigd 'points'.
  public void destroyPoins(int index){
    _pointList.remove(index);
  }
  
  public void AddToUpdateList(){
      _game.AddToUpdateList(this);
  }
  
  public void spawnPoint(){
    int xPosition = width + ThreadLocalRandom.current().nextInt(100, 200 + 1);
    int yPosition = height - 200 - ThreadLocalRandom.current().nextInt(100, 300 + 1);
    _pointList.add(new Point(xPosition, yPosition, 0, 0, _game));
  }
  
}