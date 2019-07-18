class Cell{
  PVector pos;
  int my_i;
  int my_j;
  boolean IsExist;           // cell is Exist or not
  boolean IsPerco;           // percolated or not
  
  // constructor
  Cell(float _x, float _y, int _i, int _j){
    my_i = _i;
    my_j = _j;
    pos = new PVector(_x, _y);
    IsExist = true;
    IsPerco = false;
  }
  
  // function to init cell
  void init(){
    if(random(1)<prob) IsExist = false;
    if(!IsExist && my_i==0){
      IsPerco = true;
    }
  }
  
  // function to display
  void display(){
    push();
      rectMode(CENTER);  
      noStroke();
      translate(pos.x, pos.y);
      // color   
      if(IsExist)        fill(0, 0, 20, 100);      // black
      else if(IsPerco)   fill(200, 50, 100, 100); // blue
      else               fill(0, 0, 100, 100);    // white
      rect(0, 0, cell_w, cell_h, cell_w/5);
    pop();
  }
}
