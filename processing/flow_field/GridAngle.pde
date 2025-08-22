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