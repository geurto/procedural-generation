class World {
  ArrayList<Particle> particles = new ArrayList<Particle>();
  int num_colors, num_particles;
  int particle_size;
  float[][] attractions, min_dist, max_dist;
  
  World(int num_colors, int num_particles, int particle_size) {
    this.num_colors = num_colors;
    this.num_particles = num_particles;
    this.particle_size = particle_size;
  }
  
  void restart() {
    this.particles.clear();
    this.createParticles();
  }
  
  void createParticles() {
    // generate random attractions to other colours, as well as min/max distance for attractions
    this.attractions = new float[this.num_colors][this.num_colors];
    this.min_dist = new float[this.num_colors][this.num_colors];
    this.max_dist = new float[this.num_colors][this.num_colors];
    
    this.randomizeWeights();
    
    for (int c = 0; c < this.num_colors; c++) {
      this.addParticles(c, this.num_particles);
    }
  }
  
  void randomizeWeights() {
    for (int c = 0; c < this.num_colors; c++) {
      for (int i = 0; i < num_colors; i++) {
        attractions[c][i] = 0.25 * int(random(-4, 4));
        this.min_dist[c][i] = this.particle_size * random(1, 2);
        this.max_dist[c][i] = this.particle_size * random(5, 20);
      }
    }
  }
  
  void addParticles(int type, int num_particles) {
    for (int p = 0; p < num_particles; p++) {
        this.particles.add(new Particle(type, this.num_colors, this.particle_size));
      }
  }
  
  void removeRandomParticles(int n) {
    for (int i = 0; i < n; i++) {
      int index_to_remove = int(random(this.particles.size()));
      this.particles.remove(index_to_remove);
    }
  }
  
  void step() {
    for (int i = 0; i < this.particles.size(); i++) {
      Particle p = this.particles.get(i);
      
      for (int j = 0; j < this.particles.size(); j++) {
        if (i != j) {
          Particle q = this.particles.get(j);
          float d_min = this.min_dist[p.type][q.type];
          float d_max = this.max_dist[p.type][q.type];
          
          // calculate forces between particles
          float dx = q.x - p.x;
          float dy = q.y - p.y;
          float dist = dist(p.x, p.y, q.x, q.y);
          
          if ((dist < 0.01) || (dist > d_max)) {
            continue;
          }
          
          float f;
          if (dist > d_min) {
            f = this.attractions[p.type][q.type] * (1.0 - (2.0 * abs(dist - 0.5 * (d_max + d_min)) / (d_max - d_min)));
          } else {
            //f = (minDist - dist) / (minDist - p.size /2);
            f = 2 * p.size * d_min * (1 / (d_min + 2 * p.size) - 1 / (dist + 2 * p.size));
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
