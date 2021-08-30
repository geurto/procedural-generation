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
  
  Car() { this.setParameters(true); }

  void setParameters(boolean first_time) {
    // Size
    this.car_length = random(10, 50);
    this.car_width = this.car_length * random(0.2, 0.35);
    float size_factor = (this.car_length*this.car_width) / (50 * 17.5);  // size divided by max_size
    
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
    if (random(0,1) > 0.5) {this.horizontal = true;}
    else {this.horizontal = false;}
    
    // Position and speed
    if (first_time) {
      if (size_factor < 0.5) {
        this.xpos = width/2 + (width/6) * randomGaussian();
        this.ypos = height/2 + (height/6) * randomGaussian();
      }
      else {
        this.xpos = width/2 + (width/12) * randomGaussian();
        this.ypos = height/2 + (height/12) * randomGaussian();
      }
    } else {
      if (this.horizontal && this.speed_direction == 1) {this.xpos = -this.car_length;}
      else if (this.horizontal && this.speed_direction == -1) {this.xpos = width + this.car_length;}
      else if (!this.horizontal && this.speed_direction == 1) {this.ypos = -this.car_length;}
      else {this.ypos = height + this.car_length;}
    }    
    
    this.speed = randomGaussian() * 40/(this.car_length * this.car_width);
    
    // Color
    //float hue = 60 + 5*randomGaussian() + 0.0001*random(0, 100)*(this.ypos - height/2)*(this.ypos - height/2);
    //float sat = 100;
    //float brightness = 90;
    float r = random(0, 1);
    float hue, sat, brightness;
    if (size_factor < 0.5) {
      // Small cars
      if (r > 0.9) {hue = 0; sat = 80; brightness = 80;}  // red
      else if (r > 0.5) {hue = 54; sat = 90; brightness = 95;}  // yellow
      else {hue = 0; sat = 0; brightness = 100;} // white
    } else {
      // Big cars
      if (r > 0.80) {hue = 120; sat = 50; brightness = 80;}  // green
      else if (r > 0.40) {hue = 220; sat = 50; brightness = 55;}  // blue
      else {hue = 0; sat = 0; brightness = 100;}  // white
    }
    this.c = color(hue, sat, brightness, 1.0);
    
    println("Set up new car with hue " + hue + ", position " + this.xpos + this.ypos + ", speed " + this.speed);
  }
  
  void move() {
    if (this.horizontal) {
      this.xpos = this.xpos + this.speed * this.speed_direction;
      if (this.xpos > width+this.car_length && this.speed_direction == 1) {
        this.xpos = 0;
      } else if (this.xpos < -this.car_length && this.speed_direction == -1) {
        this.xpos = width;
      }
    } else {
      this.ypos = this.ypos + this.speed * this.speed_direction;
      if (this.ypos > height+this.car_length && this.speed_direction == 1) {
        this.ypos = 0;
      } else if (this.ypos < -this.car_length && this.speed_direction == -1) {
        this.ypos = height;
      }
    }
  }

  void display() {
    fill(c);
    if (this.horizontal) {rect(this.xpos,this.ypos,this.car_length,this.car_width);} 
    else {rect(this.xpos, this.ypos, this.car_width, this.car_length);}
  }
}  // end Car class


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
    
    // If car is off the grid, generate a new start position and size and stuff
    if ((cars[i].xpos > width+cars[i].car_length && cars[i].speed_direction == 1) || 
        (cars[i].xpos < -cars[i].car_length && cars[i].speed_direction == -1) || 
        (cars[i].ypos > height+cars[i].car_length && cars[i].speed_direction == 1) || 
        (cars[i].ypos < -cars[i].car_length && cars[i].speed_direction == -1)) {
      cars[i].setParameters(false);
    }
  }
}
