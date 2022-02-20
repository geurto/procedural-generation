Star[] stars = new Star[800];
float speed;

void setup() {
  size(1200, 600);
  
  for (int i = 0; i < stars.length; i++) {
    stars[i] = new Star();
  }
}

void draw() {
  noCursor();
  speed = map(mouseX, 0, width, 0, 35);
  
  background(0);
  translate(width/2, height/2);
  
  for (int i = 0; i < stars.length; i++) {
    stars[i].update();
    stars[i].show();
  }
}
