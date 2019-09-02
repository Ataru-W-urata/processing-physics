float unit = 5.0;   // 1 unit = 5pix
int num = 10;

ArrayList<cmplx> cmplxs = new ArrayList<cmplx>();
cmplx[] comp_list = new cmplx[num];

void setup(){
  size(200, 200);
  background(255);
  comp_list[0] = new cmplx(1, 1);
  comp_list[1] = new cmplx(1, 1);
  cmplxs.add(comp_list[0]);
  cmplxs.add(comp_list[1]);
}

void draw(){
  background(255);
  for(int i=2; i<num; i++){
    comp_list[i] = comp_list[i-1].mul_c(comp_list[0]);
    cmplxs.add(comp_list[i]);
  }
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
