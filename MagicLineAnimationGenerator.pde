import processing.pdf.*;

private AnimationFrame animation;
private PGraphics grid;
private boolean beginRecord;
String animationFolder;

public void setup() {
  size(1400, 1000, P3D);
  animationFolder = dataPath("bike-new");
  animation = new AnimationFrame(animationFolder);
  grid = grid(-100, width, height + 200, 0);
  noSmooth();
}


public void draw() {
  if (beginRecord) {
    println("pdf - begin record");
    beginRecord(PDF, animationFolder + "/line.pdf");
  }

  animation.display();
  if (beginRecord) {
    println("pdf - end record");
    beginRecord = false;
    endRecord();
    exit();
  }
}

private PGraphics grid(int offset, int _width, int _height, int alpha)
{
  PGraphics g = createGraphics(_width, _height);
  g.beginDraw();
  g.background(255, alpha);
  g.fill(0);
  for (int i = 0; i < _height; i += 11 * 2) {
    g.rect(0, offset + i, _width, 9 * 2);
  }
  g.endDraw();
  return g;
}


public void keyPressed() {
  switch(key) {
  case 'x':
    beginRecord = true;
    break;
  }
}

