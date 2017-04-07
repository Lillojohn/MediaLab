import java.util.concurrent.ThreadLocalRandom;

class ObstacleManager {
  
  private ArrayList<Obstacle> _obstacleList;
  private MarioGame _game;
  private GameCharacter _character;
  private boolean _resume;
  private int _maxObstacles;
  private int _obstacleCountWithDeletedObstacles;
  
  public ObstacleManager(MarioGame game, GameCharacter character){
    _obstacleList = new ArrayList<Obstacle>();
    _game = game;
    _character = character;
    _resume = false;
    _maxObstacles = 3;
    _obstacleCountWithDeletedObstacles = 0;
  }
  
  public void update(){
      // Update alle Obstacles in de Arraylist '_obstacleList'.  
      for(Obstacle obstacle : _obstacleList) {
        obstacle.update();
      }
           
      ManageObstacles();      
      
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
  
  public void ManageObstacles(){
    if(_obstacleList.size() < _maxObstacles){
      AddObstacle();
    }
    
    if(_obstacleCountWithDeletedObstacles > Math.pow(2, _maxObstacles)){
      _maxObstacles++;
    }
  }
  
  
  public void AddObstacle(){
    _obstacleCountWithDeletedObstacles++;
    _resume = false;
    
    int xPosition = width + ThreadLocalRandom.current().nextInt(0, 400 + 100);
    
    //if(_obstacleList.size() != 0){
    //  xPosition = (int)_obstacleList.get(_obstacleList.size() - 1).GetXPosition() + ThreadLocalRandom.current().nextInt((width/2), 200 + 1);
    //}
    
    tripleBlock(xPosition);
  }
  
  public void singleBlock(int xPosition){
    _obstacleList.add(new Stone(xPosition, height - 275, 0, 0, _game));
  }
  
  public void doubleBlock(int xPosition){
    _obstacleList.add(new Stone(xPosition, height - 275, 0, 0, _game));
    _obstacleList.add(new Stone(xPosition+75, height - 275, 0, 0, _game));
  }
  
  public void tripleBlock(int xPosition){
    _obstacleList.add(new Stone(xPosition, height - 275, 0, 0, _game));
    _obstacleList.add(new Stone(xPosition+75, height - 275, 0, 0, _game));
    _obstacleList.add(new Stone(xPosition+75, height - 350, 0, 0, _game));
  }
  
  public void CheckDifferenceBetweenObstacleAndMario(){
    for(Obstacle obstacle : _obstacleList) {
        float differenceBetweenMarioAndObstacle = obstacle.GetXPosition() - _character.GetXPosition();
        jumpAlarm(differenceBetweenMarioAndObstacle);
     }
  }
  
  public void jumpAlarm(float differenceBetweenMarioAndObstacle){
    float maxDifference = 200;
     if(differenceBetweenMarioAndObstacle < maxDifference &&  differenceBetweenMarioAndObstacle >= 0 && _resume == false){
       float percentage =  (float)100 - (100 / maxDifference * differenceBetweenMarioAndObstacle) ;
       _game.SetJumpPercentage(percentage);
     }
  }
  
  public void setResumeIsTrue(float percentage){
    if(percentage > 75){
      _resume = true;  
    }
  }
  
}