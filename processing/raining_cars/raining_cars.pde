Car[] foregroundCars;
BackgroundCar[] backgroundCars;
int numForegroundCars = 1500;
int numBackgroundCars = 2500;

void setup() {
  //size(1600, 800);
  fullScreen();
  colorMode(HSB, 360, 100, 100, 1.0);
  
  backgroundCars = new BackgroundCar[numBackgroundCars];
  foregroundCars = new Car[numForegroundCars];
  for (int i = 0; i < numBackgroundCars; i++) {
    float l = random(width/60, width/20);
    float w = l * random(0.2, 0.35);
    color c = color(random(210, 240), 80, 60);
    backgroundCars[i] = new BackgroundCar(l, w, c);
  }
  for (int i = 0; i < numForegroundCars; i++) {
    float l = random(width/160, width/40);
    float w = l * random(0.2, 0.35);
    color c = color(random(0, 30), 100, 100);
    foregroundCars[i] = new Car(l, w, c);
  }
}

void draw() {
  background(253.17, 100, 32, 1.00);
  for (int i = 0; i < backgroundCars.length; i++) {
    backgroundCars[i].move();
    backgroundCars[i].display();
    
    // If car is off the grid, generate a new start position and size and stuff
    if (backgroundCars[i].ypos > height+backgroundCars[i].car_length) { 
      backgroundCars[i].reposition();
    }
  }
  
  for (int i = 0; i < foregroundCars.length; i++) {
    foregroundCars[i].move();
    foregroundCars[i].display();
    
    // If car is off the grid, generate a new start position and size and stuff
    if (foregroundCars[i].ypos > height+foregroundCars[i].car_length) { 
      foregroundCars[i].reposition();
    }
  }
}
