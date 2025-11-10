int NUM_VERTICES = 500;

class Drop {
  PVector center;
  float r;
  PVector[] vertices;
  color c;

  Drop(float x, float y, float r, color c) {
    this.center = new PVector(x, y);
    this.r = r;
    this.c = c;
    
    this.vertices = new PVector[NUM_VERTICES];
    
    for (int i = 0; i < NUM_VERTICES; i++) {
      float angle = map(i, 0, NUM_VERTICES, 0, TWO_PI);
      PVector v = new PVector(this.center.x + this.r * cos(angle), this.center.y + this.r * sin(angle));
      this.vertices[i] = v; 
    }
  }
  
  // https://people.csail.mit.edu/jaffer/Marbling/Dropping-Paint
  void marble(Drop other) {
    for (PVector v : this.vertices) {
      PVector dist = v.sub(other.center);
      float magnitude = dist.magSq();
      float scaling_factor = sqrt(1 + (other.r * other.r) / magnitude);
      dist.mult(scaling_factor);
      dist.add(other.center);
      v.set(dist);
    }
  }
  
  // https://people.csail.mit.edu/jaffer/Marbling/Mathematics
  void tine(PVector m, PVector b, float z, float c) {
    float u = 1 / pow(2, 1 / c);
    
    for (PVector v : this.vertices) {
      PVector pb = v.copy().sub(b);
      PVector normal = m.copy().rotate(HALF_PI);
      float d = abs(pb.dot(normal));
      
      float mag = z * pow(u, d);
      
      v.add(m.copy().mult(mag));
    }
  }

  void show() {
    noStroke();
    fill(c); 
    beginShape();
    for (PVector v : this.vertices) {
      vertex(v.x, v.y);
    }
    vertex(this.vertices[0].x, this.vertices[0].y);
    endShape();
  }
}
