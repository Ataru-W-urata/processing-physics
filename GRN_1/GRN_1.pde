//############################################

// Gene regulatory network
// Feed back loop

//############################################

PFont font;
Gene g1, g2;
float input1, input2;
int test;

void setup(){
  frameRate(24);
  size(300, 200);
  background(100);
  font = loadFont("SansSerif-12.vlw");
  g1 = new Gene(0, 1, 3); // init_exp=0, threshold=3, 3
  g2 = new Gene(0, 1, 3);
  test = 4;
}

void draw(){
  background(100);
  noStroke();
  fill(150);
  rectMode(CORNERS);
  rect(10, 10, width/2, height-10);
  
  // gene setting
  // duration
  if(frameCount%12==0){
   input1 = test - g2.outputVal*4; // negative feedback
   input2 = g1.outputVal*4;        // positive
  }
  
  run_genes();
}

void mouseClicked(){
  test+=1;
}

void run_genes(){
  g1.update(input1);
  g2.update(input2);
  g1.disp_exp(width/2+20, 90);
  g1.disp_ptc(80, 60);
  
  g2.disp_exp(width/2+20, 185);
  g2.disp_ptc(80, 150);
}
