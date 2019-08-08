//##############################
// draw parabola
//##############################

int num = 2;
PVector[] foci = new PVector[num];
float yd;       // y of directrix

void setup(){
  randomSeed(45);
  size(200, 200);
  background(10);
  strokeWeight(2);
  stroke(200);
  noFill();
  
  // init of focus point
  for(int i=0; i<num; i++){
    foci[i] = new PVector(width*random(0.25, 0.75), height*random(0.25, 0.75));
  }
}

void draw(){
  background(10); 
  yd = mouseY;
  
  // draw focus point and directri
  for(PVector f: foci) circle(f.x ,f.y, 5);
  line(0, yd, width, yd);
  
  // draw parabola
  stroke(255);
  beginShape();
  for(int i=0; i<width; i++){
    float max = -1;
    for(PVector f: foci){
      PVector mid = return_parabola(i, f.x, f.y, yd);
      // if(yd>f.y) point(mid.x, mid.y);
      if(yd>f.y){
        if(mid.y>max) max=mid.y;
      }
    }
    vertex (i, max);
  }
  endShape();
}

PVector return_parabola(float _x, float _xf, float _yf, float _yd){
  PVector mid_point;
  float x = _x;
  float y = pow(x-_xf, 2)/(2*(_yf-_yd)) + (_yf+_yd)/2;
  mid_point = new PVector(x, y);
  return mid_point;
}


//void draw_parabola(float _xf, float _yf, float _yd){
//  float x, y;
//  for(int i=0; i<width; i++){
//    x = i;
//    y = pow(x-_xf, 2)/(2*(_yf-_yd)) + (_yf+_yd)/2;
//    push();
//    stroke(0, 255, 255);
//    if(_yf-_yd<0) point(x, y);
//    pop();
//  }
// }
