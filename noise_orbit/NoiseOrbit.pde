class NoiseOrbit {
  int num_circles;
  float interval;
  float min_radius;
  float max_radius;
  PShape[] circles;
  int num_sides;
  float z;
  
  NoiseOrbit(int _num_circles, float _interval, float _min_radius, int _num_sides) {
    this.num_circles = _num_circles;
    this.interval = _interval;
    this.min_radius = _min_radius;
    this.max_radius = this.min_radius + (this.interval * this.num_circles);
    this.num_sides = _num_sides;
    
    this.circles = new PShape[this.num_circles];
    
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
    endShape(CLOSE);
    return circle;
  }
  
  void loop() {
    for (int c = 0; c < this.num_circles; c++) {
      this.distort(c);
      this.display(c);
    }
  }
  
  void distort(int c) {
    z = frameCount / 50.0;

    for (int v = 0; v < this.circles[c].getVertexCount(); v++) {
      PVector p = this.circles[c].getVertex(v);
      //float theta = noise_function(p.x, p.y) * PI * 3;
      //float amount_to_nudge = w(0.8) - w(cos(z) * 0.8);
      //p.x += amount_to_nudge * cos(theta);
      //p.y += amount_to_nudge * sin(theta);
      PVector p_old = p;
      PVector noise = new PVector();
      noise.x = random(-100, 100);
      noise.y = random(-1000, 1000);
      p.x += noise.x;
      p.y += noise.y;
      this.circles[c].setVertex(v, p);
      
      PVector x = new PVector();
      x = this.circles[c].getVertex(v);
      println("Vertex before: ", p_old.x, " --- ", p_old.y);
      println("Noise: ", noise.x, " --- ", noise.y);
      println("Vertex after:", x.x, " --- ", x.y);
      println("Difference in vertex due to noise: ", x.x-p_old.x, x.y-p_old.y);
    }
  }
  
  void display(int c) {
    shape(this.circles[c], w(0.5), h(0.5));
  }
  
  float noise_function(float x, float y) {
    float z2 = frameCount / 200;
    float distance = dist(width/2, width/2, x, y);
  
    float noise_x = (x + 0.31) * distance * 2 + z2;
    float noise_y = (y - 1.73) * distance * 2 + z2;
    return noise(noise_x, noise_y, z);
  }
}  // end of class
