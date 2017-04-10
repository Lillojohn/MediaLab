import java.util.concurrent.ThreadLocalRandom;

class ObstacleManager implements IUpdate{
  
  private ArrayList<Obstacle> _obstacleList;
  private Game _game;
  private GameCharacter _character;
  private boolean _resume;
  private int _maxObstacles;
  private int _obstacleCountWithDeletedObstacles;

  
  public ObstacleManager(Game game, GameCharacter character){
    _obstacleList = new ArrayList<Obstacle>();
    _game = game;
    AddToUpdateList();
    _character = character;
    _resume = false;
    _maxObstacles = 3;
    _obstacleCountWithDeletedObstacles = 0;
  }
  
  public void Update(){
      // Update alle Obstacles in de Arraylist '_obstacleList'.  
      for(Obstacle obstacle : _obstacleList) {
        obstacle.Update();
      }
           
      ManageObstacles();      
      
      clearObstacles();
      
      CheckDifferenceBetweenObstacleAndMario();
  }
  
  
  public void AddToUpdateList(){
      _game.AddToUpdateList(this);
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
    
    int xPosition = width + 100;
    
    //if(_obstacleList.size() != 0){
    //  xPosition = (int)_obstacleList.get(_obstacleList.size() - 1).GetXPosition() + 300;
    //}
    
    int randomBlock = ThreadLocalRandom.current().nextInt(1, 3 + 1);
    
    if(randomBlock == 1){
      singleBlock(xPosition);
    } 
    
    if(randomBlock == 2){
      doubleBlock(xPosition);
    } 
    
    if(randomBlock == 3){
      tripleBlock(xPosition);
    }     
    
    if(randomBlock == 4){
      Hole(xPosition);
    } 
  }
  
  public void Hole(int xPosition){
    _obstacleList.add(new Hole(xPosition, height - 200, 0, 0, _game));
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
    boolean focusOnOne = false;
    for(Obstacle obstacle : _obstacleList) {
      if(!focusOnOne){
        float differenceBetweenMarioAndObstacle = obstacle.GetXPosition() - (_character.GetXPosition() + _character.GetWidth());
        jumpAlarm(differenceBetweenMarioAndObstacle);
        focusOnOne = true;
      }
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
    if(percentage > 40){
      _resume = true;  
    }
  }
  
}