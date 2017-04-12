import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.serial.*; 
import processing.sound.*; 
import java.util.concurrent.ThreadLocalRandom; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Program extends PApplet {



private IState state;
private Serial myPort;  // The serial port

public void setup() {
  frameRate(60);
  
  //size(1200, 675);
  this.state = new Carousel(this);
  
  // List all the available serial ports
  //printArray(Serial.list());
  // Open the port you are using at the rate you want:
  myPort = new Serial(this, Serial.list()[3], 9600);
}

public void update() {
  state.update();   
  
  // Check if port is available and jump is printed in serial.
  while (myPort.available() > 0) {
    String inBuffer = myPort.readString();
    if (inBuffer != null && inBuffer.contains("jump")) {
      this.state.action("jump");
    }
  }
}

public void draw() {
  state.draw(); 
  this.update();
}

public void keyPressed() {
  this.state.keyPressHandle(key);
}

public void keyReleased() {
  this.state.keyReleaseHandle(key);
}

public void changeState(IState state) {
  this.state = state;
}
interface Animation {
  public void changeImage(int spriteFrame);
  public void changeAnimation();
}
class Carousel implements IState {
  private int _mainColor;
  private ArrayList<GameThumbnail> _levels;
  private boolean _removeLevel;
  private Program _program;
  private PImage _background;
  
  public Carousel(Program program) {
    this._levels = new ArrayList<GameThumbnail>();
    this._mainColor = color(160, 5, 28);
    this._program = program;
    this._background = loadImage("assets/background.jpg");
    this._background.resize(width, height);
    
    for(int i = 0; i < 3; i++) {
      String thumbnail = "assets/Level" + i + ".png";
      int thumbnailWidth = 400;
      int thumbnailHeight = 230;
      int xPosition = width / 2 - thumbnailWidth;
      int yPosition = height / 2 - thumbnailHeight/2;
      int margin = 100;
      xPosition = xPosition + ((400+margin)*i);
      
      this.addThumbnail(thumbnail, xPosition, yPosition);
    }
  }
  
  public void update() {
    if(_removeLevel) {
      this._levels.remove(0);
      this._removeLevel = false;
    }
    
    for(int i = 0; i < _levels.size(); i++) {
      GameThumbnail thumbnail = _levels.get(i);
      thumbnail.update();
      
      if (i == _levels.size() - 1 && this.checkForNewThumbnail(thumbnail, 1)) {
        float xPosition = thumbnail.getPosition().x + 100 + thumbnail.getWidth();
        float yPosition = thumbnail.getPosition().y;
        this.addThumbnail("assets/Level1.png", (int)xPosition, (int)yPosition);
      }
      
      if (i == 0 && this.checkForNewThumbnail(thumbnail, 0)) {
        this.removeThumbnail();
      }
    }
  }
  
  public void draw() {
    background(this._mainColor);
    image(this._background, 0, 0, width, height);
    
    if(this._background.width == 0) {
      // Image not yet loaded
    } else if (this._background.width == -1) {
      // Error whith loading image
    } else {
      //image(this._background, 0, 0, width, height);
    }
    
    for(GameThumbnail thumbnail: _levels) {
      thumbnail.draw();
    }
  }
  
  public void keyPressHandle(char key) {
    if(key == ' ') {
      this.detectSelection();
    }
  }
  
  public void keyReleaseHandle(char key) {
    
  }
  
  public void action(String action) {
    
  }
  
  public void detectSelection() {
    for(GameThumbnail thumbnail: _levels) {
      if(thumbnail.selected){
        this._program.changeState(new Game(this._program));
        return;
      }
    }
  }
  
  /**
  * orientation = 0 stands for left
  * orientation = 1 stands for right
  */
  private boolean checkForNewThumbnail(GameThumbnail thumbnail, int orientation) {
    PVector position = thumbnail.getPosition();
    int thumbnailWidth = thumbnail.getWidth();
    
    if (orientation == 0) {
      if (position.x + thumbnailWidth > width) {
        return true;
      }
    } else if (orientation == 1) {
      if(position.x + thumbnailWidth < width) {
        return true;
      }
    }
    return false;
  }
  
  private void addThumbnail(String image, int xPosition, int yPosition) {
    int thumbnailWidth = 400;
    int thumbnailHeight = 200;
    int targetScore = 10;
    
    //if(level == 2) {
    //  targetScore = 25;
    //} else if (level == 3) {
    //  targetScore = 50;
    //}
    
    //Level level = new Level();
    
    GameThumbnail thumbnail = new GameThumbnail(image, xPosition, yPosition, thumbnailWidth, thumbnailHeight);
    _levels.add(thumbnail);
  }
  
  private void removeThumbnail() {
    this._removeLevel = true;
  }
}
class GameCharacter extends GameObject implements IUpdate {
  
    private ArrayList<PImage> _spriteSheetBrokenDownInPieces;
    private Animation _animation;
    private float _gravity;
    private Game _game;
    private ICollidable _currentColidableObject;
    private int _jumpTimer;
    private boolean _jump;
    private float _jumpPower;
    private float _gravityEmplifyer;
  
    public GameCharacter(int xPosition, int yPosition, int widthImage, int heightImage, Game game){
      super(xPosition, yPosition, widthImage, heightImage, game);
      _game = game;
      AddToUpdateList();
      _spriteSheetBrokenDownInPieces = new ArrayList<PImage>();
      MakeSpriteSheetArray();
      _animation = new Run(this);
      _gravity = .3f;
      _jumpTimer = 0;
      _jump = false;
      _jumpPower = 8;
      _gravityEmplifyer = 0;
    }
    
    public void MakeSpriteSheetArray(){
      for(int i = 0; i < 25; i++){
        PImage _pimage = loadImage("Assets/nick-sprite.png");
        _pimage = _pimage.get(i*170,0,160,350);
        _pimage.resize(80,175);
        _spriteSheetBrokenDownInPieces.add(_pimage);
      }
    }
    
    public void Update(){
      _animation.changeAnimation();
      // if(!GravityEffect()){
      //   _position.y += _gravityEmplifyer + _gravity;
        
      //   if(_jumpTimer > 80){
      //   _gravityEmplifyer += _gravity + (0.5 * _gravityEmplifyer) - _gravityEmplifyer ;
      //   }
      // }
      
      // if(!GravityEffect() && !JumpEffect()){
      //   _animation = new Run(this);   
      // }
      
      // if(_jumpTimer > 140){
      //   _jump = false;
      // }

      // if(JumpEffect()){
      //   _position.y -= _jumpPower;
      // }


      if (!GravityEffect()) {
        _velocity.y += _gravity;
      } 

      if (GravityEffect()) {
        _velocity.y = 0; 
      }

      if(!GravityEffect() && !JumpEffect()){
        _animation = new Run(this);
        _jump = false;
      }
      
      // If on the ground and "jump" keyy is pressed set my upward velocity to the jump speed!
      if (GravityEffect() && _jump != false)
      {
        _velocity.y = -_jumpPower;
      }
      
      // We check the nextPosition before actually setting the position so we can
      // not move the oldguy if he's colliding.
      PVector nextPosition = new PVector(_position.x, _position.y);
      nextPosition.add(_velocity);
      
      _position.y = nextPosition.y;

      
      _jumpTimer++;
    }
    
    public void AddToUpdateList(){
      _game.AddToUpdateList(this);
    }
    
    public void Jump(){
      if(!_jump){
        _animation = new Jump(this);
        _jumpTimer = 0;
        _gravityEmplifyer = 0;
        _jump = true;
      }
    }
    
    public boolean JumpEffect(){
       if(!_jump){
        return false;
      }
      
      if(_jumpTimer > 40){
        return false;
      }
     
      return true;
    }
    
    public void SetCurrentCollidableObject(ICollidable object){
      _currentColidableObject = object;
    }
    
    public boolean GravityEffect(){
      if(_currentColidableObject == null){
        return false;
      }

      if(_currentColidableObject.getPositionY() > _position.y + _height - 15){
          return false;
      }
      
      
      return true;
    }
    
    
    public void changeImage(int spriteFrame){
      _img = _spriteSheetBrokenDownInPieces.get(spriteFrame);
    }
    
    public float GetXPosition(){
      return _position.x;
    }
    
    public float GetYPosition(){
      return _position.y;
    }
    
    public float GetWidth(){
      return _width;
    }
    
    public float GetHeight(){
      return _height;
    }
}
class CollidableObjects {
  
  private ArrayList<ICollidable> _collidableObjects;

  public CollidableObjects(){
    _collidableObjects = new ArrayList<ICollidable>();
  }
  
  public void AddToList(ICollidable object){
    _collidableObjects.add(object);
  }
  
  public ArrayList<ICollidable> GetICollidableList(){
    return _collidableObjects;
  }
  
}


String[][] COMMENTS = {
  {"Heel goed gedaan!","heel_goed_gedaan.mp3"},
  {"Ja top!","ja_top.mp3"},
  {"Gaat goed komen!","gaat_goed_komen.mp3"},
  {"Heb zitten genieten!","zitten_genieten.mp3"},
  {"Vond je het leuk?","vond_je_het_leuk.mp3"},
  {"Wat een talent!","wat_een_talent.mp3"},
  {"Wat was dat goed zeg!","zitten_genieten.mp3"},
};

class EndScreen implements IState {
  private PImage _background;
  private Box _box;
  private int _mainColor;
  private Comment _comment;
  private ArrayList<PImage> _nick;
  private ArrayList<PImage> _simon;
  private int _frame;
  
  public EndScreen(int totalJumps, int timestamp, int target, Program program) {
    // Get background image and color.
    this._background = loadImage("../assets/background.jpg");
    this._background.resize(width, height);
    this._mainColor = color(160, 5, 28);
    
    // Setup box.
    noTint();
    int boxWidth = 600;
    int boxHeight = 345;
    int yBoxPosition = height/2 - boxHeight/2;
    int xBoxPosition = width/2 - boxWidth/2;
    this._box = new Box(xBoxPosition, yBoxPosition, boxWidth, boxHeight, target, timestamp, totalJumps);
    
    // Setup comment.
    float rand = random(0, COMMENTS.length);
    this._comment = new Comment(width/2, yBoxPosition - 100, 0, 0, COMMENTS[(int)rand][0], COMMENTS[(int)rand][1], program);
    
    // Setup nick & simon sprites.
    this._nick = new ArrayList<PImage>();
    this._simon = new ArrayList<PImage>();
    PImage nick = loadImage("../assets/nick_juig.png");
    PImage simon = loadImage("../assets/simon_juig.png");
    this._frame = 0;
    for(int i = 0; i <= 25; i++) {
      this._nick.add(nick.get(200 * i, 0, 200, 350));
      this._simon.add(simon.get(200 * i, 0, 200, 350));
    }
  }
  
  public void update() {
    this._comment.update();
  }
  
  public void draw() {
    // Draw Background.
    background(this._mainColor);
    background(this._background);
    
    // Draw box.
    this._box.draw();
    
    // Draw comment.
    this._comment.draw();
    
    // Draw nick & simon.
    this.drawNickSimon(this._box._position.x, this._box._position.y);
  }
 
   public void keyPressHandle(char key) {
    
  }
  
  public void keyReleaseHandle(char key) {
    
  }
  
  public void action(String action) {
    
  }
  
  public void drawNickSimon(float xPosition, float yPosition) {
    if(this._frame >= 24) {
      this._frame = 0;
    }
    
    image(this._nick.get(this._frame), xPosition - 150, yPosition);
    image(this._simon.get(this._frame), xPosition + 550, yPosition);
    
    this._frame++;
  }
}

class Box extends GameObjectFix {
  private PFont _font;
  private String _target;
  private String _targetText;
  private String _timestampText;
  private String _jumpsText;
  private float _targetWidth;
  private float _targetTextWidth;
  private float _timestampTextWidth;
  private float _jumpsTextWidth;
  private PImage _jumpsImg;
  private PImage _timeImg;
  
  public Box(int xPosition, int yPosition, int widthImage, int heightImage, int target, int timestamp, int totalJumps) {
    super(xPosition, yPosition, widthImage, heightImage);
    
    this._img = loadImage("../assets/box.png");
    this._img.resize(600, 345);
    
    this._jumpsImg = loadImage("../assets/jumps.png");
    this._timeImg = loadImage("../assets/clock.png");
    
    this._font = loadFont("BrandonGrotesque-BlackItalic-120.vlw");
    
    textFont(this._font, 60);
    this._targetText = " / " + target;
    this._targetText = this._targetText.toUpperCase();
    this._targetTextWidth = textWidth(this._targetText);
    
    this._timestampText = ""+ timestamp;
    this._timestampText = this._timestampText.toUpperCase();
    this._timestampTextWidth = textWidth(this._timestampText);
    
    this._jumpsText = ""+ totalJumps;
    this._jumpsText = this._jumpsText.toUpperCase();
    this._jumpsTextWidth = textWidth(this._jumpsText);
    
    textFont(this._font, 80);
    this._target = ""+ target;
    this._target = this._target.toUpperCase();
    this._targetWidth = textWidth(this._target);
  }
  
  public void draw() {
    super.draw();
    
    textFont(_font, 60);
    fill(109, 10, 10);
    text(this._targetText, this._position.x + this._width/2 - ((this._targetTextWidth + this._targetWidth) / 2) + this._targetWidth, this._position.y + 200);
    fill(255);
    text(this._jumpsText, this._position.x + this._width/2 - (this._width/2)/2 - this._jumpsTextWidth/2 + this._jumpsImg.width, this._position.y + 445);
    image(this._jumpsImg, this._position.x + this._width/2 - (this._width/2)/2 - this._jumpsTextWidth/2, this._position.y - 50 + 445);
    text(this._timestampText, this._position.x + this._width/2 + (this._width/2)/2 - this._timestampTextWidth/2 + this._timeImg.width, this._position.y + 445);
    image(this._timeImg, this._position.x + this._width/2 + (this._width/2)/2 - this._timestampTextWidth/2, this._position.y - 50 + 445);
    textFont(_font, 80);
    text(this._target, this._position.x + this._width/2 - (this._targetTextWidth + this._targetWidth) / 2, this._position.y + 200);
  }
}

class Comment extends GameObjectFix {
  private PFont _font;
  private String _text;
  private String _doneText;
  private float _textWidth;
  private float _doneTextWidth;
  private SoundFile _sound;
  
  public Comment(int xPosition, int yPosition, int widthImage, int heightImage, String text, String audio, Program program) {
    super(xPosition, yPosition, widthImage, heightImage);
    
    // Setup text.
    this._font = loadFont("BrandonGrotesque-BlackItalic-120.vlw");
    textFont(this._font, 60);
    this._text = text;
    this._text = this._text.toUpperCase();
    this._textWidth = textWidth(this._text);
    
    textFont(this._font, 40);
    this._doneText = "Behaald";
    this._doneText = this._doneText.toUpperCase();
    this._doneTextWidth = textWidth(this._doneText);
    
    // Setup sound.
    this._sound = new SoundFile(program, audio);
    this._sound.play();
  }
  
  public void draw() {
    fill(255);
    textFont(_font, 60);
    text(_text, this._position.x - this._textWidth/2, this._position.y);
    textFont(_font, 40);
    fill(109, 10, 10);
    text(_doneText, this._position.x - this._doneTextWidth/2, this._position.y + 400);
  }
}
class Floor extends GameObject {
  public Floor(int xPosition, int yPosition, int widthImage, int heightImage, Game game) {
    super(xPosition, yPosition, widthImage, heightImage, game);
  }
  
  public void update() {
    _position.x -= 1;
  }
}
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
  private int _mainColor;
  private Program _program;
  
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
    
    //currentLevel = new LevelLayer(this);
    character = new GameCharacter((width/2) - 20, 330, 80, 175, this);
    
    _obstacleManager = new ObstacleManager(this, character);
    _ground = new Ground(0,height - 200, width, 200, this);
    
    _middleObjectDetector = new MiddleObjectDetector(this, _collidableObjects, character);
    
    _pointSystem = new PointSystem(this, _program); 
    _pointmanager = new PointManager(this, character, _pointSystem);
  }
  
  public void update() {
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
class GameObject{
  protected PImage _img;
  protected PVector _position;
  protected PVector _velocity;
  protected int _width;
  protected int _height;
  
  public GameObject(int xPosition, int yPosition, int widthImage, int heightImage, Game game){
    _img = null;
    _position = new PVector(xPosition, yPosition);
    _velocity = new PVector(0, 0);
    _width = widthImage;
    _height = heightImage;
    
    // Hiermee worden de GameObjects toegevoegd aan de GameObjectList.
    game.addToGameObjectList(this);
  }
  
  public void update(){
    
  }
  
  public void drawObject(){
    try {
      image (_img, _position.x, _position.y, _width, _height); 
    } catch (Exception e){
      
    }
  }
  
}
class GameObjectFix{
  protected PImage _img;
  protected PVector _position;
  protected PVector _velocity;
  protected int _width;
  protected int _height;
  
  public GameObjectFix(int xPosition, int yPosition, int widthImage, int heightImage){
    _img = null;
    _position = new PVector(xPosition, yPosition);
    _velocity = new PVector(0, 0);
    _width = widthImage;
    _height = heightImage;
  
  }
  
  public void update(){
    
  }

  public void draw() {
    try {
      image (_img, _position.x, _position.y, _width, _height); 
    } catch (Exception e){
      
    }
  }  
}
class GameThumbnail extends GameObjectFix {
  public boolean selected = false;
  private int _maxWidth;
  private int _minWidth;
  private LevelNumber _LevelNumber;
  private Level _level;
  
  public GameThumbnail(String thumbnail, int xPosition, int yPosition, int widthImage, int heightImage) {
    super(xPosition, yPosition, widthImage, heightImage);
    this._img = requestImage(thumbnail);
    this._maxWidth = widthImage + widthImage/8;
    this._minWidth = widthImage;
    //this._level = level;
    
    // Initiate level number
    int levelWidth = 65;
    int levelHeight = 65;
    int levelXPosition = xPosition + widthImage/2 - levelWidth/2;
    int levelYPosition = yPosition - levelHeight/2;
    
    this._LevelNumber = new LevelNumber("1", levelXPosition, levelYPosition, levelWidth, levelHeight);
  }
  
  public void update() {
    super.update();
    
    this.selected = this.isSelected();
    
    if(this.selected && this._width <= this._maxWidth) {
      this.grow();
    } else if(!this.selected && this._width >= this._minWidth) {
      this.minimize();
    }
    
    // Update LevelNumber
    this._LevelNumber.update(this._position, this._width);
    
    this.updatePosition();
  }
  
  public void draw() {
    
    if(this.selected) {
      tint(255, 255);
      //this.grow();
    } else if(!this.selected) {
      tint(255, 127);
    }
    
    super.draw();
    
    this._LevelNumber.draw();
  }
  
  public void updatePosition() {
    float targetX = this._position.x - 4;
    float dx = targetX - this._position.x;
    this._position.x += dx; 
  }
  
  private void grow() {
    this._height += 1;
    this._width += 2;
    this._position.y -= 0.5f;
    this._position.x -= 1;
  }
  
  private void minimize() {
    this._height -= 1;
    this._width -= 2;
    this._position.y += 0.5f;
    this._position.x += 1;
  }
  
  public boolean isSelected() {
    float leftPositionX = this._position.x;
    float rightPositionX = this._position.x + this._width;
    int middle = width/2;
    
    if((int) leftPositionX < middle && (int) rightPositionX > middle) {
      return true;
    }
    
    return false;
  }
  
  public PVector getPosition() {
    return this._position;
  }
  
  public int getWidth() {
    return this._width;
  }
  
  public Level getLevel() {
    return this._level;
  }
}
int Y_AXIS = 1;
int X_AXIS = 2;

class Gradient {
  public void drawLinearGradient(int x, int y, float w, float h, int c1, int c2, int axis) {
    noFill();

    if (axis == Y_AXIS) {  // Top to bottom gradient
      for (int i = y; i <= y+h; i++) {
        float inter = map(i, y, y+h, 0, 1);
        int c = lerpColor(c1, c2, inter);
        stroke(c);
        line(x, i, x+w, i);
      }
    }  
    else if (axis == X_AXIS) {  // Left to right gradient
      for (int i = x; i <= x+w; i++) {
        float inter = map(i, x, x+w, 0, 1);
        int c = lerpColor(c1, c2, inter);
        stroke(c);
        line(i, y, i, y+h);
      }
    }
  }
}
class Hole extends Obstacle implements ICollidable{
  
  private Game _game;
  
  public Hole(int xPosition, int yPosition, int widthImage, int heightImage, Game game) {
    super(xPosition, yPosition, widthImage, heightImage, game);
    _game = game;
    _img = loadImage("Assets/HoleGround.png");
    _width = 75;
    _height = 75;
    _img.resize(_width, _height);
    subscribeToCollidableObjects();
  }
  
  public float getPositionX(){
    return _position.x;
  };
  
  public float getPositionY(){
    return _position.y;
  };
  
  public int getWidth(){
    return _width;
  };
  
  public int getHeight(){
    return _height;
  };
  
  public void subscribeToCollidableObjects(){
    _game.addToCollidableObjects(this);
  }
}
interface ICollidable {
  public float getPositionX();
  public float getPositionY();
  public int getWidth();
  public int getHeight();
  public void subscribeToCollidableObjects();
}

interface IState {
  public void update();
  public void draw();
  public void keyPressHandle(char key);
  public void keyReleaseHandle(char key);
  public void action(String action);
}
interface IUpdate {
  public void Update();
  public void AddToUpdateList();
}
class Jump implements Animation {
  private GameCharacter _character;
  
  public Jump(GameCharacter character){
    _character = character;
    changeImage(24);
  }
  
  public void changeImage(int spriteFrame){
    _character.changeImage(spriteFrame);
  };
  
  public void changeAnimation() {
    
  };
}
class Level {
  private String _name;
  private int _score;
  private int _targets;
  
  public Level() {
    
  }
  
  public void update() {
    
  }
  
  public void draw() {
    
  }
}
int X_POSITION = 0;
int Y_POSITION = 1;

class LevelNumber extends GameObjectFix {
  public LevelNumber(String level, int xPosition, int yPosition, int widthImage, int heightImage) {
    super(xPosition, yPosition, widthImage, heightImage);
    
    this._img = requestImage("assets/levelNumber.png");
  }
  
  public void update(PVector parentPosition, int parentWidth) {
    this._position.x = CalculatePosition(0, parentPosition, parentWidth);
    this._position.y = CalculatePosition(1, parentPosition, parentWidth);
  }
  
  public void draw() {
    super.draw();
    //stroke(0);
    //fill(77, 194, 255);
    //ellipse(this._position.x, this._position.y, this._width, this._height);
  }
  
  public float CalculatePosition(int axis, PVector parentPosition, int parentWidth) {
    if(axis == X_POSITION) {
      return parentPosition.x + parentWidth/2 - this._width/2;
    } else if (axis == Y_POSITION) {
      return parentPosition.y - this._height/2;
    }
    return 0;
  }
}
class MiddleObjectDetector implements IUpdate{
  
  private Game _game;
  private CollidableObjects _collidableobjects;
  private GameCharacter _character;
  
  public MiddleObjectDetector(Game game, CollidableObjects collidableobjects, GameCharacter character) {
    _game = game;
    _collidableobjects = collidableobjects;
    _character = character;
    AddToUpdateList();
  }
  
  public void Update(){
    checkCollidableObjectsInMiddle();
  }
  
  public void AddToUpdateList(){
      _game.AddToUpdateList(this);
  }
  
  public ArrayList<ICollidable> GetCollidableObjects(){
    return _collidableobjects.GetICollidableList();
  }
 
  public void checkCollidableObjectsInMiddle(){
    ICollidable highestObject = null;
    for(ICollidable object : GetCollidableObjects()) {
      if(object.getPositionX() + object.getWidth() > _character.GetXPosition() + 20 && object.getPositionX() < _character.GetXPosition() + _character.GetWidth() - 40){
          highestObject = object;
      }
    }
    
    SendObjectToCharacter(highestObject);
  }
  
  public void SendObjectToCharacter(ICollidable object){
    _character.SetCurrentCollidableObject(object);
  }
}
class MusicScoreNote extends GameObject{
  public MusicScoreNote(int xPosition, int yPosition, int widthImage, int heightImage, Game game) {
    super(xPosition, yPosition, widthImage, heightImage, game);
    _img = loadImage("Assets/NoteSmall.png");
    _img.resize(width, height);
  }
}
class Obstacle extends GameObject {
  
  private boolean _outOfScreen;
  private Game _game;
  
  public Obstacle(int xPosition, int yPosition, int widthImage, int heightImage, Game game) {
    super(xPosition, yPosition, widthImage, heightImage, game);
    _game = game;
    _outOfScreen = false;
  }
  
  public void Update() {
    _position.x -= 2;
    CheckIfOutOfScreen();
  }
  
  public void CheckIfOutOfScreen(){
    if(_position.x == (0-_width)){
      _outOfScreen = true;
    }
  }
  
  public float GetXPosition(){
    return _position.x ;
  }
  
  public boolean GetOutOfScreen(){
    return _outOfScreen;
  }
}


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
class Player {
  
  public Player() {
    
  }
  
  public void update() {
    
  }
  
  public void draw() {
    
  }
}
class Point extends GameObject implements ICollidable{
  
  private Game _game;
  private boolean _outOfScreen;
  private boolean _hit;
  
  public Point(int xPosition, int yPosition, int widthImage, int heightImage, Game game) {
    super(xPosition, yPosition, widthImage, heightImage, game);
    _game = game;
    _img = loadImage("Assets/Munt.png");
    _width = 40;
    _height = 40;
    _img.resize(_width, _height);
    _outOfScreen = false;
    _hit = false;
  }
  
  public void Update(){
    CheckIfOutOfScreen();
    _position.x -= 2;
  }
  
  public float getPositionX(){
    return _position.x;
  };
  
  public float getPositionY(){
    return _position.y;
  };
  
  public int getWidth(){
    return _width;
  };
  
  public int getHeight(){
    return _height;
  };
  
  public void subscribeToCollidableObjects(){
    
  }
  
  public void SetHit(){
    _hit = true;
    _img = null;
  }
  
  public void CheckIfOutOfScreen(){
    if(_position.x == (0-_width)){
      _outOfScreen = true;
    }
  }
  
  public boolean GetOutOfScreen(){
    return _outOfScreen;
  }
  
  public boolean GetHit(){
    return _hit;
  }
}
class PointManager implements IUpdate {
  private ArrayList<Point> _pointList;
  private Game _game;
  private int _pointTimer;
  private GameCharacter _character;
  private PointSystem _pointSystem;
  
  public PointManager(Game game, GameCharacter character, PointSystem pointSystem){
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
class PointSystem implements IUpdate{
  
  private Game _game;
  private int _totalPoints;
  private int _goal;
  private MusicScoreNote _musicScoreNote;
  private Program _program;
  
  public PointSystem(Game game, Program program){
    this._program = program;
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
  }
  
  public void GameComplete(){
    _program.changeState(new EndScreen(0, 0, _totalPoints, _program));
  }
}

class Run implements Animation {
  private GameCharacter _character;
  private float _timer;
  private int _xChangeCount;
  
  public Run(GameCharacter character){
    _character = character;
    _timer = 0;
  }
  
  public void changeImage(int spriteFrame){
    _character.changeImage(spriteFrame); 
  };
  
  public void changeAnimation() {    
    _timer++;
    
    
    if(_xChangeCount > 23){
      changeImage(2);
      _timer = 0;
      _xChangeCount = 0;
    }
    
    if(_timer > 0){
      changeImage(_xChangeCount);
      _timer = 0;
      _xChangeCount++;
    }     
  };
}
class Stone extends Obstacle implements ICollidable {  
  private Game _game;
  
  public Stone(int xPosition, int yPosition, int widthImage, int heightImage, Game game) {
    super(xPosition, yPosition, widthImage, heightImage, game);
    _game = game;
    _img = loadImage("Assets/BlocksOne.png");
    _width = 75;
    _height = 75;
    _img.resize(_width, _height);
    subscribeToCollidableObjects();
  }
  
  public float getPositionX(){
    return _position.x;
  };
  
  public float getPositionY(){
    return _position.y;
  };
  
  public int getWidth(){
    return _width;
  };
  
  public int getHeight(){
    return _height;
  };
  
  public void subscribeToCollidableObjects(){
    _game.addToCollidableObjects(this);
  }
}
class Background extends GameObject{
  public Background(int xPosition, int yPosition, int widthImage, int heightImage, Game game) {
    super(xPosition, yPosition, widthImage, heightImage, game);
    _img = loadImage("Assets/BG.png");
    _img.resize(width, height);
  }
}
class Ground extends GameObject implements ICollidable {
  private Game _game;
  
  public Ground(int xPosition, int yPosition, int widthImage, int heightImage, Game game) {
    super(xPosition, yPosition, widthImage, heightImage, game);
    _img = loadImage("Assets/Ground.png");
    _game = game;
    subscribeToCollidableObjects();
  }
  
  public float getPositionX(){
    return _position.x;
  };
  
  public float getPositionY(){
    return _position.y;
  };
  
  public int getWidth(){
    return _width;
  };
  
  public int getHeight(){
    return _height;
  };
  
  public void subscribeToCollidableObjects(){
    _game.addToCollidableObjects(this);
  }
}
  public void settings() {  fullScreen(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Program" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
