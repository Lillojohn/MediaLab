import processing.sound.*;

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
  private Program _program;
  private PImage _background;
  private Box _box;
  private color _mainColor;
  private Comment _comment;
  private ArrayList<PImage> _nick;
  private ArrayList<PImage> _simon;
  private int _frame;
  private int _time;
  
  public EndScreen(int totalJumps, int timestamp, int target, Program program) {
    this._program = program;

    // Get background image and color.
    this._background = loadImage("../assets/background.jpg");
    this._background.resize(width, height);
    this._mainColor = color(160, 5, 28);

    // Setup timer.
    this._time = millis();
    
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

    println(this._time, millis());

    if (millis() > this._time + 10000 ) {
      this._program.changeState(new Carousel(this._program));
    }
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