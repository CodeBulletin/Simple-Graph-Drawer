float[] drawGrid(float x, float y, float centerXV, float centerYV, float xi, float yi, float tSize, float aSize, float space, int subgrid, float MG, float MiG, float miG, int decimal, 
  String xp, String xn, String yp, String yn, String xScale, String yScale, PVector stringPos, float sSize, color MainGrid, color MiniGrid, color MicroGrid, color Scale, color cords, color Lable, 
  boolean drawgrid, boolean drawSubgrid, boolean drawMicroGrid, boolean drawCords, boolean drawLabel, boolean drawScale, PVector mousePoint, float mousePointW, color MousePointC) {
  push();
  stroke(255);
  strokeWeight(4);
  textSize(tSize);
  textAlign(CENTER, CENTER);
  float stPX = space;
  boolean PX = true;
  float ipx = 0;
  float stNX = -space;
  boolean NX = true;
  float inx = 0;
  float stPY = space;
  boolean PY = true;
  float ipy = 0;
  float stNY = -space;
  boolean NY = true;
  float iny = 0;
  while (PX || NX || PY || NY) {
    if (x + stPX <= width) {
      ipx += 1;
      if (drawSubgrid && drawgrid) {
        strokeWeight(MiG);
        stroke(MiniGrid);
        line(x + stPX, 0, x + stPX, height);
        strokeWeight(miG);
        stroke(MicroGrid);
        if (drawMicroGrid) {
          for (float i = 0; i < subgrid; i++) {
            line(x + stPX - i*space/subgrid, 0, x + stPX - i*space/subgrid, height);
          }
        }
      }
      if (drawCords) {
        stroke(cords);
        fill(cords);
        String s = nf(centerXV + ipx*xi, 0, decimal);
        float strlen = s.length();
        text(s, x + stPX - (strlen==0?strlen:(strlen+1))*tSize/4.0, y + tSize/2);
      }
      stPX += space;
    } else {
      if (PX && drawSubgrid && drawMicroGrid && drawgrid) {
        strokeWeight(miG);
        stroke(MicroGrid);
        for (float i = 0; i < subgrid; i++) {
          line(x + stPX - i*space/subgrid, 0, x + stPX - i*space/subgrid, height);
        }
      }
      PX = false;
    }
    if (x + stNX >= 0) {
      inx += 1;
      if (drawSubgrid && drawgrid) {
        strokeWeight(MiG);
        stroke(MiniGrid);
        line(x + stNX, 0, x + stNX, height);
        strokeWeight(miG);
        stroke(MicroGrid);
        if (drawMicroGrid) {
          for (float i = 0; i < subgrid; i++) {
            line(x + stNX + i*space/subgrid, 0, x + stNX + i*space/subgrid, height);
          }
        }
      }
      if (drawCords) {
        stroke(cords);
        fill(cords);
        String s = nf(centerXV - inx*xi, 0, decimal);
        float strlen = s.length();
        text(s, x + stNX-(strlen==0?strlen:(strlen+1))*tSize/4.0, y + tSize/2.0);
      }
      stNX -= space;
    } else {
      if (NX && drawSubgrid && drawMicroGrid && drawgrid) {
        strokeWeight(miG);
        stroke(MicroGrid);
        for (float i = 0; i < subgrid; i++) {
          line(x + stNX + i*space/subgrid, 0, x + stNX + i*space/subgrid, height);
        }
      }
      NX = false;
    }
    if (y + stPY <= height) {
      ipy += 1; 
      if (drawSubgrid && drawgrid) {
        strokeWeight(MiG);
        stroke(MiniGrid);
        line(0, y + stPY, width, y + stPY);
        strokeWeight(miG);
        stroke(MicroGrid);
        if (drawMicroGrid) {
          for (float i = 0; i < subgrid; i++) {
            line(0, y + stPY - i*space/subgrid, width, y + stPY - i*space/subgrid);
          }
        }
      }
      if (drawCords) {
        stroke(cords);
        fill(cords);
        String s = nf(centerYV - ipy*yi, 0, decimal);
        float strlen = s.length();
        text(s, x - (strlen==0?strlen:(strlen+1))*tSize/4.0, y + stPY + tSize/2);
      }
      stPY += space;
    } else {
      if (PY && drawSubgrid && drawMicroGrid && drawgrid) {
        strokeWeight(miG);
        stroke(MicroGrid);
        for (float i = 0; i < subgrid; i++) {
          line(0, y + stPY - i*space/subgrid, width, y + stPY - i*space/subgrid);
        }
      }
      PY = false;
    }
    if (y + stNY >= 0) {
      iny += 1;
      if (drawSubgrid && drawgrid) {
        strokeWeight(MiG);
        stroke(MiniGrid);
        line(0, y + stNY, width, y + stNY);
        strokeWeight(miG);
        stroke(MicroGrid);
        if (drawMicroGrid) {
          for (float i = 0; i < subgrid; i++) {
            line(0, y + stNY + i*space/subgrid, width, y + stNY + i*space/subgrid);
          }
        }
      }
      if (drawCords) {
        stroke(cords);
        fill(cords);
        String s = nf(centerYV + iny*yi, 0, decimal);
        float strlen = s.length();
        text(s, x - (strlen==0?strlen:(strlen+1))*tSize/4.0, y + stNY + tSize/2);
      }
      stNY -= space;
    } else {
      if (NY && drawSubgrid && drawMicroGrid && drawgrid) {
        strokeWeight(miG);
        stroke(MicroGrid);
        for (float i = 0; i < subgrid; i++) {
          line(0, y + stNY + i*space/subgrid, width, y + stNY + i*space/subgrid);
        }
      }
      NY = false;
    }
  }
  strokeWeight(MG);
  stroke(MainGrid);
  if (drawgrid) {
    line(x, 0, x, height);
    line(x - aSize, height - aSize, x, height);
    line(x + aSize, height - aSize, x, height);
    line(x - aSize, aSize, x, 0);
    line(x + aSize, aSize, x, 0);
    line(0, y, width, y);
    line(width - aSize, y - aSize, width, y);
    line(width - aSize, y + aSize, width, y);
    line(aSize, y - aSize, 0, y);
    line(aSize, y + aSize, 0, y);
  }
  if (drawCords) {
    stroke(cords);
    fill(cords);
    String s = ("(" + nf(centerXV, 0, decimal) + ", " + nf(centerYV, 0, decimal) + ")");
    float strlen = s.length();
    text(s, x - tSize*(strlen==0?strlen:(strlen+1))/4.0, y + tSize/2);
  }
  if (mousePoint != null) {
    strokeWeight(mousePointW);
    stroke(MousePointC);
    line(mousePoint.x, mousePoint.y, mousePoint.x, y);
    line(mousePoint.x, mousePoint.y, x, mousePoint.y);
    float value_x = map(mousePoint.x, stNX + x, stPX + x, (-inx-1)*xi + centerXV, (ipx+1)*xi + centerXV);
    String s = nf(value_x, 0, decimal);
    if (mousePoint.y > y) {
      text(s, mousePoint.x, y-3*tSize/4);
    } else {
      text(s, mousePoint.x, y+tSize/2);
    }
    float value_y = map(mousePoint.y, stPY + y, stNY + y, (-iny-1)*yi + centerYV, (ipy+1)*yi + centerYV);
    s = nf(value_y, 0, decimal);
    float strlen = s.length();
    if (mousePoint.x > x) {
      text(s, x - tSize*(strlen==0?strlen:(strlen+1))/4.0 - MG, mousePoint.y);
    } else {
      push();
      textAlign(LEFT, CENTER);
      text(s, x + MG, mousePoint.y);
      pop();
    }
    if (drawScale) {
      push();
      textSize(sSize);
      text("Scale:", stringPos.x, stringPos.y - sSize);
      stroke(Scale);
      fill(Scale);
      text(xp + "-axis: " + "1 unit = " + str(xi) + xScale, stringPos.x, stringPos.y);
      text(yp + "-axis: " + "1 unit = " + str(yi) + yScale, stringPos.x, stringPos.y + sSize);
      pop();
    }
  }
  pop();
  push();
  textSize(tSize);
  textAlign(CENTER, CENTER);
  stroke(255);
  strokeWeight(4);
  if (drawLabel) {
    stroke(Lable);
    fill(Lable);
    text(xn, tSize*(xn.length()%2==0?xn.length()+2:(xn.length()+3))/4.0 + aSize, y - tSize);
    text(xp, width - tSize*(xp.length()%2==0?xp.length()+2:(xp.length()+3))/4.0 - aSize, y - tSize);
    text(yn, x + tSize*(yn.length()%2==0?yn.length()+2:(yn.length()+3))/4.0, height - tSize - aSize);
    text(yp, x + tSize*(yp.length()%2==0?yp.length()+2:(yp.length()+3))/4.0, tSize/2 + aSize);
  }
  pop();
  return new float[]{inx, ipx, iny, ipy, stNX, stPX, stNY, stPY, centerXV, centerYV, xi, yi, x, y, space};
}
