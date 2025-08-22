import java.util.List;

import toxi.geom.*;
import toxi.geom.mesh2d.Voronoi;

List<Vec2D> points;

void setup() {
  size(1600, 900);
  noFill();
  
  points = new ArrayList<Vec2D>();
  int n_points = 20;
  
  for (int i = 0; i < n_points; i++) {
    points.add(new Vec2D(random(0.1 * width, 0.9 * width), random(0.1 * height, 0.9 * height)));
  }
}

void draw() {
  background(0);
  noFill();
  stroke(224, 205, 103);
  rect(0.05 * width, 0.05 * height, 0.9 * width, 0.9 * height, 12, 72, 12, 72);
  //line(0.05 * width, 0.05 * height, 0.95 * width, 0.05 * height);
  //line(0.95 * width, 0.05 * height, 0.95 * width, 0.95 * height);
  //line(0.95 * width, 0.95 * height, 0.05 * width, 0.95 * height);
  //line(0.05 * width, 0.95 * height, 0.05 * width, 0.05 * height);
  stroke(0);
  fill(255);
  rect(0.1 * width, 0.1 * height, 0.8 * width, 0.8 * height, 12, 72, 12, 72);
  
  
  noFill();
  
  if (random(1) > 0.5) {
    points.add(new Vec2D(random(0.1 * width, 0.9 * width), random(0.1 * height, 0.9 * height)));
  }
  
  Voronoi voronoi = new Voronoi();
  voronoi.addPoints(points);
  
  Rect bound_rect = new Rect(0.1 * width, 0.1 * height, 0.8 * width, 0.8 * height);
  SutherlandHodgemanClipper clipper = new SutherlandHodgemanClipper(bound_rect);
  
  List<Polygon2D> regions = voronoi.getRegions();
  
  for (int i = 0; i < regions.size(); i++) {
    regions.set(i, clipper.clipPolygon(regions.get(i)));
    Vec2D centroid = regions.get(i).getCentroid();
    points.set(i, centroid);
  }
  
  drawPoints(points);
  
  drawPolygons(regions);
}

void drawPoints(List<Vec2D> pts) {
  for (Vec2D p : pts) {
    ellipse(p.x, p.y, 2, 2);
  }
}

void drawPolygons(List<Polygon2D> ps) {
  beginShape();
  for (Polygon2D p: ps) {
    drawPolygon(p);
  }
}

void drawPolygon(Polygon2D p) {
  beginShape();
  for (Vec2D v : p.vertices) {
    vertex(v.x, v.y);
  }
  endShape(CLOSE);
}
