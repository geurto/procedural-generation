Car[] cars;
int numCars = 1000;

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
    // Size
    this.car_length = random(10, 50);
    this.car_width = this.car_length * random(0.2, 0.35);
    float size_factor = (this.car_length*this.car_width) / (50 * 17.5);  // size divided by max_size
    
    // Position and speed
    this.xpos = width/2 + (width/8) * randomGaussian();
    this.ypos = height/2 + (height/6) * randomGaussian();
    this.speed = randomGaussian() * 40/(this.car_length * this.car_width);
    
    // Color
    //float hue = 60 + 5*randomGaussian() + 0.0001*random(0, 100)*(this.ypos - height/2)*(this.ypos - height/2);
    //float sat = 100;
    //float brightness = 90;
    float r = random(0, 1);
    float hue, sat, brightness;
    if (size_factor < 0.5) {
      if (r > 0.9) {hue = 0; sat = 80; brightness = 80;}  // red
      else if (r > 0.5) {hue = 54; sat = 90; brightness = 95;}  // yellow
      else {hue = 0; sat = 0; brightness = 100;} // white
    } else {
      if (r > 0.85) {hue = 120; sat = 50; brightness = 80;}  // green
      else if (r > 0.55) {hue = 220; sat = 50; brightness = 55;}  // blue
      else {hue = 0; sat = 0; brightness = 100;}  // white
    }
    this.c = color(hue, sat, brightness, 1.0);
    
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
    println("Set up new car with hue " + hue + ", position " + this.xpos + this.ypos + ", speed " + this.speed);
  }

  void move() {
    this.xpos = this.xpos + this.speed * this.speed_direction;
    if (this.xpos > width && this.speed_direction == 1) {
      this.xpos = 0;
    } else if (this.xpos < -this.car_length && this.speed_direction == -1) {
      this.xpos = width;
    }
  }

  void display() {
    fill(c);
    //noStroke();
    rect(this.xpos,this.ypos,this.car_length,this.car_width);
    
    // Draw car on other side when it falls off the map
    if (this.xpos > width - this.car_length && this.speed_direction == 1) {
      rect(0, this.ypos, this.car_length-(width-this.xpos), this.car_width);
    } else if (this.xpos < this.car_length && this.speed_direction == -1) {
      rect(width-(this.xpos-this.car_length), this.ypos, this.car_length-this.xpos, this.car_width);
    }
  }
}


void setup() {
  size(1600, 400);
  colorMode(HSB, 360, 100, 100, 1.0);
  
  cars = new Car[numCars];
  for (int i = 0; i < cars.length; i++) {
    cars[i] = new Car();
  }
}

void draw() {
  background(210, 50, 100, 1.0);
  for (int i = 0; i < cars.length; i++) {
    cars[i].move();
    cars[i].display();
  }
}
