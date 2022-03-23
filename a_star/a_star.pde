int cols = 50;
int rows = 50;
float w;
float h;

Cell[][] grid = new Cell[rows][cols];
ArrayList<Cell> openSet = new ArrayList<Cell>();
ArrayList<Cell> closedSet = new ArrayList<Cell>();

Cell start;
Cell end;
ArrayList<Cell> path = new ArrayList<Cell>();

float heuristic(Cell a, Cell b) {
  //return dist(a.x, a.y, b.x, b.y); 
  return abs(a.x - b.x) + abs(a.y - b.y);
}

void setup() {
  size(800, 800);
  println("Starting A* with " + rows + "x" + cols + " grid.");
  
  w = width / cols;
  h = height / rows;
  
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      grid[i][j] = new Cell(i, j, w, h);
    }
  }
  
  // add neighbours for each cell
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      grid[i][j].addNeighbours(grid);
    }
  }
  
  //start = grid[int(random(0, rows - 1))][int(random(0, cols - 1))];
  //end = grid[int(random(0, rows - 1))][int(random(0, cols - 1))];
  start = grid[0][0];
  end = grid[rows - 1][cols - 1];
  start.obstacle = false;
  end.obstacle = false;
  
  openSet.add(start);
}

void draw() {  
  if (openSet.size() > 0) {
    // we can keep going
    
    // get open node with lowest f-score
    int lowestIndex = 0;
    for (int i = 0; i < openSet.size(); i++) {
      if (openSet.get(i).f < openSet.get(lowestIndex).f) {
        lowestIndex = i;
      }
    }
    
    Cell current = openSet.get(lowestIndex);
    
    if (current == end) {
      // found it
      println("Done!");
      noLoop();
    } else {
      // remove current from open and add to closed
      openSet.remove(current);
      closedSet.add(current);
      
      // check neighbours
      ArrayList<Cell> neighbours = current.neighbours;
      for (int i = 0; i < neighbours.size(); i++) {
        Cell neighbour = neighbours.get(i);
        
        // check if neighbour in closed set
        // can use binary tree for more efficiency
        if (closedSet.lastIndexOf(neighbour) == -1 && !neighbour.obstacle) {
          float tempG = current.g + 1;
          
          // check if new G-score is lower than older (if any) - if so, this is the new fastest path
          if (openSet.lastIndexOf(neighbour) != -1) {
            if (tempG < neighbour.g) {
              neighbour.g = tempG;
            }
          // add neighbour to open set
          } else {
            neighbour.g = tempG;
            openSet.add(neighbour);
          }
          neighbour.h = heuristic(neighbour, end);
          neighbour.f = neighbour.g + neighbour.h;
          neighbour.cameFrom = current;
        }
      }
      
      // trace back path
      path.clear();
      path.add(current);
      while (current.cameFrom != null) {
        path.add(current.cameFrom);
        current = current.cameFrom;
      }
    }
    
  } else {
    // no solution
    print("No solution.");
    noLoop();
    return;
  }
  
  // *** Draw cells *** //
  background(0);
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      grid[i][j].show(color(#FCCE8E));
    }
  }
  
  for (int i = 0; i < closedSet.size(); i++) {
    closedSet.get(i).show(color(#FBE7D3));
  }
  
  for (int i = 0; i < openSet.size(); i++) {
    openSet.get(i).show(color(#BED8CF));
  }
  
  for (int i = 0; i < path.size(); i++) {
    path.get(i).show(color(#0CAFA9)); 
  }
  
  start.show(color(#ED6F00));
  end.show(color(#05E288));
}
