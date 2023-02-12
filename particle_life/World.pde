class World {
  ArrayList<Particle> particles = new ArrayList<Particle>();
  int num_colors, num_particles;
  
  World(int num_colors, int num_particles) {
    this.num_colors = num_colors;
    this.num_particles = num_particles;
    this.createParticles(num_colors, num_particles);
  }
  
  void createParticles(int num_colors, int num_particles) {
    for (int c = 0; c < num_colors; c++) {
      // generate random attractions to other colours, as well as min/max distance for attractions
      float[] attractions = new float[num_colors];
      float[] minimum_distance = new float[num_colors];
      float[] maximum_distance = new float[num_colors];
      
      for (int i = 0; i < num_colors; i++) {
      attractions[i] = random(-1.0, 1.0);
      minimum_distance[i] = random(5, 10);
      maximum_distance[i] = random(25, 100);
    }
      for (int p = 0; p < num_particles; p++) {
        this.particles.add(new Particle(c, num_colors, attractions, minimum_distance, maximum_distance));
      }
    }
  }
  
  void step() {
    for (int i = 0; i < this.particles.size(); i++) {
      Particle p = this.particles.get(i);
      
      for (int j = 0; j < this.particles.size(); j++) {
        if (i != j) {
          Particle q = this.particles.get(j);
          float minDist = p.minDist[q.type];
          float maxDist = p.maxDist[q.type];
          
          // calculate forces between particles
          float dx = q.x - p.x;
          float dy = q.y - p.y;
          float dist = dist(p.x, p.y, q.x, q.y);
          
          // particles can't be closer to each other than half their size
          if ((dist < 0.01) || (dist > maxDist)) {
            continue;
          }
          
          float f;
          if (dist > minDist) {
            f = p.attractions[q.type] * (1.0 - (2.0 * abs(dist - 0.5 * (maxDist + minDist)) / (maxDist - minDist)));
          } else {
            //f = (minDist - dist) / (minDist - p.size /2);
            f = 2 * p.size * minDist * (1 / (minDist + 2 * p.size) - 1 / (dist + 2 * p.size));
          }
          p.vx += f * dx / dist;
          p.vy += f * dy / dist;
        }
      }
      p.step();  // step particle
    }
  }
  
  void draw() {
    background(0, 0, 0);
    for (int i = 0; i < this.particles.size(); i++) {
      Particle part = this.particles.get(i);
      part.draw();
    }
  }
}
