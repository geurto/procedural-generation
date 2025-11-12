int num_drops = 3000;
ArrayList<Drop> drops = new ArrayList<Drop>();
ArrayList<Integer> palette = new ArrayList<Integer>();

void setup() {
  fullScreen();
  colorMode(RGB);
  
  SunrisePalette palette = new SunrisePalette();
  //CyberpunkPalette palette = new CyberpunkPalette();
  
  // Whole lotta drops
//  for (int i = 0; i < num_drops; i++) {
//    addInk(
//      random(width),
//      random(height),
//      random(5, 40),
//      palette.colours.get((int)random(palette.colours.size())));
//  }
  
  // Custom background
  addInk(
    width / 2, 
    height / 2, 
    100, 
    palette.colours.get((int)random(palette.colours.size()))
  );
  
  for (int i = 0; i < 10; i++) {
    addInk(
      width * random(0.45, 0.55),
      height * random(0.45, 0.55),
      random(50, 120),
      palette.colours.get((int)random(palette.colours.size()))
    );
  }
  PVector m = new PVector(-1, 1);
  m.normalize();
  for (int i = -3; i < 3; i++) {
    PVector b = new PVector(width / 2, height / 2);
    b.x += 0.05 * width * i;
    b.y += 0.05 * height * i;
    tineLine(m, b, 80, 2); 
  }
   
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
