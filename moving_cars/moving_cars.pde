color c = color(0);
Car[] cars;
int numCars = 50;

class Car {
  color c;
  float car_length;
  float car_width;
  float xpos;
  float ypos;
  float speed;
  boolean horizontal;
  boolean forwards;
  
  Car() {
    float col = random(0, 255);
    this.c = color(col, col, col);
    this.car_length = random(10, 50);
    this.car_width = this.car_length * random(0.2, 0.5);
    this.xpos = random(0, width);
    this.ypos = random(0, height);
    this.speed = random(0, 5);
    this.horizontal = true;
    float f = random(0, 10);
    if (f > 5) {
      this.forwards = true;
    } else {
      this.forwards = false;
    }
    println("Set up new car width whiteness " + col + ", position " + this.xpos + this.ypos + ", speed " + this.speed);
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
