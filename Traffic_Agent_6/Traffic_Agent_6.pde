// continuous model of traffic jam
// 1-dimension(circle)

PFont font;
PImage gst;
int RAD = 90;            // RADIANS of traffic road


// physical parameters
float MAX_VEL = 1;        // max velocity of each agent

float BRAKING_DIST = 30;
float BRAKE = -1;

float ACCEL_DIST = 30;
float ACCEL = 0.01;

int CAR_NUM = 10;
Agent[] cars;

// Knobs
Knob brake_knob, b_dist_knob;

void setup(){
  size(200, 300);
  background(20);
 
  gst = loadImage("pacmangst.png");  
  font = loadFont("SansSerif-48.vlw");
  textFont(font, 12);
  textAlign(CENTER, CENTER);
  imageMode(CENTER);
  
  cars = new Agent[CAR_NUM];  
  for(int i=0; i<CAR_NUM; i++){
    cars[i] = new Agent(i, i*360.0/CAR_NUM, 0);
  }
  
  // Knobs
  color c_brake = color(0, 100, 255);
  brake_knob = new Knob(30, 40, -5, -10, -1, c_brake, "BRAKE");
  color c_bDist = color(0, 255, 100);
  b_dist_knob = new Knob(90, 40, 20, 10, 60, c_bDist, "B_DIST");
}

void draw(){
  background(20);
  
  BRAKE = brake_knob.knobVal();
  BRAKING_DIST = b_dist_knob.knobVal();
  
  displayCircle();
  for(Agent car: cars){
    car.update();
    car.display();
  }
}

void displayCircle(){
  push();
  // circle
  translate(width/2, height - width/2);
  noFill();
  stroke(0, 0, 255);
  strokeWeight(2);
  circle(0, 0, RAD*2+20);
  circle(0, 0, RAD*2-20);
  // point
  stroke(255, 255);
  strokeWeight(5);
  pop();
}

void keyPressed(){
  switch(key){
    case '2':
      cars[0].max_vel = 2;
      break;
    case '3':
      cars[0].max_vel = 3;
      break;
    case '1':
      cars[0].max_vel = 0.5;
      break;
  }
}
