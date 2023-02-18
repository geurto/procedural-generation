/*
 * Particle Life simulation
 * Controls:
 *  - ENTER: restart simulation with new particles and weights.
 *  - UP ARROW: increase number of particles for every type by 100.
 *  - DOWN ARROW: randomly remove 400 particles.
 *  - w/W: ransomize weights (attractions, minimum/maximum attraction radii).
 */

World world;
int num_types = 6;
int particles_per_type = 500;

void setup() {
  fullScreen();
  frameRate(60);
  colorMode(HSB, 360, 100, 100, 1.0);
    
  int particle_size = 5;
  world = new World(num_types, particles_per_type, particle_size);
  world.createParticles();
}

void draw() {
  background(0, 0, 0);
  world.step();
  world.draw();
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      for (int i = 0; i < num_types; i++) {
        world.addParticles(i, 100);
      }
    } else if (keyCode == DOWN) {
      world.removeRandomParticles(400);
    }
  } else {
    if (keyCode == ENTER) {
      world.restart();
    } else if (keyCode == 'w' || keyCode == 'W') {
      world.randomizeWeights();
    }
  }
}
