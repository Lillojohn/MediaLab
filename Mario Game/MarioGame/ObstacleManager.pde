class ObstacleManager {
  
  private ArrayList<Obstacle> _obstacleList;
  private MarioGame _game;
  private Mario _mario;
  
  public ObstacleManager(MarioGame game, Mario mario){
    _obstacleList = new ArrayList<Obstacle>();
    _game = game;
    _mario = mario;
    AddObstacle();
  }
  
  public void update(){
      // Update alle Obstacles in de Arraylist '_obstacleList'.  
      for(Obstacle obstacle : _obstacleList) {
        obstacle.update();
      }
      
      clearObstacles();
      
      CheckDifferenceBetweenObstacleAndMario();
  }
  
  // Kijkt naar alle pipes als er iets vernietigd moet worden.
  public void clearObstacles(){
    for(int i = 0; i < _obstacleList.size(); i++) {
       if(_obstacleList.get(i).GetOutOfScreen()){
         destroyObstascle(i);
       }
    }
  }
  
  // Vernietigd 'obstacle'.
  public void destroyObstascle(int index){
    _obstacleList.remove(index);
  }
  
  
  public void AddObstacle(){
    _obstacleList.add(new Stone(400, 350, 20, 20, _game));
  }
  
  public void CheckDifferenceBetweenObstacleAndMario(){
    for(Obstacle obstacle : _obstacleList) {
        float differenceBetweenMarioAndObstacle = obstacle.GetXPosition() - _mario.GetXPosition();
        jumpAlarm(differenceBetweenMarioAndObstacle);
     }
  }
  
  public void jumpAlarm(float differenceBetweenMarioAndObstacle){
    float maxDifference = 200;
     if(differenceBetweenMarioAndObstacle < maxDifference){
       float percentage =  (float)100 - (100 / maxDifference * differenceBetweenMarioAndObstacle) ;
       _game.SetJumpPercentage(percentage);
     }
  }
}