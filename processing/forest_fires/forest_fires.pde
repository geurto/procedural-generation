Forest forest;

void setup() {
  size(900, 900);
  colorMode(HSB, 360, 100, 100);
  forest = new Forest(width / 3);
}

void draw() {
  forest.step();
}
