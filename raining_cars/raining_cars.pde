// Color pallette: https://applecolors.com/palette/21064-neon-at-night-palette
Car[] cars;
Car[] foregroundCars;
Car[] backgroundCars;
int numForegroundCars = 1500;
int numBackgroundCars = 2500;

class Car {
  float hue;
  float saturation;
  float brightness;
  float car_length;
  float car_width;
  float xpos;
  float ypos;
  float speed;
  float speed_direction;
  boolean horizontal;
  
  Car(boolean first_time, boolean background, float car_length, float car_width) { 
    this.setParameters(first_time, background, car_length, car_width); 
  }

  void setParameters(boolean first_time, boolean background, float car_length, float car_width) {
    // Size
    this.car_length = car_length;
    this.car_width = car_width;
    float size_factor = (this.car_length*this.car_width) / (50 * 17.5);  // size divided by max_size
    
    this.speed_direction = 1;
    this.horizontal = false;

    // Position and speed
    if (first_time) {
      if (size_factor < 0.5) {
        this.xpos = width/2 + (width/3) * randomGaussian();
        this.ypos = height/2 + (height/3) * randomGaussian();
      }
      else {
        this.xpos = width/2 + (width/3) * randomGaussian();
        this.ypos = height/2 + (height/3) * randomGaussian();
      }
    } else {
        this.ypos = -this.car_length;
      }
    if (background) {this.xpos = random(0, width);}
    
    this.speed = max(0.1, 0.1 + randomGaussian() * 5/this.car_width);
    
    // Color
    float r = random(0, 1);
    if (size_factor < 0.5) {
      // Small cars
      if (r > 0.8) {this.hue = 54; this.saturation = 92; this.brightness = 95;}  // yellow
      else if (r > 0.5) {this.hue = 327.57; this.saturation = 92; this.brightness = 100;}  // light pink
      else {this.hue = 158.94; this.saturation = 42; this.brightness = 88;} // soft green
    } else {
      // Big cars
      if (r > 0.60) {this.hue = 177.53; this.saturation = 100; this.brightness = 76;}  // green
      else if (r > 0.20) {this.hue = 261.57; this.saturation = 77; this.brightness = 78;}  // blue
      else {this.hue = 0; this.saturation = 0; this.brightness = 100;}  // white
    }
    if (background) {this.brightness /= 2;}    
  }
  
  void move() {
    float dpos = this.speed * this.speed_direction + 0.001 * dist(this.xpos, this.ypos, width/2, height/2);
    
    if (this.horizontal) {
      this.xpos = this.xpos + dpos;
      if (this.xpos > width+this.car_length && this.speed_direction == 1) {
        this.xpos = -this.car_length;
      } else if (this.xpos < -this.car_length && this.speed_direction == -1) {
        this.xpos = width;
      }
    } else {
      this.ypos = this.ypos + dpos;
      if (this.ypos > height+this.car_length && this.speed_direction == 1) {
        this.ypos = -this.car_length;
      } else if (this.ypos < -this.car_length && this.speed_direction == -1) {
        this.ypos = height;
      }
    }
  }

  void display() {
    this.fillDistortedColor();
    if (this.horizontal) {rect(this.xpos,this.ypos,this.car_length,this.car_width);} 
    else {rect(this.xpos, this.ypos, this.car_width, this.car_length);}
  }
  
  void fillDistortedColor() {
    double theta = generateNoise(this.xpos, this.ypos) * Math.PI * 3;
    double hue_noise = Math.cos(theta)*10 + Math.cos(frameCount/100)*10;
    double hue_distorted = this.hue + hue_noise;
    color c = color((float)hue_distorted, this.saturation, this.brightness);
    fill(c);
  }
  
  double generateNoise(float x, float y) {
    float z = frameCount / 400;
    float z2 = frameCount / 2000;
    float noiseX = 0.01 * (dist(this.xpos, this.ypos, width/2, height/2) + z2); 
    float noiseY = 0.01 * (dist(this.xpos, this.ypos, width/2, height/2) + z2); 
    return noise(noiseX, noiseY, z);
  }
}  // end Car class


void setup() {
  //size(1600, 800);
  fullScreen();
  colorMode(HSB, 360, 100, 100, 1.0);
  
  cars = new Car[numForegroundCars + numBackgroundCars];
  for (int i = 0; i < numBackgroundCars; i++) {
    float l = random(width/60, width/20);
    float w = l * random(0.2, 0.35);
    cars[i] = new Car(true, true, l, w);
  }
  for (int i = 0; i < numForegroundCars; i++) {
    float l = random(width/160, width/40);
    float w = l * random(0.2, 0.35);
    cars[i + numBackgroundCars] = new Car(true, false, l, w);
  }
  
}

void draw() {
  background(253.17, 100, 32, 1.00);
  for (int i = 0; i < cars.length; i++) {
    boolean background = false;
    if (i >= numBackgroundCars) {background = false;} else {background = true;}
    cars[i].move();
    cars[i].display();
    
    // If car is off the grid, generate a new start position and size and stuff
    if (cars[i].ypos > height+cars[i].car_length && cars[i].speed_direction == 1) { 
      cars[i].setParameters(false, background, cars[i].car_length, cars[i].car_width);
    }
  }
}
