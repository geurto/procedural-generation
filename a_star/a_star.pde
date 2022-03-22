int cols = 5;
int rows = 5;

Cell[][] grid = new Cell[rows][cols];
ArrayList<Cell> openSet = new ArrayList<Cell>();
ArrayList<Cell> closedSet = new ArrayList<Cell>();

Cell start;
Cell end;

void setup() {
  size(800, 800);
  
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      grid[i][j] = new Cell(0, 0, 0);
    }
  }
  
  start = grid[0][0];
  end = grid[rows - 1][cols - 1];
  
  openSet.add(start);
}

void draw() {
  background(0);
}
