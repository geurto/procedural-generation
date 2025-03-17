class Particle {
  PVector pos;
  PVector vel;
  PVector acc;
  int maxspeed;
  int h;
  PVector prevPos;
  
  FlowWindow canvas;
  float xmax, xmin, ymax, ymin, resolution;
  
  Particle(PVector pos, PVector vel, FlowWindow canvas) {
    this.pos = pos;
    this.vel = vel;
    this.canvas = canvas;
    this.acc = new PVector(0, 0);
    this.maxspeed = 4;
    this.h = 0;
    this.prevPos = this.pos.copy();
    
    this.xmax = canvas.xpos + canvas.xsize;
    this.xmin = canvas.xpos - canvas.xsize;
    this.ymax = canvas.ypos + canvas.ysize;
    this.ymin = canvas.ypos - canvas.ysize;
    this.resolution = canvas.xsize / 200;
  }
  
  void update() {
    this.vel.add(this.acc);
    this.vel.limit(this.maxspeed);
    this.pos.add(this.vel);
    this.acc.mult(0);
  }
  
  void follow() {
    int x = floor(this.pos.x / this.resolution);
    int y = floor(this.pos.y / this.resolution);
    PVector force = canvas.flowfield[y][x];
    this.applyForce(force);
  }
  
  void applyForce(PVector force) {
    this.acc.add(force);
  }
  
  void updatePrev() {
    this.prevPos.x = this.pos.x;
    this.prevPos.y = this.pos.y;
  }
  
  void edges() {
   if (this.pos.x > this.xmax) {
      this.pos.x = this.xmin;
      this.updatePrev();
    }
    if (this.pos.x < this.xmin) {
      this.pos.x = this.xmax;
      this.updatePrev();
    }
    if (this.pos.y > this.ymax) {
      this.pos.y = this.ymin;
      this.updatePrev();
    }
    if (this.pos.y < this.ymin) {
      this.pos.y = this.ymax;
      this.updatePrev();
    }
  }
}
