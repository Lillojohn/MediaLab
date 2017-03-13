class ObstacleManager {
  
  private ArrayList<Obstacle> _obstacleList;
  private MarioGame _game;
  
  public ObstacleManager(MarioGame game){
    _obstacleList = new ArrayList<Obstacle>();
    _game = game;
    AddObstacle();
  }
  
  public void update(){
      // Update alle Obstacles in de Arraylist '_obstacleList'.  
      for(Obstacle obstacle : _obstacleList) {
        obstacle.update();
      }
  }
  
  public void AddObstacle(){
    _obstacleList.add(new Stone(100, 350, 20, 20, _game));
  }
}