class Particle {
  int type;
  color c;
  int size = width / 250;
  float x, y;
  float vx = 0;
  float vy = 0;
  float max_velocity = 5.0;
  float[] attractions;
  float[] minDist;
  float[] maxDist;
  
  Particle(int type, int num_colors) {
    this.type = type;
    this.c = color(type * (360 / num_colors), 100, 100);;
    this.x = random(width);
    this.y = random(height);
    
    this.attractions = new float[num_colors];
    this.minDist = new float[num_colors];
    this.maxDist = new float[num_colors];
    
    // generate random attractions to other colours, as well as min/max distance for attractions
    for (int i = 0; i < num_colors; i++) {
      this.attractions[i] = random(-1.0, 1.0);
      this.minDist[i] = random(this.size, 2 * this.size);
      this.maxDist[i] = random(5 * this.size, 20 * this.size);
    }
  }
  
  void step() {
    this.x += this.vx;
    this.y += this.vy;
    this.checkBounds();
  }
  
  void checkBounds() {
    if (this.x < 0) { this.x = width; }
    if (this.x > width) { this.x = 0; }
    if (this.y < 0) { this.y = height; }
    if (this.y > height) { this.y = 0; }
    
    if (this.vx < -max_velocity) { this.vx = -max_velocity; }
    if (this.vx > max_velocity) { this.vx = max_velocity; }
    if (this.vy < -max_velocity) { this.vy = -max_velocity; }
    if (this.vy > max_velocity) { this.vy = max_velocity; }

  }
    
  
  void draw() {
    circle(this.x, this.y, this.size);
    fill(this.c);
  }
}
