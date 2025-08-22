class Region {
  int i, row, col;
  ArrayList<Region> neighbours = new ArrayList<Region>();
  ArrayList<Particle> particles = new ArrayList<Particle>();
  ArrayList<Particle> buffer = new ArrayList<Particle>();

  Region(int row, int col, int num_cols) {
    this.row = row;
    this.col = col;
    this.i = col + row * num_cols;
  }
}

class RegionGraph {
  int n_cols, n_rows;
  boolean wrap;
  float region_width, region_height;
  ArrayList<Region> graph = new ArrayList<Region>();
  
  RegionGraph(int n_cols, int n_rows, boolean wrap) {
    this.n_cols = n_cols;
    this.n_rows = n_rows;
    this.region_width = width / n_cols;
    this.region_height = height / n_rows;
    this.wrap = wrap;
    
    for (int i = 0; i < n_cols * n_rows; i++) {
      int row = floor(i / n_rows);
      int col = i % n_cols;
      this.graph.add(new Region(row, col, n_cols));
    }
    
    for (Region r: this.graph) {
      this.getRegionNeighbours(r);
    }
  }
  
  void getRegionNeighbours(Region r) {
    int directions[][] = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}, 
                          {1, 1}, {1, -1}, {-1, 1}, {-1, -1}};
                          
    for (int i = 0; i < 8; i++) {
      int[] dir = directions[i];
      int x_new, y_new;
      
      if (this.wrap) {
        x_new = (r.col + dir[0]) % this.n_cols;
        if (x_new < 0) { x_new += this.n_cols; }
        y_new = (r.row + dir[1]) % this.n_rows;
        if (y_new < 0) { y_new += this.n_rows; }
      } else {
        x_new = r.col + dir[0];
        y_new = r.row + dir[1];
        if (x_new < 0 || x_new >= this.n_cols || y_new < 0 || y_new >= this.n_rows) {
          continue;
        }
      }
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
