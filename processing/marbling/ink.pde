class Drop {
  float x;
  float y;
  float r;
  color c;

  Drop(float x, float y, float r, color c) {
    this.x = x;
    this.y = y;
    this.r = r;
    this.c = c;
  }  

  void show() {
    fill(c); 
    circle(x, y, r * 2);
  }
}
