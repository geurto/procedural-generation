int num_drops = 10;
ArrayList<Drop> drops = new ArrayList<Drop>();

void setup() {
  size(800, 800);
  colorMode(HSB, 360, 100, 100, 1.0);

  for (int d = 0; d < num_drops; d++) {
    color c = color(random(360), 100, 100);
    Drop drop = new Drop(
      random(width), 
      random(height), 
      random(10, 80),
      c
    );
    drops.add(drop);
  }
}

void draw() {
  background(0, 0, 100);
  
  for (Drop d : drops) {
    d.show();
  }
}
