PImage characterImage;

int accelerate = 1;
int maxSpeed = 30;

private Collision collision;
private GroupOfPipes groupOfPipes;
private Background background;
private Bird bird;


void setup() {
  size(360, 600);
  background(255);
  
  collision = new Collision();
  background = new Background(0, 0, width, height);
  groupOfPipes = new GroupOfPipes(collision);
  
  bird = new Bird(50, 50, 50, 50, collision);

  frameRate(30);
}

public void update(){
  groupOfPipes.update();
  bird.update();
  collision.update();
}

public void drawObject(){
  background.drawObject();
  groupOfPipes.drawObject();
  bird.drawObject();
}

void draw() {
  background(255);

  update();
  drawObject();
}