NoiseOrbit noise_orbit;

void setup() {
  size(1200, 400);
  int num_circles = 50;
  float interval = w(0.01);
  float min_radius = w(0.05);
  int num_sides = 50;

  colorMode(HSB, 360, 100, 100, 1.0);
  noise_orbit = new NoiseOrbit(num_circles, interval, min_radius, num_sides);
  
  noise_orbit.create();
}

void draw() {
  background(0, 0, 100); // white background
  noise_orbit.loop();
}

float w(float val) {
  return width * val;
}
float h(float val) {
  return height * val;
}
