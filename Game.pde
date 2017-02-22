PImage characterImage;

int accelerate = 1;
int maxSpeed = 30;

private GroupOfPipes groupOfPipes;
private Background background;
private Bird bird;

void setup() {
  size(360, 600);
  background(255);
  
  groupOfPipes = new GroupOfPipes();
  background = new Background(0, 0, width, height);
  bird = new Bird(50, 50, 50, 50);

  frameRate(30);
}

public void update(){
  groupOfPipes.update();
  
}

public void drawObject(){
  groupOfPipes.drawObject();
  background.drawObject();
  bird.drawObject();
}

void draw() {
  background(255);

  update();
  drawObject();
}