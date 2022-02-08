// dynamic list with our points, PVector holds position
ArrayList<PVector> points = new ArrayList<PVector>();
 
// colors used for points
color[] pal = {
  color(0, 91, 197),
  color(0, 180, 252),
  color(23, 249, 255),
  color(223, 147, 0),
  color(248, 190, 0)
};
 
// global configuration
float vector_scale = 0.05; // vector scaling factor, we want small steps
float time = 0; // time passes by
 
void setup() {
  fullScreen();
  background(0, 5, 25);
  noFill();
  smooth(8);
  
  // Draw box
  strokeWeight(0.005 * width);
  color(25, 5, 0);
  line(0.25 * width, 0.25 * height, 0.25 * width, 0.75 * height);
  line(0.25 * width, 0.75 * height, 0.75 * width, 0.75 * height);
  line(0.75 * width, 0.75 * height, 0.75 * width, 0.25 * height);
  line(0.75 * width, 0.25 * height, 0.25 * width, 0.25 * height);
  strokeWeight(0.0003 * width);

 
  // Create distorted points -- range is later mapped to width/height
  for (int x=-48; x<=48; x++) {
    for (int y=-48; y<=48; y++) {
      PVector v = new PVector(x+randomGaussian()*0.045, y+randomGaussian()*0.045);
      points.add(v);
    }
  }
}
 
void draw() {
  int point_idx = 0; // point index
  for (PVector p : points) {
    // map floating point coordinates to screen coordinates
    float xx = map(p.x, -100, 100, 0, width);
    float yy = map(p.y, -100, 100, 0, height);
 
    // select color from palette (index based on noise)
    int cn = (int)(100 * pal.length * noise(point_idx)) % pal.length;
    stroke(pal[cn], 15);
    point(xx, yy); //draw
 
    // Evolving the vectors
    float n = 2 * TWO_PI * map(noise(p.x/5, p.y/5), 0, 1, -1, 1);
    PVector v = new PVector(cos(n), sin(n));
 
    p.x += vector_scale * v.x;
    p.y += vector_scale * v.y;
 
    // go to the next point
    point_idx++;
  }
  time += 0.001;
}
