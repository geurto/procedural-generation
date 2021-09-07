class NoiseOrbit {
  int num_circles;
  float interval;
  float min_radius;
  float max_radius;
  PShape[] circles;
  PShape[] distorted_circles;
  PShape[] smooth_circles;
  int num_sides;
  
  NoiseOrbit(int _num_circles, float _interval, float _min_radius, int _num_sides) {
    this.num_circles = _num_circles;
    this.interval = _interval;
    this.min_radius = _min_radius;
    this.max_radius = this.min_radius + (this.interval * this.num_circles);
    this.num_sides = _num_sides;
    
    this.circles = new PShape[this.num_circles];
    this.distorted_circles = new PShape[this.num_circles];
    this.smooth_circles = new PShape[this.num_circles];
    
    noFill();

    for (int c = 0; c < num_circles; c++) {
      this.circles[c] = new PShape();
      this.circles[c].setStroke(0); // black stroke
    }
  }
  
  void create() {
    for (int c = 0; c < this.num_circles; c++) {
      float radius = this.min_radius + c * this.interval;
      this.circles[c] = this.make_circle(radius);
    }
  }
  
  void loop() {
    for (int c = 0; c < this.num_circles; c++) {
      this.distorted_circles[c] = this.distort(this.circles[c]);
      this.display(this.distorted_circles[c]);
    }
  }
  
  PShape make_circle(float radius) {
    PShape circle = new PShape();
    circle = createShape();
    circle.beginShape();
    circle.strokeWeight(w(0.001));

    float theta = 0;

    for (int s = 0; s <= this.num_sides; s++) {
      float x = radius * cos(theta);
      float y = radius * sin(theta);
      circle.vertex(x, y);
      theta += TWO_PI / this.num_sides;
    }
    circle.endShape(CLOSE);
    return circle;
  }
  
  PShape distort(PShape circle) {
    PShape distorted_circle = circle;

    for (int v = 0; v < distorted_circle.getVertexCount(); v++) {
      PVector p = distorted_circle.getVertex(v);
      PVector p_distorted = noise_function(p);
      distorted_circle.setVertex(v, p_distorted);
    }
    return distorted_circle;
  }
  
  void display(PShape circle) {
    shape(circle, w(0.5), h(0.5));
  }
  
  PVector noise_function(PVector p) {
    float x = p.x;
    float y = p.y;
    float distance = dist(0.5, 0.5, x, y);
    float z = frameCount / 500;
    float z2 = frameCount / 200;
  
    float noise_x = (x + 0.31) * distance * 2 + z2;
    float noise_y = (y - 1.73) * distance * 2 + z2;
    float noise = noise(noise_x, noise_y, z);
    
    float theta = noise * PI * 3;
    float amount_to_nudge = 0.08 - cos(z) * 0.08;
    p.x += amount_to_nudge * cos(theta);
    p.y += amount_to_nudge * sin(theta);
    
    return p;
  }
}  // end of class
