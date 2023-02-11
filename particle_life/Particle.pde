class Particle {
  int type;
  color c;
  int size = width / 250;
  float x, y;
  float vx = 0;
  float vy = 0;
  float friction = 0.23;
  float[] attractions;
  float[] minDist;
  float[] maxDist;
  
  Particle(int type, int num_colors, float[] attractions, float[] min_distance, float[] max_distance) {
    this.type = type;
    this.c = color(type * (360 / num_colors), 100, 100);
    this.x = random(width);
    this.y = random(height);
    
    this.attractions = attractions;
    this.minDist = min_distance;
    this.maxDist = max_distance;
  }
  
  void step() {
    this.x += this.vx;
    this.y += this.vy;
    
    this.vx *= (1 - this.friction); 
    this.vy *= (1 - this.friction); 
    this.checkBounds();
  }
  
  void checkBounds() {
    if (this.x < 0) { this.x = width; }
    if (this.x > width) { this.x = 0; }
    if (this.y < 0) { this.y = height; }
    if (this.y > height) { this.y = 0; }
  }
    
  
  void draw() {
    circle(this.x, this.y, this.size);
    fill(this.c);
  }
}
