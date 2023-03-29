/*
 * Particle Life simulation
 * Controls:
 *  - ENTER: restart simulation with new particles and weights.
 *  - UP ARROW: increase number of particles for every type by 100.
 *  - DOWN ARROW: randomly remove 400 particles.
 *  - w/: ransomize weights (attractions, minimum/maximum attraction radii).
 *
 * TO DO:
 * - add/remove species with left/right arrows (auto-create colours based on current colour scheme).
 * - balance colour scheme by pressing c.
 * - show help by pressing h.
 * - visualize weights by pressing SHIFT+W.
 * - modify weights by left/right-clicking on visualized weights.
 * - select species with mouse-wheel, spawn particles at mouse location with left-click.
 * - have particles react to system audio.
 */

World world;
int num_types = 3;
int particles_per_type = 500;
boolean wrap = true;

void setup() {
  fullScreen();
  frameRate(60);
  colorMode(HSB, 360, 100, 100, 1.0);
    
  int particle_size = 5;
  world = new World(num_types, particles_per_type, particle_size, wrap);
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
    } else if (keyCode == LEFT) {
      // remove latest particle type
      world.removeParticleType();
    } else if (keyCode == RIGHT) {
      // add particle type
      world.addParticleType();
    }
  } else {
    if (keyCode == ENTER) {
      world.restart();
    } else if (keyCode == 'w' || keyCode == 'W') {
      world.randomizeAllWeights();
    } else if (keyCode == 'c' || keyCode == 'C') {
      world.balanceColours();
    }
  }
}
