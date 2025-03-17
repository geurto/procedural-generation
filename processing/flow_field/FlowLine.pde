class FlowLine {
  PVector v;
  int lineLength = 100;
  float segmentLength = w * 0.01;
  GridAngle startingPoint;
  color c;

  FlowLine(PVector v_, int lineLength_) {
    this.v = v_;
    this.lineLength = lineLength_;
    this.startingPoint = grid.get((int)random(grid.size())).get((int)random(grid.size()));
  }

  float getClosestGridAngle(PVector pos) {
    int nearestX, nearestY;
    nearestX = min(max((int)(pos.x / spacing), 0), grid.size() - 1);
    nearestY = min(max((int)(pos.y / spacing), 0), grid.size() - 1);
    return grid.get(nearestX).get(nearestY).angle;
  }

  void draw(PImage img) {
    beginShape();
    PVector v = this.v;
    ArrayList<PVector> points = new ArrayList<PVector>();
    points.add(v.copy());
    
    for (int i = 0; i < this.lineLength; i++) {
      float angle = getClosestGridAngle(v);
      angle += map(noise(v.x * 0.01, v.y * 0.01), 0, 1, -PI/8, PI/8);
      v.add(this.segmentLength * cos(angle), this.segmentLength * sin(angle));
      
      if (v.x < -width || v.x > width * 2 || v.y < -height || v.y > height * 2) {
        break;
      }
      points.add(v.copy());
    }
    
    // Draw outline
    stroke(0, 50); // Semi-transparent black for outline
    strokeWeight(6); // Outline thickness
    noFill();
    beginShape();
    for (PVector pt : points) {
      curveVertex(pt.x, pt.y);
    }
    endShape();
  
    // Sample color from the image at the current position
    color baseColor = img.get((int)constrain(v.x, 0, img.width - 1), (int)constrain(v.y, 0, img.height - 1));
    
    // Convert to HSB color mode to adjust properties
    colorMode(HSB, 360, 100, 100);
    float h = hue(baseColor);
    float s = saturation(baseColor);
    float b = brightness(baseColor);

    // Introduce slight random variations
    h = (h + random(-10, 10)) % 360; // Adjust hue
    s = constrain(s + random(-5, 5), 0, 100); // Adjust saturation
    b = constrain(b + random(-5, 5), 0, 100); // Adjust brightness
    
    color variedColor = color(h, s, b);
    stroke(variedColor);
    strokeWeight(random(2, 7));
    
    beginShape();
    for (PVector pt : points) {
      curveVertex(pt.x, pt.y);
    }
    endShape();
  }
}
