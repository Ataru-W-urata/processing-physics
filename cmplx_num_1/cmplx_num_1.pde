float unit = 10.0;   // 1 unit = 5pix

ArrayList<cmplx> cmplxs = new ArrayList<cmplx>();
cmplx c1, c2;

void setup(){
  size(200, 200);
  background(255);
  c1 = new cmplx(1, 1);
  c2 = new cmplx(1, 1);
  cmplxs.add(c1);
  cmplxs.add(c2);
}

void draw(){
  background(255);
  cmplx c3 = c2.mul_c(c1);
  cmplx c4 = c3.mul_c(c1);
  cmplx c5 = c4.mul_c(c1);
  cmplxs.add(c3);
  cmplxs.add(c4);
  cmplxs.add(c5);
  c3.output();
  display();
  noLoop();
}

void display(){
  stroke(0, 100, 100);
  strokeWeight(0.5);
  for(int i=0; i<width/unit; i++){
    if(i*unit == width/2)  strokeWeight(0.8);
    else                   strokeWeight(0.5);
    line(i*unit, 0, i*unit, height);
  }
  for(int i=0; i<height/unit; i++){
    if(i*unit == height/2) strokeWeight(0.8);
    else                   strokeWeight(0.5);
    line(0, i*unit, width, i*unit);
  }
  translate(width/2, height/2);
  for(cmplx c: cmplxs){
    stroke(0);
    strokeWeight(1.5);
    c.display();
  }
}
