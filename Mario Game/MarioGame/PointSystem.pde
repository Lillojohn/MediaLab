class PointSystem implements IUpdate{
  
  private MarioGame _game;
  private int _totalPoints;
  private int _goal;
  private MusicScoreNote _musicScoreNote;
  
  public PointSystem(MarioGame game){
    _game = game;
    AddToUpdateList();
    _totalPoints = 0;
    _goal = 25;
    _musicScoreNote = new MusicScoreNote(width - 180, 55, 30, 30, game);
  }
  
  public void Update(){
    DrawScore(width - 150, 80);
    DrawGoal(100, 80);
    if(_goal == _totalPoints){
      GameComplete();
    }
  }
  
  public void DrawScore(int x, int y){
    textSize(32);
    text(_totalPoints, 10 + x, y);
    fill(101, 22, 17 );
    text("/", 50 + x, y);
    text(_goal, 70 + x, y);
  }
  
  public void DrawGoal(int x, int y){
    textSize(32);
    text("Verzamel", width / 2 - x, y);
    fill(255,255,255 );
    textSize(50);
    text(_goal + "Coins", width / 2 - x - 40, y + 50);
  }
    
  public void AddToUpdateList(){
    _game.AddToUpdateList(this);
  }
  
  public void addPoint(){
    _totalPoints++;
    println(_totalPoints);
  }
  
  public void GameComplete(){
    
  }
}