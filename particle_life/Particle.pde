class Particle {
  int type, size;
  color c;
  float x, y;
  float vx = 0;
  float vy = 0;
  float friction = 0.43;
  
  Particle(int type, int num_colors, int particle_size) {
    this.type = type;
    this.size = particle_size;
    this.c = color(type * (360 / num_colors), 100, 100);
    this.x = random(width);
    this.y = random(height);
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
