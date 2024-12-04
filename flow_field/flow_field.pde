final ArrayList<ArrayList<GridAngle>> grid = new ArrayList<ArrayList<GridAngle>>();
final ArrayList<FlowLine> flowLines = new ArrayList<FlowLine>();
PImage img;

final int w = 1800;
final int h = 900;
final int xOff = 0;
final int yOff = 0;
final int spacing = 10;
final float resolution = 0.005;

final int numLines = 150000;

boolean drawGrid = false;

void createGrid() {
  for (int x = xOff; x < (width - xOff); x += spacing) {
    ArrayList<GridAngle> row  = new ArrayList<GridAngle>();
    for (int y = yOff; y < (width - yOff); y += spacing) {
      float angle = map(noise(x * resolution, y * resolution), 0.0, 1.0, 0.0, TAU);

      row.add(new GridAngle(x, y, spacing/2, angle));
    }
    grid.add(row);
  }
}

void initializeLines() {
  colorMode(HSB, 100);
  for (int i = 0; i < numLines; i++) {
    int lineLength = (int)random(5, 10);
    PVector vec = new PVector(random(- width / 4, width * 1.25), random(-height / 4, height * 1.25));
    flowLines.add(new FlowLine(vec, lineLength));
  }
}

void setup(){
  size(1800, 900);
  //blendMode(SCREEN);
  createGrid();
  initializeLines();
}

void draw() {
  noFill();
  background(255);
  
  // current options: blue-copper-orange | skyline | deep-dea | rainbow
  img = loadImage("colors/skyline.png");
  image(img, 0, 0, width, height);
  
  if (drawGrid) {
    for (int x = 0; x < grid.size(); x++) {
      for (int y = 0; y < grid.get(0).size(); y++) {
        grid.get(x).get(y).display();
      }
    }
  }
  for (FlowLine l: flowLines) {
    l.draw(img);
  }
  
  noLoop();
}
