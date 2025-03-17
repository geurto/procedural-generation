PShape chaikin(PShape shape, float ratio, int iterations, boolean close) {
  if (iterations == 0) { return shape;}
  PShape next = createShape();
  next.beginShape();
  
  if (close) {
    next.endShape(CLOSE);
  } else {
    next.endShape();
  }
  
  return chaikin(next, ratio, iterations - 1, close);
}

PShape chaikin_closed(PShape shape, float ratio, int iterations) {
  return chaikin(shape, ratio, iterations, true);
}

PShape chaikin_open(PShape shape, float ratio, int iterations) {
  return chaikin(shape, ratio, iterations, false);
}

ArrayList<PVector> chaikin_cut(PVector a, PVector b, float ratio) {
  float x, y;
  ArrayList<PVector> n = new ArrayList<PVector>();

  /*
   * If ratio is greater than 0.5 flip it so we avoid cutting across
   * the midpoint of the line.
   */
   if (ratio > 0.5) ratio = 1 - ratio;

  /* Find point at a given ratio going from A to B */
  x = lerp(a.x, b.x, ratio);
  y = lerp(a.y, b.y, ratio);
  n.add(new PVector(x, y));

  /* Find point at a given ratio going from B to A */
  x = lerp(b.x, a.x, ratio);
  y = lerp(b.y, a.y, ratio);
  n.add(new PVector(x, y));

  return n;
}
