// the frequency of each number appeared in pi
int[] count = {0,0,0,0,0,0,0,0,0,0};

PFont font;
float angle   = -360.0/20; // for making spiral
float graph_r = 180;        // for display graph 


void setup(){
  size(300, 300);
  colorMode(HSB, 360, 100, 100, 100);
  background(0, 0, 100);
  
  font = loadFont("AppleBraille-15.vlw");
  textFont(font, 20);
  
  count_num();
}

void draw(){
  display_PI();
  display_graph();
  noLoop();
}

void count_num(){
  int[] list = int(pi.split(""));
  for(int i=0; i<pi.length(); i++){
    count[list[i]]++;
  }
}

void display_graph(){
  push();
  translate(width/2, height/2);
  rotate(-PI/2);
  float prev_angle = 0;
  for(int i=0; i<10; i++){
    float freq_angle = map(count[i], 0, pi.length(), 0, 360);
    noFill();
    strokeWeight(1);
    for(int j=0; j<count[i]*2; j++){
      stroke(i*36, 100, 100, 100-j*2);
      arc(0, 0, graph_r+j, graph_r+j, radians(prev_angle+2),radians(prev_angle+freq_angle-2));
    }
    prev_angle += freq_angle;
    push();
      rotate(-PI/2+radians(prev_angle-5));
      fill(0, 0, 0);
      text(i, 0, 120);
    pop();
    
  }
  pop();
}


void display_PI(){
  push();
  translate(width/2, height/2);
  for(int i=0; i<pi.length(); i++){
    float r = 100 - 7*sqrt(i+10);
    fill(0, 0, 0, 100-i);
    textAlign(CENTER);
    textSize(20-0.05*i);
    text(pi.charAt(i), 0, r);
    rotate(radians(angle));   
  }
  pop();
}
