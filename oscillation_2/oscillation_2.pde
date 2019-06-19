// mass is moveing along x-axis
// properties
float m = 1;                   // all mass is equal to each other
float k = 0.01;                 // spring constant
float K = 0.06;
float x1, x1_ini, x2, x2_ini;  // position
float y;
float v1, v2;                  // velocity
float a1, a2;                  // acceleration
float f1, f2;                  // forces
float dmp = 1;

float rad = 20;                // radius of mass
boolean hov1 = false;           // is mouse on mass1?
boolean drag1 = false;          // is mouse moving mass1?
boolean hov2 = false;         
boolean drag2 = false;

FloatList wave1;
FloatList wave2;

void setup(){
  size(200, 200);
  // initial position of mass
  x1_ini = width * 1/3;
  x2_ini = width * 2/3;
  x1 = x1_ini;
  x2 = x2_ini;
  y = height * 5/6;
  
  wave1 = new FloatList();
  wave2 = new FloatList();
}

void draw(){
  background(250);
  update();
  display();
  
  display_wave();
}

// function to display
void display(){
  push();
  translate(0, y);
  noStroke();
  
  // mass
  if(hov1) fill(150);
  else fill(100);
  ellipse(x1, 0, rad, rad);
  
  if(hov2) fill(150);
  else fill(100);
  ellipse(x2, 0, rad, rad);
  
  // spring
  stroke(20, 0, 250);
  line(x1+rad/2, 0, x2-rad/2, 0);
  stroke(0, 20, 250);
  line(0, 0, x1-rad/2, 0);
  line(x2+rad/2, 0, width, 0);
  pop();
}

void update(){
  update_pos();
  if(!drag1 && !drag2){
    calculate();
  }
}

void calculate(){
  f1 = -(k+K)*(x1-x1_ini) + k*(x2-x2_ini);   // -k*(x1-x1_ini) + k*((x2-x2_ini)-(x1-x1_ini))
  f2 = -(k+K)*(x2-x2_ini) + k*(x1-x1_ini);
  a1 = f1/m;
  a2 = f2/m;
  v1 = (v1+a1)*dmp;
  v2 = (v2+a2)*dmp;
  x1 += v1;
  x2 += v2;
}


void update_pos(){
  
  // hov check
  if(mouseX>x1-rad/2&&mouseX<x1+rad/2&&mouseY>y-rad/2&&mouseY<y+rad/2){
    hov1 = true;
  }
  else if(mouseX>x2-rad/2&&mouseX<x2+rad/2&&mouseY>y-rad/2&&mouseY<y+rad/2){
    hov2 = true;
  }
  else{
    hov1 = false;
    hov2 = false;
  }
  
  // drag check
  if(hov1 && mousePressed){
    drag1 = true;
  }
  else if(hov2 && mousePressed){
    drag2 = true;
  }
  else {
    drag1 = false;
    drag2 = false;
  }
  
  // update position
  if(drag1){
    x1 = mouseX;
  }
  if(drag2){
    x2 = mouseX;
  }
}

void display_wave(){
  // record position into list
  wave1.insert(0, x1);
  wave2.insert(0, x2);
  
  push();
  translate(0, height*1/6);
  noFill();
  stroke(50);
  beginShape();
    for(int i=0; i<wave1.size();i++){
      vertex(wave1.get(i), i);
    }
  endShape();
  
  noFill();
  stroke(50);
  beginShape();
    for(int i=0; i<wave2.size();i++){
      vertex(wave2.get(i), i);
    }
  endShape();
  pop();
  
  
  if(wave1.size()>200){
    for(int n=200; n<wave1.size();n++){
      wave1.remove(n);
    }
  }
  if(wave2.size()>200){
    for(int n=200; n<wave2.size();n++){
      wave2.remove(n);
    }
  }
}

void keyPressed(){
  x1=x1_ini;
  x2=x2_ini;
  v1=0;
  v2=0;
  a1=0;
  a2=0;
}
