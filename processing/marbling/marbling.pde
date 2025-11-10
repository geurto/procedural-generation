int num_drops = 3000;
ArrayList<Drop> drops = new ArrayList<Drop>();
ArrayList<Integer> palette = new ArrayList<Integer>();

void setup() {
  fullScreen();
  colorMode(RGB);
  
  palette.add(color(2, 3, 23));
  palette.add(color(2, 15, 67));
  palette.add(color(3, 38, 128));
  palette.add(color(25, 66, 172));
  palette.add(color(29, 111, 255));
  palette.add(color(0, 216, 255));
  palette.add(color(207, 235, 255));
  palette.add(color(255, 123, 225));
  palette.add(color(254, 59, 240));
  palette.add(color(99, 69, 251));
  
  palette.add(color(27, 4, 19));
  palette.add(color(34, 26, 65));
  //palette.add(color(72, 14, 36));
  //palette.add(color(115, 1, 35));
  palette.add(color(223, 5, 17));
  palette.add(color(255, 65, 139));
  palette.add(color(116, 98, 158));
  palette.add(color(86, 60, 107));
  palette.add(color(2, 201, 255));
  palette.add(color(191, 243, 255));
  palette.add(color(0, 91, 162));
  palette.add(color(14, 35, 78));
  palette.add(color(21, 3, 19));
  
  //colorMode(HSB, 360, 100, 100, 1.0);

  for (int i = 0; i < num_drops; i++) {
    addInk(
      random(width),
      random(height),
      random(5, 40),
      palette.get((int)random(palette.size())));
  }
  
  PVector m = new PVector(0, 1);
  m.normalize();
  PVector b = new PVector(400, 400);
  
  tineLine(m, b, 80, 16);    
}

void addInk(float x, float y, float r, color c) {
  Drop drop = new Drop(x, y, r, c);
  
  for (Drop other : drops) {
    other.marble(drop);
  }
  
  drops.add(drop);
}

void tineLine(PVector m, PVector b, float z, float c) {
  for (Drop drop : drops) {
    drop.tine(m, b, z, c);
  }
}

void draw() {
  background(0, 0, 100);
  
  for (Drop d : drops) {
    d.show();
  }
}
