int num_circles = 50;
int num_sides = 50;
NoiseCircle[] noise_orbit;

void setup() {
  size(800, 800);
  //fullScreen();
  float interval = w(0.01);
  float min_radius = w(0.05);

  noise_orbit = new NoiseCircle[num_circles];
  colorMode(HSB, 360, 100, 100, 1.0);
  for (int c = 0; c < num_circles; c++) {
    float radius = min_radius + c * interval;
    println(radius/width);
    noise_orbit[c] = new NoiseCircle(radius, num_sides);
  }
}

void draw() {
  background(0, 0, 100); // white background
  
  for (int n = 0; n < num_circles; n++) {
    noise_orbit[n].loop();
  }
}

float w(float val) {
  return width * val;
}
float h(float val) {
  return height * val;
}
