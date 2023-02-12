// TODO: add particles like in https://github.com/yanhann10/creative_coding/tree/master/p5/flow/flow-lines

FlowWindow[] windows;
 
// global configuration
float vector_scale = 0.05; // vector scaling factor, we want small steps
float time = 0; // time passes by
 
void setup() {
  fullScreen();
  background(0, 5, 25);
  noFill();
  smooth(8);
  
  windows = new FlowWindow[1];
  
  //windows[0] = new FlowWindow(width/4, height/4, width/8, height/8);
  //windows[1] = new FlowWindow(width/4, 3*height/4, width/8, height/8);
  //windows[2] = new FlowWindow(3*width/4, 3*height/4, width/8, height/8);
  //windows[3] = new FlowWindow(3*width/4, height/4, width/8, height/8);
  windows[0] = new FlowWindow(width/2, height/2, width * 0.9, height * 0.9);
}
 
void draw() {
  for (FlowWindow window : windows) {
    window.display();
  }
}
