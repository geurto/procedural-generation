class FlowLine {
  int lineLength = 100;
  float segmentLength = w * 0.001;
  GridAngle startingPoint;
  color c;

  FlowLine(int lineLength_, color c_) {
    this.lineLength = lineLength_;
    this.c = c_;
    this.startingPoint = grid.get((int)random(grid.size())).get((int)random(grid.size()));
  }

  float getClosestGridAngle(PVector pos) {
    int nearestX, nearestY;
    nearestX = min(max((int)(pos.x / spacing), 0), grid.size() - 1);
    nearestY = min(max((int)(pos.y / spacing), 0), grid.size() - 1);
    return grid.get(nearestX).get(nearestY).angle;
  }

  void draw() {
    stroke(this.c);
    beginShape();
    PVector v = this.startingPoint.v;
    curveVertex(v.x, v.y);

    for (int i = 0; i < this.lineLength; i++) {
      float angle = getClosestGridAngle(v);
      v = new PVector(v.x + this.segmentLength * cos(angle),
                              v.y + this.segmentLength * sin(angle));
      if (v.x < -w / 2 || v.x > width + w / 2 || v.y < -h / 2 || v.y > height + h / 2) {
        break;
      }
      curveVertex(v.x, v.y);
    }

    endShape();
  }
}
