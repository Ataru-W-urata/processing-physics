class Circle{
  
  float x;
  float y;
  float r;
  
  boolean growing = true;
  
  // constructor
  Circle(float _x, float _y){
    x = _x;
    y = _y;
    r = 1;
  }
  
  // if growing == true, circle keeps growing its diameter until
  // it reaches 50
  void grow(){ 
    if(growing){
      r = r + 0.5;
    }
    if(r>50){
      growing = false;
    }
  }
  
  boolean edges(){
    return(x+r>width || x-r<0 || y+r>height || y-r<0);
  }
  
  void show(){
    stroke(200);
    strokeWeight(0.5);
    noFill();
    ellipse(x, y, r*2, r*2);
  }
}
