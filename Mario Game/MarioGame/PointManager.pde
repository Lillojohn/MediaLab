class PointManager implements IUpdate {
  private ArrayList<Point> _pointList;
  private MarioGame _game;
  private int _pointTimer;
  private GameCharacter _character;
  private PointSystem _pointSystem;
  
  public PointManager(MarioGame game, GameCharacter character, PointSystem pointSystem){
    _game = game;
    AddToUpdateList();
    _character = character;
    _pointTimer = 0;
    _pointList = new ArrayList<Point>();
    _pointSystem = pointSystem;
  }
  
  public void Update(){
    if(PointTiming()){
      spawnPoint();
      _pointTimer = 0;
    }
    
    for(Point object : _pointList) {
      object.Update();
    }
    
    CheckCollissionWithCharacter();
    
    clearPoints();
    
    _pointTimer++;
  }
  
  public boolean PointTiming(){
    if(_pointTimer < 100){
      return false;
    }
    
    return true;
  }
  
  public void CheckCollissionWithCharacter(){
     for(Point object : _pointList){
       if(object.getPositionX() + object.getWidth() > _character.GetXPosition() + 20 && 
          object.getPositionX() < _character.GetXPosition() + _character.GetWidth() - 20 &&
          object.getPositionY() + object.getHeight() > _character.GetYPosition() + 20&& 
          object.getPositionY() < _character.GetYPosition() + _character.GetHeight() - 20){
         object.SetHit();
         AddPoint();
       }
     }
  }
  
  public void AddPoint(){
    _pointSystem.addPoint();
  }
  
  // Kijkt naar alle points als er iets vernietigd moet worden.
  public void clearPoints(){
    for(int i = 0; i < _pointList.size(); i++) {
       if(_pointList.get(i).GetOutOfScreen()){
         destroyPoins(i);
       }
       if(_pointList.get(i).GetHit()){
         destroyPoins(i);
       }
    }
  }
  
  // Vernietigd 'points'.
  public void destroyPoins(int index){
    println(index);
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