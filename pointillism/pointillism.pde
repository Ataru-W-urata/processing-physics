void setup(){
  size(400, 300);
  background(255);
  
  int period = 8;
  int num = 300;
  int r;                       // basic radius
  float r_delta = 10;
  
  strokeWeight(2);
  // ellipse(width/2, height/2, 200, 200);
  
  for(r=100; r>60; r-=5){
    for(int i=0; i<num; i++){
      float radius = r + r_delta * sin(TWO_PI * period * i/num);
      float x =  width/2 + radius * cos(TWO_PI * i/num);
      float y =  height/2 + radius * sin(TWO_PI * i/num);
      point(x,y);
    }
    num -= 50;
  }
}
