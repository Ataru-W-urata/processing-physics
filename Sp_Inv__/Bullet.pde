class Bullet{
  int xVal;  // x_position
  int yVal;  // y_position
  int veloc; // velocity
  boolean toDelete;
  
  // consturctor
  Bullet(int _xVal, int _yVal, int _veloc){
    xVal = _xVal;
    yVal = _yVal;
    veloc = _veloc;    // move along y-axis
    toDelete = false;
  }
  
  void display(){
    // update
    yVal += veloc;
    float x = dot_diameter*(xVal+0.5);
    float y1 = dot_diameter*(yVal+0.5);
    noStroke();
    fill(255);
    circle(x, y1, dot_diameter/3);
    outOfDisp();
  }
  void outOfDisp(){
    if(yVal<0) toDelete = true;
  }
}
