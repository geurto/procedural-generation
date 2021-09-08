class NoiseCircle {
  float radius;
  PVector[] points;
  int num_sides;
  
  NoiseCircle(float _radius, int _num_sides) {
    this.radius = _radius;
    this.num_sides = _num_sides;
    
    points = new PVector[this.num_sides];
    for (int p = 0; p < this.num_sides; p++) {
      points[p] = new PVector();
    }
    
    noFill();
    
    this.create();
  }
  
  void create() {
    float theta = radians(360/float(this.num_sides));
    for (int s = 0; s < this.num_sides; s++) {
      points[s].x = radius * cos(s * theta);
      points[s].y = radius * sin(s * theta);
    }
  }
  
  void loop() {
    this.distort();
    this.display();
  }
  
  void distort() {
    for (int i = 0; i < this.num_sides; i++) {
      points[i] = this.noise_function(points[i]);
    }
  }
  
  void display() {
    beginShape();
    strokeWeight(w(0.0005));

    // start control point
    curveVertex(this.points[this.num_sides - 1].x + w(0.5), this.points[this.num_sides - 1].y + h(0.5));
    
    // these points are drawn
    for (int s = 0; s < this.num_sides; s++) {
      curveVertex(this.points[s].x + w(0.5), this.points[s].y + h(0.5));
    }
    curveVertex(this.points[0].x + w(0.5), this.points[0].y + h(0.5));
    
    // end control point
    curveVertex(this.points[1].x + w(0.5), this.points[1].y + h(0.5));
    
    endShape();
  }
  
  PVector noise_function(PVector p) {
    float x = p.x;
    float y = p.y;
    float distance = dist(0.5, 0.5, x, y);
    float z = frameCount / 50;
    float z2 = frameCount / 200;
  
    float noise_x = (x + 0.31) * distance * 2 + z2;
    float noise_y = (y - 1.73) * distance * 2 + z2;
    float perlin_noise = noise(noise_x, noise_y, z);
    
    float theta = perlin_noise * PI * 3;
    float amount_to_nudge = 0.08 - cos(z) * 0.08;
    p.x += amount_to_nudge * cos(theta);
    p.y += amount_to_nudge * sin(theta);
    
    return p;
  }
}  // end of class
