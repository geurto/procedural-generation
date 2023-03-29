class World {
  ArrayList<ArrayList<Particle>> particles = new ArrayList<ArrayList<Particle>>();
  RegionGraph regions;
  int num_colors, num_particles;
  int particle_size;
  ArrayList<ArrayList<Float>> attractions;
  ArrayList<ArrayList<Float>> min_dist;
  ArrayList<ArrayList<Float>> max_dist;
  boolean wrap;
  boolean draw_lines = false;
  
  World(int num_colors, int num_particles, int particle_size, boolean wrap) {
    /* Create world with a set number of particles and particle types.
     * Initialize ArrayLists with particle interaction coefficients.
     */
    println("Creating world with:");
    println("- " + num_colors + " particle types");
    println("- " + num_particles + " particles per type");
    println("- particles of diameter " + particle_size);
    println("- wrapping: " + wrap);
    
    this.num_colors = num_colors;
    this.num_particles = num_particles;
    this.particle_size = particle_size;
    this.wrap = wrap;
    
    // create arraylists of particle variables
    this.attractions = new ArrayList<ArrayList<Float>>();
    this.min_dist = new ArrayList<ArrayList<Float>>();
    this.max_dist = new ArrayList<ArrayList<Float>>();
    for (int i = 0; i < num_colors; i++) {
      this.particles.add(new ArrayList<Particle>());
      this.attractions.add(new ArrayList<Float>());
      this.min_dist.add(new ArrayList<Float>());
      this.max_dist.add(new ArrayList<Float>());
      
      for (int j = 0; j < num_colors; j++) {
        this.attractions.get(i).add(0.);
        this.min_dist.get(i).add(0.);
        this.max_dist.get(i).add(0.);
      }
    }
    this.randomizeAllWeights();
  }
  
  void restart() {
    /*
     * Completely reset world to beginning parameters, removing any added particles and types.
     */
    this.particles.clear();
    this.createParticles();
    this.createRegions();
  }
  
  void createParticles() {
    /*
     * Create num_particles for every one of num_colors colors.
     */
    for (int c = 0; c < this.num_colors; c++) {
      this.addParticles(c, this.num_particles);
    }
  }
  
  void randomizeAllWeights() {
    /*
     * Randomize the interaction coefficients of all existing particle types
     */
    for (int i = 0; i < this.num_colors; i++) {
      for (int j = 0; j < this.num_colors; j++) {
        this.generateRandomParticleWeights(i, j);
      }
    }
    this.createRegions();
  }
  
  void generateRandomParticleWeights(int i, int j) {
    /*
     * Generate random weights for interactions between two particle types.
     */ 
     this.attractions.get(i).set(j, 0.25 * int(random(-4, 4)));
     this.min_dist.get(i).set(j, this.particle_size * random(1, 2));
     this.max_dist.get(i).set(j, this.particle_size * random(5, 20));
  }
  
  void addParticles(int type, int num_particles) {
    /*
     * Add a fixed number of particles per type.
     */
    for (int p = 0; p < num_particles; p++) {
      this.particles.get(type).add(new Particle(type, this.num_colors, this.particle_size, this.wrap));
    }
    println("Total number of particles: " + this.particles.size());
  }
  
  void removeRandomParticles(int n) {
    /*
     * Remove n random particles in total, randomly across different types.
     */
    for (int i = 0; i < n; i++) {
      if (this.particles.size() == 0) { break; }
      int index_to_remove = int(random(this.particles.size()));
      this.particles.remove(index_to_remove);
    }
  }
  
  void addParticleType() {
    /*
     * Add a particle type. Create a fitting color, and update the interaction coefficients.
     */
    int num_particles = this.particles.size() / this.num_colors;
    color c = color(((this.num_colors - 1 / this.num_colors) + 360) / 2, 100, 100);
    this.num_colors += 1;
    
    println("Creating new particle type (#" + this.num_colors + ") with " + num_particles + " particles."); 
    
    // add new particles
    for (int i = 0; i < num_particles; i++) {
      Particle p = new Particle(this.num_colors - 1, this.num_colors, this.particle_size, this.wrap);
      p.c = c;
      this.particles.get(this.num_colors - 1).add(p);
    }
    
    // update interactions
    for (int i = 0; i < this.num_colors - 1; i++) {
      // add extra float to each row
      this.attractions.get(i).add(0.);
      this.min_dist.get(i).add(0.);
      this.max_dist.get(i).add(0.);
      this.generateRandomParticleWeights(i, this.num_colors - 1);
    }
    
    // then add an extra row
    this.attractions.add(new ArrayList<Float>());
    this.min_dist.add(new ArrayList<Float>());
    this.max_dist.add(new ArrayList<Float>());
    for (int i = 0; i < this.num_colors; i++) {
      this.attractions.get(this.num_colors - 1).add(0.);
      this.min_dist.get(this.num_colors - 1).add(0.);
      this.max_dist.get(this.num_colors - 1).add(0.);
      this.generateRandomParticleWeights(this.num_colors - 1, i);
    }
    this.balanceColours();
  }
  
  void removeParticleType() {
    // remove last particle type
    println("Removing particle type #" + (this.num_colors - 1) + ".");
    ArrayList<Integer> indices_to_remove = new ArrayList<Integer>();
    for (int i = 0; i < this.particles.size(); i++) {
      if (this.particles.get(i).type == this.num_colors - 1) { 
        indices_to_remove.add(i);
      }
    }
    for (int i = 0; i < indices_to_remove.size(); i++) {
      this.particles.remove(i);
    }
    this.balanceColours();
  }
  
  void balanceColours() {
    // give all types a distinct colour
    for (int c = 0; c < this.num_colors; c++) {
      
    }
  }
  
  void createRegions() {
    /* Region size should AT LEAST be the maximum attraction distance, so that any interacting particles are at most 1 region apart.
     * so num_columns = floor(width / MAX_DIST) etc. 
     */
    float d_max = 0;
    for (int t = 0; t < this.num_colors; t++) {
      ArrayList<Float> m = this.max_dist.get(t);
      for (float f: m) {
        if (f > d_max) { d_max = f; }
      }
    }
    
    int num_rows = floor(height / d_max);
    int num_columns = num_rows;
    println("Creating graph with " + num_rows + " x " + num_rows + " cells (cell size WxH " + width/num_columns + "x" + height/num_rows + ").");

    this.regions = new RegionGraph(num_columns, num_rows, this.wrap);
    
    for (Particle p: this.particles) {
      Region r = this.regions.getRegion(p.x, p.y);
      r.particles.add(p);
    }
  }
  
  void calculateInteraction(Particle p, Particle q) {
    float d_min = this.min_dist.get(p.type).get(q.type);
    float d_max = this.max_dist.get(p.type).get(q.type);
    
    // calculate forces between particles
    float dx = q.x - p.x;
    float dy = q.y - p.y;
    float px_rel = p.x;
    float py_rel = p.y;
    
    if (this.wrap) {
      if (dx > width / 2) { 
        dx -= width;
        px_rel += width;
      } else if (dx < -width / 2) {
        dx += width;
        px_rel -= width;
      }
      if (dy > height / 2) {
        dy -= height;
        py_rel += height;
      } else if (dy < -height / 2) {
        dy += height;
        py_rel -= height;
      }
    }
    float dist = dist(px_rel, py_rel, q.x, q.y);
    
    if ((dist < 0.01) || (dist > d_max)) {
      return;
    }
    
    float f;
    if (dist > d_min) {
      f = this.attractions.get(p.type).get(q.type) * (1.0 - (2.0 * abs(dist - 0.5 * (d_max + d_min)) / (d_max - d_min)));
    } else {
      f = 2 * p.size * d_min * (1 / (d_min + 2 * p.size) - 1 / (dist + 2 * p.size));
    }
    p.vx += f * dx / dist;
    p.vy += f * dy / dist;
  }
  
  void step() {
    for (int i = 0; i < this.particles.size(); i++) {
      Particle p = this.particles.get(i);
      Region r = this.regions.getRegion(p.x, p.y);
      
      // compute new particle velocity based on particles in own region...
      for (Particle q: r.particles) {
        this.calculateInteraction(p, q);
      }
      
      // ...and particles in neighbouring regions
      for (Region n: r.neighbours) {
        for (Particle q: n.particles) {
          this.calculateInteraction(p, q);
        }
      }
    }
    
    // now that all new velocities are calculated, evolve particles and compute new regions
    for (Particle p: this.particles) {
      p.step();  // step particle
      Region r_new = this.regions.getRegion(p.x, p.y);
      r_new.buffer.add(p);
    }
    
    // adopt new particle lists in regions
    for (Region r: this.regions.graph) {
      r.particles.clear();
      r.particles.addAll(r.buffer);
      r.buffer.clear();
    }
  }
  
  void draw() {
    background(0, 0, 0);
    
    if (this.draw_lines) {
      for (int rr = 0; rr < this.regions.n_rows; rr++) {
        stroke(255);
        line(0, rr * this.regions.region_height, width, rr * this.regions.region_height);
      }
      for (int rc = 0; rc < this.regions.n_cols; rc++) {
        stroke(255);
        line(rc * this.regions.region_width, 0, rc * this.regions.region_width, height);
      }
    }
    
    stroke(0);
    for (int i = 0; i < this.particles.size(); i++) {
      Particle part = this.particles.get(i);
      part.draw();
    }
  }
}
