class FlowWindow {
  float xpos;
  float ypos;
  float xsize;
  float ysize;
  ArrayList<PVector> points = new ArrayList<PVector>();
  PVector[][] flowfield;
  
  // colors used for points
  color[] pal = {
    color(0, 91, 197),
    color(0, 180, 252),
    color(23, 249, 255),
    color(223, 147, 0),
    color(248, 190, 0)
  };
  
  FlowWindow(float xpos, float ypos, float xsize, float ysize) {
    this.xpos = xpos;
    this.ypos = ypos;
    this.xsize = xsize;
    this.ysize = ysize;
    
    // Draw box
    strokeWeight(0.01 * xsize);
    color(0, 20, 45);
    line(xpos - 0.5 * xsize, ypos - 0.5 * ysize, xpos + 0.5 * xsize, ypos - 0.5 * ysize);
    line(xpos + 0.5 * xsize, ypos - 0.5 * ysize, xpos + 0.5 * xsize, ypos + 0.5 * ysize);
    line(xpos + 0.5 * xsize, ypos + 0.5 * ysize, xpos - 0.5 * xsize, ypos + 0.5 * ysize);
    line(xpos - 0.5 * xsize, ypos + 0.5 * ysize, xpos - 0.5 * xsize, ypos - 0.5 * ysize);
    
    // Create distorted points -- range is later mapped to width/height
    for (float x = xpos - (xsize/2)*0.96; x <= xpos + (xsize/2)*0.96; x += xsize/48) {
      for (float y = ypos - (ysize/2)*0.96; y <= ypos + (ysize/2)*0.96; y += ysize/48) {
        PVector v = new PVector(x + randomGaussian() * xsize/2000, y + randomGaussian() * ysize/2000);
        points.add(v);
      }
    }
  }
  
  void display() {
    strokeWeight(0.003 * xsize);
    int point_idx = 0; // point index
    for (PVector p : this.points) {
      // map floating point coordinates to screen coordinates
      float xx = p.x;
      float yy = p.y;
   
      // select color from palette (index based on noise)
      int cn = (int)(100 * this.pal.length * noise(point_idx)) % this.pal.length;
      stroke(this.pal[cn], 15);
      point(xx, yy); //draw
   
      // Evolving the vectors
      float n = 2 * TWO_PI * map(noise(p.x/5, p.y/5), 0, 1, -1, 1);
      PVector v = new PVector(cos(n), sin(n));
   
      p.x += vector_scale * v.x;
      p.y += vector_scale * v.y;
   
      // go to the next point
      point_idx++;
    }
  }
}
