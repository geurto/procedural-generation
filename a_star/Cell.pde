class Cell {
  int x;
  int y;
  
  float f;
  float g;
  float h;
  
  float wc;
  float hc;
  
  boolean obstacle = false;
  
  ArrayList<Cell> neighbours = new ArrayList<Cell>();
  Cell cameFrom = null;
  
  Cell(int x, int y, float wc, float hc) {
    this.x = x;
    this.y = y;
    this.wc = wc;
    this.hc = hc;
    
    if (random(1) < 0.3) {
      this.obstacle = true;
    }
  }
  
  void show(color col) {
    if (this.obstacle) {
      fill(#963F2D);
    } else {
      fill(col);
    }
    noStroke();
    rect(this.x * this.wc, this.y * this.hc, this.wc - 1, this.hc - 1);
  }
  
  void addNeighbours(Cell[][] grid) {
    ArrayList<Integer> xVals = new ArrayList<Integer>();
    ArrayList<Integer> yVals = new ArrayList<Integer>();
    xVals.add(0);
    yVals.add(0);
    
    if (this.x > 0) { xVals.add(-1); }
    if (this.x < grid[0].length - 1) { xVals.add(1); }
    if (this.y > 0) { yVals.add(-1); }
    if (this.y < grid.length - 1) { yVals.add(1); }
    
    for (int i = 0; i < xVals.size(); i++) {
      for (int j = 0; j < yVals.size(); j++) {
        int x = this.x + xVals.get(i);
        int y = this.y + yVals.get(j);
        this.neighbours.add(grid[x][y]);
      }
    }
    
    //if (this.x > 0) { this.neighbours.add(grid[this.x - 1][this.y]); }
    //if (this.x < grid[0].length - 1) { this.neighbours.add(grid[this.x + 1][this.y]); }
    //if (this.y > 0) { this.neighbours.add(grid[this.x][this.y - 1]); }
    //if (this.y < grid.length - 1) { this.neighbours.add(grid[this.x][this.y + 1]); }
  }
}
