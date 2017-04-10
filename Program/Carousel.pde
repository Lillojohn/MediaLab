class Carousel implements IState {
  private color _mainColor;
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