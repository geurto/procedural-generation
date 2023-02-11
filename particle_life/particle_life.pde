Particle[] redParticles;
Particle[] greenParticles;
//Particle[] blueParticles;
//Particle[] yellowParticles;
int numParticles = 10;

void setup() {
  fullScreen();
  colorMode(HSB, 360, 100, 100, 1.0);
  
  color red = color(0, 100, 100);
  color green = color(120, 100, 100);
  //color blue = color(240, 100, 100);
  //color yellow = color(60, 100, 100);
  
  redParticles = new Particle[numParticles];
  greenParticles = new Particle[numParticles];
  //blueParticles = new Particle[numParticles];
  //yellowParticles = new Particle[numParticles];
  
  float[][] attraction_matrix = {{0.6, -0.2}, {0.4, 0.2}};
  
  for (int i = 0; i < numParticles; i++) {
      redParticles[i] = new Particle(red, attraction_matrix, 0);
      greenParticles[i] = new Particle(green, attraction_matrix, 1);
  }
}

void draw() {
  background(0, 0, 0);
  for (int i = 0; i < numParticles; i++) {
    redParticles[i].evolve();
    greenParticles[i].evolve();
    
    redParticles[i].draw();
    greenParticles[i].draw();
  }
}
