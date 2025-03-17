// Color pallette: https://applecolors.com/palette/21064-neon-at-night-palette
class Car {
  //float hue;
  //float saturation;
  //float brightness;
  color car_color;
  float car_length;
  float car_width;
  float xpos;
  float ypos;
  float speed;
  boolean horizontal;
  
  Car(float car_length, float car_width, color car_color) { 
    this.setParameters(car_length, car_width, car_color); 
  }

  void setParameters(float car_length, float car_width, color car_color) {
    // Size
    this.car_length = car_length;
    this.car_width = car_width;
    this.car_color = car_color;
    
    this.horizontal = false;

    // Position and speed
    this.xpos = width/2 + (width/3) * randomGaussian();
    this.ypos = height/2 + (height/3) * randomGaussian();    
    this.speed = max(0.1, 0.1 + randomGaussian() * 5/this.car_width);
    
    // Color
    //float r = random(0, 1);
    //if (r > 0.8) {this.hue = 54; this.saturation = 92; this.brightness = 95;}  // yellow
    //else if (r > 0.5) {this.hue = 327.57; this.saturation = 92; this.brightness = 100;}  // light pink
    //else {this.hue = 158.94; this.saturation = 42; this.brightness = 88;} // soft green
  }
  
  void move() {
    float dpos = this.speed + 0.001 * dist(this.xpos, this.ypos, width/2, height/2);
    this.ypos = this.ypos + dpos;
  }
  
  void reposition() {this.ypos = -this.car_length;}

  void display() {
    //this.fillDistortedColor();
    fill(this.car_color);
    if (this.horizontal) {rect(this.xpos,this.ypos,this.car_length,this.car_width);} 
    else {rect(this.xpos, this.ypos, this.car_width, this.car_length);}
  }
  
  void fillDistortedColor() {
    //double theta = generateNoise(this.xpos, this.ypos) * Math.PI * 3;
    //double hue_noise = Math.cos(theta)*10 + Math.cos(frameCount/100.0)*10;
    //double hue_distorted = this.hue + hue_noise;
    //color c = color((float)hue_distorted, this.saturation, this.brightness);
  }
  
  double generateNoise(float x, float y) {
    float z = frameCount / 400.0;
    float z2 = frameCount / 2000.0;
    float noiseX = 0.01 * (dist(this.xpos, this.ypos, width/2, height/2) + z2); 
    float noiseY = 0.01 * (dist(this.xpos, this.ypos, width/2, height/2) + z2); 
    return noise(noiseX, noiseY, z);
  }
}  // end Car class


class BackgroundCar extends Car {
  BackgroundCar(float car_length, float car_width, color car_color) {
    super(car_length, car_width, car_color);
    this.setParameters(car_length, car_width, car_color);
  }
  
  void setParameters(float car_length, float car_width, color car_color) {
    // Size
    this.car_length = car_length;
    this.car_width = car_width;
    this.car_color = car_color;
    
    
    this.horizontal = false;

    // Position and speed
    this.ypos = height/2 + (height/3) * randomGaussian();
    this.xpos = random(0, width);
    
    this.speed = max(0.1, 0.1 + randomGaussian() * 5/this.car_width);
    
    // Color
    //float r = random(0, 1);
    //if (r > 0.60) {this.hue = 177.53; this.saturation = 100; this.brightness = 76;}  // green
    //else if (r > 0.20) {this.hue = 261.57; this.saturation = 77; this.brightness = 78;}  // blue
    //else {this.hue = 0; this.saturation = 0; this.brightness = 100;}  // white
    //{this.brightness /= 2;}    
  }
}
