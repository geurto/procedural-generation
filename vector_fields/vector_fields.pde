class Particle {
  float x, y;
  float x_speed, y_speed;
  float max_speed = 5;
  PVector acc;
  
  color c;
  float size;
  
  
  Particle(float _x, float _y) {
    x = _x;
    y = _y;
    
    int w = (int)random(30, 255);
    c = color(w, w, w);
    size = width/200 + (width/500) * (randomGaussian() - 0.5);
  }
  
  PVector vector_field(float x, float y) {
    x = map(x, 0, width, -3, 3);
    y = map(y, 0, height, -3, 3);
    
    float u = sin(y) + cos(y);
    float v = sin(x) - cos(y);
    
    u += 2 * noise(x, frameCount / 50) - 0.5;
    v += 2 * noise(y, frameCount / 50) - 0.5;
    
    return new PVector(u, v);
  }

  
  void move() {
    acc = vector_field(x, y);
    x_speed += 0.2 * (acc.x + randomGaussian());
    y_speed += 0.2 * (acc.y + randomGaussian());
    
    // Speed limiting
    if (x_speed > max_speed) {x_speed = max_speed;}
    if (x_speed < -max_speed) {x_speed = -max_speed;}
    if (y_speed > max_speed) {y_speed = max_speed;}
    if (y_speed < -max_speed) {y_speed = -max_speed;}

    
    x += x_speed;
    y += y_speed; 
    
    // Going past boundary
    if (x < 0) {x = width;}
    if (x > width) {x = 0;}
    if (y < 0) {y = height;}
    if (y > height) {y = 0;}

  }
  
  void display() {
    circle(x, y, size);
    noStroke();
    fill(c);
  }
}

// ------------------------------------ //
Particle particles[];
int num_particles = 1000;

void setup() {
  size(1200, 400);
  background(0);
  
  particles = new Particle[num_particles];
  for (int i = 1; i < num_particles; i++) {
    float _x = random(0, width);
    float _y = random(0, height);
    particles[i] = new Particle(_x, _y);
    if (i == 21) {particles[i].c = color(25, 0, 0);}
  }
}

void draw() {
  background(0);
  for (int i = 1; i < num_particles; i++) {
    particles[i].move();
    particles[i].display();
  }
}
