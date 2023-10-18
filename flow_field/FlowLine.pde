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
      if (v.x < xOff || v.x > width - xOff || v.y < yOff || v.y > height - yOff) {
        break;
      }
      curveVertex(v.x, v.y);
    }

    endShape();
  }
}