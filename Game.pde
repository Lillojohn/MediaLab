PImage bck;
PImage characterImage;


int c[] = { 100, 100, 0, 50 }; // x, y, speed, size
int accelerate = 1;
int maxSpeed = 30;

private GroupOfPipes groupOfPipes;

void setup() {
  size(360, 600);
  background(255);
  
  groupOfPipes = new GroupOfPipes();
  
  bck = loadImage("fb-bg.png");
  characterImage = loadImage("fb-bird.png");
  frameRate(30);
}

public void update(){
  groupOfPipes.update();
}

public void drawObject(){
  groupOfPipes.drawObject();
}

void draw() {
  background(255);
  image(bck, 0, 0, width , height); // fullscreen

  update();
  drawObject();
  
  gameOver();
  drawCharacter();
}



void keyPressed() {
  // Als de space geklikt, dan doe je ding
  if (key == ' ') { // = space
    // spring omhoog
    c[2] = -maxSpeed / 2;
  }
}



void drawCharacter() {
  c[2] = c[2] + accelerate; // speed = speed + accelerate
  if (c[2] > maxSpeed) {
    c[2] = maxSpeed;
  }
  
  // als de y + speed > dan de onderkant, dan moet character op de grond blijven liggen
  if (c[1] + c[2] > height - c[3]) {
    c[1] = height - c[3]; // de y is de hoogte - de size
    c[2] = 0; // zet de speed naar 0 want hij mag niet door blijven vallen
  }
  
  c[1] = c[1] + c[2]; //y = y + speed
  
  fill(255, 255, 0); // geel
  image(characterImage, c[0], c[1], c[3], c[3]);
  //rect(c[0], c[1], c[3], c[3]);
}


boolean gameOver() {
  boolean result = false;
  
  //get(x, y); geeft de waarde van de kleur van de pixel op locatie x,y
  //println(get(c[0], c[1]));
  
  return result;
}