static float x, y;
static PVector ScalePos;
static color MainGridColor, MiniGridColor, MicroGridColor, Scale_color, cords_color, lables_color, background_color, MousePointC;
static float centerX = 0, centerY = 0;
static float x_unit = 1, y_unit = 1;
static int decimal = 1;
static final float textsize = 20, arrowSize = 10;
static final float space = 400;
static final int subgrid = 3;
static final String Xaxis = "x", Yaxis = "y", XaxisUnit = "m", YaxisUnit = "m"; 
static final float scaletextSize = 40;
static final boolean draw_grid = true, drawSubGrid = true, drawMiniGrid = true, draw_Scale = false, draw_cords = true, draw_lables = true;
static boolean mouse = false;
static final float MainGridSize = 4, MiniGridSize = 2, MicroGridSize = 2, mousePointW = 1;

float[] eqn(float t) {
  return new float[]{t, abs(t*t - 1)};
}
//float[] eqn1(float t) {
//  if (t < 1) {
//    return new float[]{t, 6*t - 4};
//  } else {
//    return null;
//  }
//}

void setup() {
  fullScreen(P2D);
  frameRate(144);
  smooth(8);
  x = width/2;
  y = height - 100;
  ScalePos = new PVector(width/4, height/4);
  MainGridColor = color(255);
  MiniGridColor = color(255, 100);
  MicroGridColor = color(125, 100);
  Scale_color = color(255);
  cords_color = color(255);
  lables_color = color(255, 200);
  background_color = color(0);
  MousePointC = color(255);
}

void draw() {
  background(background_color);
  ArrayList<ArrayList<float[]>> equations = new ArrayList<ArrayList<float[]>>();
  equations.add(new ArrayList<float[]>());
  //equations.add(new ArrayList<float[]>());
  for (float t = -3; t <= 3; t+=1/100.0) {
    equations.get(0).add(eqn(t));
    //float[] f1 = eqn1(t);
    //if (f1!=null) {
    //  equations.get(0).add(f1);
    //}
  }
  PVector temp = mouse?new PVector(mouseX, mouseY):null;
  drawGraph(equations, null, null, temp);
}

void drawGraph(ArrayList<ArrayList<float[]>> equations, ArrayList<float[]> points, ArrayList<float[]> pointsline, PVector mousePoint) {
  float[] output = drawGrid(x, y, centerX, centerY, x_unit, y_unit, textsize, arrowSize, space, subgrid, MainGridSize, MiniGridSize, MicroGridSize, decimal, Xaxis, Xaxis+"'", Yaxis, Yaxis+"'", XaxisUnit, 
    YaxisUnit, ScalePos, scaletextSize, MainGridColor, MiniGridColor, MicroGridColor, Scale_color, cords_color, lables_color, 
    draw_grid, drawSubGrid, drawMiniGrid, draw_cords, draw_lables, draw_Scale, mousePoint, mousePointW, MousePointC);
  float x = output[12];
  float y = output[13];
  float centerX = output[8];
  float centerY = output[9];
  float incX = output[10];
  float incY = output[11];
  float minX = output[0];
  float maxX = output[1];
  float minY = output[2];
  float maxY = output[3];
  float minRangeX = output[4];
  float maxRangeX = output[5];
  float minRangeY = output[6];
  float maxRangeY = output[7];
  float space = output[14];
  float minx = (-minX-1)*incX + centerX;
  float maxx = ( maxX+1)*incX + centerX;
  float minXR = minRangeX + x;
  float maxXR = maxRangeX + x;
  float miny = (-minY-1)*incY + centerY;
  float maxy = ( maxY+1)*incY + centerY;
  float minYR = minRangeY + y;
  float maxYR = maxRangeY + y;
  if (equations != null) {
    for (ArrayList<float[]> eq : equations) {
      stroke(255);
      strokeWeight(2);
      noFill();
      beginShape();
      for (float[] xy : eq) {
        float a = map(xy[0], minx, maxx, minXR, maxXR);
        float b = map(-xy[1], miny, maxy, minYR, maxYR);
        vertex(a, b);
      }
      endShape();
    }
  }
  if (points != null) {
    stroke(255);
    strokeWeight(2);
    noFill();
    for (float[] xy : points) {
      float a = map(xy[0], minx, maxx, minXR, maxXR);
      float b = map(-xy[1], miny, maxy, minYR, maxYR);
      point(a, b);
    }
  }
  if (pointsline != null){
    stroke(255);
    strokeWeight(2);
    noFill();
    for (float[] xy : pointsline) {
      float a = map(xy[0], minx, maxx, minXR, maxXR);
      float b = map(-xy[1], miny, maxy, minYR, maxYR);
      line(a, b, a, y);
      line(a, b, x, b);
      point(a, b);
    }
  }
}

void mouseDragged() {
  if (mouseButton == LEFT) {
    float dirX = pmouseX - mouseX;
    float dirY = mouseY - pmouseY;
    dirX *= x_unit/400.0;
    dirY *= y_unit/400.0;
    centerX += dirX;
    centerY += dirY;
  }
  if (mouseButton == CENTER) {
    float dirX = pmouseX - mouseX;
    if (dirX >= 0) {
      x_unit += 1/pow(10.0, decimal);
    } else {
      x_unit -= 1/pow(10.0, decimal);
    }
  }
  if (mouseButton == RIGHT) {
    float dirY = pmouseY - mouseY;
    if (dirY >= 0) {
      y_unit += 1/pow(10.0, decimal);
    } else {
      y_unit -= 1/pow(10.0, decimal);
    }
  }
}
void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  float incr = float(nf(e/pow(10.0, decimal), 0, decimal));
  x_unit = float(nf(x_unit + incr, 0, decimal));
  y_unit = float(nf(y_unit + incr, 0, decimal));
}
void keyPressed(){
  if(key == ' '){
    mouse = !mouse;
  }
}
