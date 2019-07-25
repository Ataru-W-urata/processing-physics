// checkbox
// possess information about values, positions ans else

class CheckBox{
  Btn[] boxes = new Btn[7];
  int[] vals = {2,3,4,5,6,7,8};
  int val;
  // constructor
  CheckBox(float _x, float _y){
    val = 7; // initial val
    for(int i=0; i<7; i++){
      boxes[i] = new Btn(vals[i], _x+25*i, _y);
    }
  }
  // function
  void run(){
    display();
    activate_Btn();
  }
  
  int return_BtnVal(){
    for(Btn b: boxes){
      if(b.IsSelected) val = b.val;
    }
    return val;
  }
  
  void activate_Btn(){
    for(Btn b: boxes){
      if(b.mouseOn&&mousePressed){
        b.IsSelected = true;
        for(Btn bb: boxes){
          if(bb!=b) bb.IsSelected = false;
        }
      }
    }
  }
  
  void display(){
    for(Btn b: boxes) b.display();
  }
}


class Btn{
  int val;                   // value 
  float x, y;                // pos
  float w = 20;              // width and height
  float h = 10;
  boolean mouseOn;           // is mouse on the btn
  boolean IsSelected;        // is selected or not
  // constructor
  Btn(int _val, float _x, float _y){
    val = _val;
    x = _x;
    y = _y;
    mouseOn = false;
    IsSelected = false;
  }
  
  // function 
  void display(){
    push();
    translate(x, y);
    strokeWeight(3);
    stroke(200, 50, 100, 50);
    if(IsSelected) fill(230, 100, 100, 50); // if selected
    else           fill(0, 0, 100, 50);     // if not selected
    rect(0, 0, w, h);
    pop();
    
    // check mouse pos
    push();
    if(mouseX>x&&mouseX<x+w&&mouseY>y&&mouseY<y+h)  mouseOn = true; 
    else                                            mouseOn = false;
    pop();
  }
}
