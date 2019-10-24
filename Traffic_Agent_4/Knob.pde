// Knob(x, y, val, min, max, color)

class Knob{
  float RAD = 20;
  float x;
  float y;
  float val;
  float min;
  float max;
  color c;
  
  // constructor
  Knob(float _x, float _y, float _val, float _min, float _max, color _c){
    x   = _x;
    y   = _y;
    val = _val;
    min = _min;
    max = _max;
    c   = _c;
  }
  
  // display
  void display(){
    float phi = map(val, min, max, 0, 1.5*PI);
    push();
    noStroke();
    fill(c);
    arc(x, y, RAD-10, RAD-10, 0.75*PI, phi + 0.75*PI, PIE);
    pop();
  }
}
