int num_drops = 20;
ArrayList<Drop> drops = new ArrayList<Drop>();

void setup() {
  size(800, 800);
  colorMode(HSB, 360, 100, 100, 1.0);

  for (int i = 0; i < num_drops; i++) {
    addInk(400, 400, 50, color(0, 0, random(80)));
  }
  
  PVector m = new PVector(0, 1);
  m.normalize();
  PVector b = new PVector(0, 100);
  
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
