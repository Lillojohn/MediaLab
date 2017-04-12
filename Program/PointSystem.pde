class PointSystem implements IUpdate{
  
  private Game _game;
  private int _totalPoints;
  private int _goal;
  private MusicScoreNote _musicScoreNote;
  private Program _program;
  private PFont _font;
  
  public PointSystem(Game game, Program program){
    this._program = program;
    this._font = loadFont("BrandonGrotesque-BlackItalic-120.vlw");
    textFont(this._font, 32);
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
    text(_goal + " Coins", width / 2 - x - 40, y + 50);
  }
    
  public void AddToUpdateList(){
    _game.AddToUpdateList(this);
  }
  
  public void addPoint(){
    _totalPoints++;
  }
  
  public void GameComplete(){
    _program.changeState(new EndScreen(0, 0, _totalPoints, _program));
  }
}