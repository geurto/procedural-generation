class Region {
  int i, row, col;
  ArrayList<Region> neighbours = new ArrayList<Region>();
  ArrayList<Particle> particles = new ArrayList<Particle>();
  ArrayList<Particle> buffer = new ArrayList<Particle>();

  Region(int i, int number_of_regions) {
    this.i = i;
    this.row = floor(i / number_of_regions);
    this.col = i % number_of_regions;
  }
}

class RegionGraph {
  int n_cols, n_rows;
  float region_width, region_height;
  ArrayList<Region> graph = new ArrayList<Region>();
  
  RegionGraph(int n_cols, int n_rows) {
    this.n_cols = n_cols;
    this.n_rows = n_rows;
    this.region_width = width / n_cols;
    this.region_height = height / n_rows;
    
    for (int i = 0; i < n_cols * n_rows; i++) {
      this.graph.add(new Region(i, n_cols * n_rows));
    }
    
    for (Region r: this.graph) {
      this.getRegionNeighbours(r);
    }
  }
  
  void getRegionNeighbours(Region r) {
    int directions[][] = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}, 
                          {1, 1}, {1, -1}, {-1, 1}, {-1, -1}};
    for (int i = 0; i < 8; i++) {
      int x_new = (r.col + directions[i][0]) % this.n_cols;  // wrap back to other side
      int y_new = (r.row + directions[i][1]) % this.n_rows;
      if (x_new < 0) { x_new = this.n_cols - 1; }
      if (y_new < 0) { y_new = this.n_rows - 1; }
      r.neighbours.add(this.graph.get(x_new + y_new * this.n_cols));
    }
  }
  
  Region getRegion(float x, float y) {
    // return region particle is in
    int col = min(max(floor(x / this.region_width), 0), this.n_cols - 1);
    int row = min(max(floor(y / this.region_height), 0), this.n_rows - 1);
    return this.graph.get(col + row * this.n_cols);
  }
  
  void clear() {
    this.graph.clear();
  }
}
