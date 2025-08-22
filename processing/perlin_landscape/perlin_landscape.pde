int cols, rows;
int ws = 1200;
int hs = 600;
int scl = 20;

int w = 2 * ws;
int h = 2 * hs;

float flying = 0;
float[][] terrain;

void setup() {
  size(1200, 600, P3D);
  cols = w / scl;
  rows = h / scl;
  
  terrain = new float[cols][rows];
}

void draw() {
  flying -= 0.05;
  background(0);
  noFill();
  
  translate(width / 2, height / 2);
  rotateX(PI/3);
  
  translate(-w/2, -h/2);
  
  float yoff = flying;
  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -100, 100);
      xoff += 0.15;
    }
    yoff += 0.15;
  }
  
  for (int y = 0; y < rows - 1; y++) {
    stroke(color(0, 255, 0), y);
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {
      vertex(x * scl, y * scl, terrain[x][y]);
      vertex(x * scl, (y + 1) * scl, terrain[x][y + 1]);
    }
    endShape();
  }
      
}
