color c = color(0);
Car[] cars;
int numCars = 100;

class Car {
  color c;
  float car_length;
  float car_width;
  float xpos;
  float ypos;
  float speed;
  float speed_direction;
  boolean horizontal;
  
  Car() {
    float col = random(0, 255);
    this.c = color(col, col, col);
    this.car_length = random(10, 50);
    this.car_width = this.car_length * random(0.2, 0.5);
    this.xpos = width/2 + (width/8) * randomGaussian();
    this.ypos = height/2 + (height/8) * randomGaussian();
    this.speed = random(8, 50)/(this.car_length * this.car_width);
    
    // Determine direction of movement
    float f = random(0, 1);
    if (f > 0.75) {
      this.speed_direction = 1;
      this.horizontal = true;
    } else if (f > 0.5) {
      this.speed_direction = -1;
      this.horizontal = true;
    } else if (f > 0.25) {
      this.speed_direction = 1;
      this.horizontal = false;
    } else {
      this.speed_direction = -1;
      this.horizontal = false;
    }
    println("Set up new car width whiteness " + col + ", position " + this.xpos + this.ypos + ", speed " + this.speed);
  }

  void move() {
    this.xpos = this.xpos + this.speed * this.speed_direction;
    if (this.xpos > width) {
      this.xpos = 0;
    }
  }

  void display() {
    fill(c);
    rect(this.xpos,this.ypos,this.car_length,this.car_width);
    
    if (this.xpos > width - this.car_length){
      // Draw car partially on other side as well
      rect(0, this.ypos, this.car_length-(width-this.xpos), this.car_width);
    }
  }
}


void setup() {
  size(1200, 200);
  
  cars = new Car[numCars];
  for (int i = 0; i < cars.length; i++) {
    cars[i] = new Car();
  }
}

void draw() {
  background(255);
  for (int i = 0; i < cars.length; i++) {
    cars[i].move();
    cars[i].display();
  }
}
