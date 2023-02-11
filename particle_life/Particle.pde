class Particle {
  color c;
  float[][] attraction_matrix;
  int index_in_matrix;
  int size = width / 200;
  PVector position;
  PVector speed;
  PVector force;
  float max_velocity = 5.0;
  
  Particle(color c, float[][] attraction_matrix, int index_in_matrix) {
    this.c = c;
    this.attraction_matrix = attraction_matrix;
    this.index_in_matrix = index_in_matrix;
    this.position = new PVector(random(width), random(height));
    this.speed = new PVector(0, 0);
    this.force = new PVector(random(-0.2, 0.2), random(-0.2, 0.2));
  }
  
  void evolve() {
    this.speed.add(this.force);
    this.position.add(this.speed);
    this.checkBounds();
    
    this.force.x = this.force.x + random(-0.03, 0.03);
    this.force.y = this.force.y + random(-0.03, 0.03);
  }
  
  void checkBounds() {
    if (this.position.x < 0) { this.position.x = width; }
    if (this.position.x > width) { this.position.x = 0; }
    if (this.position.y < 0) { this.position.y = height; }
    if (this.position.y > height) { this.position.y = 0; }
    
    if (this.speed.x < -max_velocity) { this.speed.x = -max_velocity; }
    if (this.speed.x > max_velocity) { this.speed.x = max_velocity; }
    if (this.speed.y < -max_velocity) { this.speed.y = -max_velocity; }
    if (this.speed.y > max_velocity) { this.speed.y = max_velocity; }

  }
    
  
  void draw() {
    circle(this.position.x, this.position.y, this.size);
    fill(this.c);
  }
}
