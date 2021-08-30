color c = color(0);
float x = 0;
float y = 100;
float speed = 1;
float car_length = 30;
float car_width = 10;
Car[] cars;
int numCars = 5;

class Car {
  color c;
  float xpos;
  float ypos;
  float speed;
  boolean horizontal;
  boolean forwards;
  
  Car() {};
  Car(color C, float XPOS, float YPOS,float SPEED, boolean HORIZONTAL, boolean FORWARDS) {
    c = C;
    xpos = XPOS;
    ypos = YPOS;
    speed = SPEED;
    horizontal = HORIZONTAL;
    forwards = FORWARDS;
  }
  
  void move() {
    this.xpos = this.xpos + speed;
    if (this.xpos > width) {
      this.xpos = 0;
    }
  }

  void display() {
    fill(c);
    rect(this.xpos,this.ypos,car_length,car_width);
    
    if (this.xpos > width - car_length){
      // Draw car partially on other side as well
      rect(0, this.ypos, car_length-(width-this.xpos), car_width);
    }
  }
}

void setupCar(Car c){
  float col = random(0, 255);
  c.c = color(col, col, col);
  c.xpos = random(0, width);
  c.ypos = random(0, height);
  c.speed = random(0, 5);
  c.horizontal = true;
  float f = random(0, 10);
  if (f > 5) {
    c.forwards = true;
  } else {
    c. forwards = false;
  }
  println("Set up new car width whiteness " + col + ", position " + c.xpos + c.ypos + ", speed " + c.speed);
}

void setup() {
  size(1200, 200);
  
  cars = new Car[numCars];
  for (int i = 0; i < cars.length; i++) {
    cars[i] = new Car();
    setupCar(cars[i]);
  }
}

void draw() {
  background(255);
  for (int i = 0; i < cars.length; i++) {
    cars[i].move();
    cars[i].display();
  }
}
