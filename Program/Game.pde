class Game implements IState {
  private GameCharacter character;
  private ArrayList<GameObject> listOfGameObjects;
  private ObstacleManager _obstacleManager;
  private float _jumpPercentage;
  private Ground _ground;
  private MiddleObjectDetector _middleObjectDetector;
  private CollidableObjects _collidableObjects;
  private ArrayList<IUpdate> _objectsThatUpdate;
  private PImage _background;
  private PointManager _pointmanager;
  private PointSystem _pointSystem;
  private color _mainColor;
  private Program _program;
  private TimeSystem _timesystem;
  
  public Game(Program program) {
    noTint();

    // Get background image and color.
    this._background = loadImage("assets/background.jpg");
    this._background.resize(width, height);
    this._mainColor = color(160, 5, 28);

    this._program = program;

    _objectsThatUpdate = new ArrayList<IUpdate>();
    listOfGameObjects = new ArrayList<GameObject>();
    _collidableObjects =  new CollidableObjects();
    _jumpPercentage = 0;

    _pointSystem = new PointSystem(this, _program);   
    
    //currentLevel = new LevelLayer(this);
    character = new GameCharacter((width/2) - 20, 330, 80, 175, this, _pointSystem);
    
    _obstacleManager = new ObstacleManager(this, character);
    _ground = new Ground(0,height - 200, width, 200, this);
    
    _middleObjectDetector = new MiddleObjectDetector(this, _collidableObjects, character);
    
    _pointmanager = new PointManager(this, character, _pointSystem);
    this._timesystem = new TimeSystem(this);
  }
  
  public void update() {
    println(frameRate);

    if(_jumpPercentage < 81) {
      // Drawt alle GameObjects in de Arraylist 'listOfGameObjects'.  
      for(IUpdate object : _objectsThatUpdate) {
        object.Update();
      }
    }
  }
  
  public void draw() {
    background(this._mainColor);
    background(this._background);

    // Drawt alle GameObjects in de Arraylist 'listOfGameObjects'.  
    for(GameObject object : listOfGameObjects) {
      object.drawObject();
    }
  }
 
  public void keyPressHandle(char key) {
    if (key == ' ')
    {
      _obstacleManager.setResumeIsTrue(_jumpPercentage);
      _jumpPercentage = 0; 
      character.Jump();
    }
  }
  
  public void keyReleaseHandle(char key) {
    
  }
  
  public void action(String action) {
    if (action == "jump") {
      _obstacleManager.setResumeIsTrue(_jumpPercentage);
      _jumpPercentage = 0; 
      character.Jump();
    }
  }

  public int GetGameTime(){
    return this._timesystem.GetGameTime();
  }

  public void SetJumpPercentage(float percentage){
    _jumpPercentage = percentage;
  }

  // Voeg een GameObject of kind daarvan toe aan de ArrayList 'listOfGameObjects'.
  public void addToGameObjectList(GameObject object){
    listOfGameObjects.add(object);
  }

  public void addToCollidableObjects(ICollidable object){
    _collidableObjects.AddToList(object);
  }

  public void AddToUpdateList(IUpdate object){
    _objectsThatUpdate.add(object);
  }
}