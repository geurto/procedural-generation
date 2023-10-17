final ArrayList<ArrayList<GridAngle>> grid = new ArrayList<ArrayList<GridAngle>>();
final ArrayList<FlowLine> flowLines = new ArrayList<FlowLine>();

final int xOff = 50;
final int yOff = 50;
final int spacing = 10;
final float resolution = 0.005;

final int numLines = 10;

boolean drawGrid = true;

class FlowLine {
  int lineLength = 500;
  int segmentLength = 1;
  GridAngle startingPoint;
  
  FlowLine() {
    startingPoint = grid.get((int)random(grid.size())).get((int)random(grid.size()));
  }
  
  float getClosestGridAngle(PVector pos) {
    int nearestX, nearestY;
    nearestX = min(max((int)((pos.x - xOff) / spacing), 0), grid.size() - 1);
    nearestY = min(max((int)((pos.y - yOff) / spacing), 0), grid.size() - 1);
    println("X " + pos.x + " | Y " + pos.y + " | Nearest X " + nearestX + " | Nearest Y " + nearestY);
    return grid.get(nearestX).get(nearestY).angle;
  }
  
  void draw() {
    stroke(255, 0, 0);
    beginShape();
    PVector v = startingPoint.v;
    curveVertex(v.x, v.y);
    
    for (int i = 0; i < lineLength; i++) {
      float angle = getClosestGridAngle(v);
      v = new PVector(v.x + segmentLength * cos(angle),
                              v.y + segmentLength * sin(angle));
      curveVertex(v.x, v.y);
    }
    
    endShape();
  }
}

class GridAngle {
  int x, y, r;
  float angle;

  PVector v;

  GridAngle(int x_, int y_, int r_, float angle_) {
    x = x_;
    y = y_;
    r = r_;
    angle = angle_;
    
    v = new PVector(x + r * cos(angle),
                    y + r * sin(angle));
  }

  void display() {
    color(0, 0, 0);
    strokeWeight(2);
    line(x, y, v.x, v.y);
  }
}

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
