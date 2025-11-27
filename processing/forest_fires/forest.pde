float p_lightning = 1e-5;
float p_growth = 1e-3;

enum CellState {
  EMPTY,
  TREE,
  BURNING;
}

class Cell {
  int x;
  int y;
  color c;
  CellState state;
  CellState nextState;
  ArrayList<Cell> neighbours;
  
  Cell(int x, int y, CellState state) {
    this.x = x;
    this.y = y;
    this.state = state;
    this.nextState = state;
    this.neighbours = new ArrayList<Cell>();
  }
  
  void setNextState() {
    this.nextState = this.state;
    
    if (this.state == CellState.BURNING) {
      this.nextState = CellState.EMPTY;
    } else if (this.state == CellState.EMPTY) {
      float b = brightness(this.c);
      if (b <= 0 && random(1) < p_growth) {
          this.nextState = CellState.TREE;
      }
    } else if (this.state == CellState.TREE) {
      if (this.hasBurningNeighbour() || random(1) < p_lightning) {
        this.nextState = CellState.BURNING;
      }
    }
  }
  
  void step() {
    if (this.state == CellState.EMPTY && this.nextState == CellState.TREE) {
      this.c = color(random(90, 150), random(70, 100), random(50, 80));
    } else if (this.state == CellState.TREE && this.nextState == CellState.BURNING) {
      this.c = color(random(330, 390), random(70, 100), random(50, 80));
    }
    
    this.state = this.nextState;
    
    if (this.state == CellState.EMPTY) {
      float b = brightness(this.c);
      if (b > 0) {
        float b_new = b - 10 < 0 ? 0 : b - 10;
        this.c = color(hue(this.c), saturation(this.c), b_new);
      } else {
        this.c = color(0, 0, 0);
      }
    }
  }
  
  void addNeighbour(Cell cell) {
    this.neighbours.add(cell);
  }
  
  boolean hasBurningNeighbour() {
    for (Cell c : this.neighbours) {
      if (c.state == CellState.BURNING) {
        return true;
      }
    }
    return false;
  }
  
  void draw() {
    fill(this.c);
    rectMode(CENTER);
    rect(this.x, this.y, 3, 3);
  }
}

class Forest {
  int size;
  Cell[][] cells;
  
  Forest(int size) {
    this.size = size;
    this.cells = new Cell[size][size];
    
    // Spawn cells
    for (int i = 0; i < size; i++) {
      for (int j = 0; j < size; j++) {
        CellState state = CellState.EMPTY;
        if (random(1) < p_growth) {
          state = CellState.TREE;
        }
        
        this.cells[i][j] = new Cell(3 * i, 3 * j, state);
      }
    }
    
    // Add neighbours
    int[][] directions =  {{0, 1}, {0, -1}, {1, 0}, {-1, 0}, {1, 1}, {1, -1}, {-1, 1}, {-1, -1}};
    for (int i = 0; i < size; i++) {
      for (int j = 0; j < size; j++) {
        for (int d = 0; d < 8; d++) {
          int[] dir = directions[d];
          
          int new_x = i + dir[0];
          int new_y = j + dir[1];
          
          // bounds
          if (new_x < 0 || new_x >= this.size || new_y < 0 || new_y >= this.size) {
            continue;
          }
          this.cells[i][j].addNeighbour(this.cells[new_x][new_y]);
        }
      }
    }
  }
  
  void step() {
    for (int i = 0; i < this.size; i++) {
      for (int j = 0; j < this.size; j++) {
        this.cells[i][j].setNextState();
      }
    }
    
    for (int i = 0; i < this.size; i++) {
      for (int j = 0; j < this.size; j++) {
        this.cells[i][j].step();
        this.cells[i][j].draw();
      }
    }
  }  
}
