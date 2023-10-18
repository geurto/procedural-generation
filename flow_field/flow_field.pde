final ArrayList<ArrayList<GridAngle>> grid = new ArrayList<ArrayList<GridAngle>>();
final ArrayList<FlowLine> flowLines = new ArrayList<FlowLine>();

final int xOff = 50;
final int yOff = 50;
final int spacing = 10;
final float resolution = 0.005;

final int numLines = 100;

boolean drawGrid = true;

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
  for (int i = 0; i < numLines; i++) {
    flowLines.add(new FlowLine());
  }
}

void setup(){
  size(600,600);
  createGrid();
  initializeLines();
}

void draw() {
  noFill();
  background(220);
  if (drawGrid) {
    for (int x = 0; x < grid.size(); x++) {
      for (int y = 0; y < grid.get(0).size(); y++) {
        grid.get(x).get(y).display();
      }
    }
  }
  for (FlowLine l: flowLines) {
    l.draw();
  }
  
  noLoop();
}
