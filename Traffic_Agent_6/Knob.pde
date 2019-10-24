class Knob{
  float RAD = 40;
  float x;
  float y;
  float val;
  float min;
  float max;
  color c;
  String name;
  
  // constructor
  Knob(float _x, float _y, float _val, float _min, float _max, color _c, String _title){
    x   = _x;
    y   = _y;
    val = _val;
    min = _min;
    max = _max;
    c   = _c;
    name = _title; 
  }
  
  // Assignment
  float knobVal(){
    update();
    display();
    return val;
  } 
  
  // display
  void display(){
    float phi = map(val, min, max, 0, 1.5*PI);
    push();
    stroke(255);
    fill(0);
    circle(x, y, RAD);
    fill(c);
    noStroke();
    arc(x, y, RAD*0.9, RAD*0.9, 0.75*PI, phi + 0.75*PI, PIE);
    fill(0);
    circle(x, y, RAD*0.5);
    stroke(255);
    circle(x, y, RAD*0.4);
    fill(255);
    text(val, x, y+RAD*0.5);
    text(name, x, y-RAD*0.6);
    pop();
  }  
  // change val
  void update(){
    if(mousePressed){
      if(dist(mouseX, mouseY, x, y)<RAD){
        float delta = map(mouseY, y+RAD, y-RAD, min-val, max-val);
        val = val + delta;
      }
    }
  }  
 
}
