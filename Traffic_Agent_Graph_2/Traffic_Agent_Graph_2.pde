// continuous model of traffic jam
// 1-dimension(circle)

PFont font;
PImage gst, b_gst;

// physical parameters

boolean randomize = true;   // cars[0].val randomely change or not
float MAX_VEL = 4;           // max velocity of each agent

float BRAKING_DIST = 20;
float BRAKE = -0.2;

float ACCEL_DIST = 20;
float ACCEL = 0.05;

int CAR_NUM = 8;
Agent[] cars;

// states
int flux = 0;               // car_crossing_NUM/time
IntList fList; 

// other parameters
int RAD      = 80;          // RADIUS of traffic road
int TIME_UNIT = 200;         // time_unit of counting car flux

// Knobs
 Knob k_brake, k_Bdist, k_accel, k_Adist;

void setup(){
  frameRate(48);
  size(400, 400);
  background(20);
 
  gst = loadImage("pacmangst.png");  
  b_gst = loadImage("gstrun.png");
  imageMode(CENTER);
  font = loadFont("SansSerif-48.vlw");
  textAlign(CENTER, CENTER);
  textFont(font, 16);
  
  fList = new IntList();
  
  setKnobs();
  initCars();
}

void initCars(){
  cars = new Agent[CAR_NUM];  
  for(int i=0; i<CAR_NUM; i++){
    cars[i] = new Agent(i, i*360/CAR_NUM, MAX_VEL);
  }
  flux = 0;  
}

void setKnobs(){
  color c_brake = color(0, 0, 255);
  color c_Bdist = color(0, 255, 255);
  color c_accel = color(255, 255, 0);
  color c_Adist = color(255, 0, 0);
  k_brake = new Knob(40, 120, -0.3, -1, -0.1, c_brake, "BRAKE");
  k_Bdist = new Knob(40+80, 120, 20, 5, 50, c_Bdist, "BRAKE_DIST");
  k_accel = new Knob(width/2+40, 120, 0.2, 0.1, 1, c_accel, "ACCEL");
  k_Adist = new Knob(width/2+120, 120, 20, 5, 50, c_Adist, "ACCEL_DIST");
}

void draw(){
  background(20);
  
  useKnob();
  // refresh car in every 10 seconds
  if(frameCount%TIME_UNIT==0){
    fList.append(flux);
    CAR_NUM++;
    initCars();
  }
  
  dispCircle();
  int d_flux = 0;
  for(Agent car: cars){
    car.update();
    car.display();
    d_flux += car.ang/360;
  }
  flux = d_flux;
  dispGraph();
  dispIndicator();
  
  // randomize velocity
  if(randomize){
    if(random(1)<0.01){
      cars[1].vel = 0;
      cars[1].braking = true;
    }
  }
}

void keyPressed(){
  switch(key){
    case ' ':
      noLoop();
      break;
    case ENTER:
      loop();
      break;
  }
}

void useKnob(){
  BRAKE        = k_brake.knobVal();
  BRAKING_DIST = k_Bdist.knobVal();  
  
  ACCEL        = k_accel.knobVal(); 
  ACCEL_DIST   = k_Adist.knobVal();
}

void dispCircle(){
  push();
  // circle
  translate(RAD*1.2, height-RAD*1.2);
  noFill();
  stroke(0, 0, 255);
  strokeWeight(2);
  circle(0, 0, RAD*2+20);
  circle(0, 0, RAD*2-20);
  // point
  stroke(255, 255);
  strokeWeight(5);
  line(0, 0, RAD, 0);
  pop();
}

void dispGraph(){
  push();
    translate(width/2 + 20, height-20);
    stroke(255);
    float x = RAD*2;
    float y = -RAD*2;
    push();
      translate(-10, y*0.5);
      rotate(1.5*PI);
      text("Flux", 0, 0);
    pop();
    line(0, 0, 0, y);
    text("Density", x*0.5, 10);
    line(0, 0, x, 0);
    // plot value
    for(int i=0; i<fList.size(); i++){
      float xx = (i+1) * x/(fList.size()+1);
      float yy = map(fList.get(i), 0, 50, 0, y);
      stroke(255, 100, 0);
      fill(255, 100, 0);
      circle(xx, yy, 6);
    }
  pop();
}

void dispIndicator(){
  
  // brake
  push(); 
  strokeWeight(2);
  translate(40, 40);
  float BRAKE_MAP = map(BRAKE, -1, -0.1, 10, 40);
  stroke(0, 0, 255);
  line(0, 0, BRAKE_MAP, 0);
  float BRAKING_DIST_MAP = map(BRAKING_DIST, 5, 50, 5, width/3);
  stroke(0, 255, 255);
  line(0, 20, BRAKING_DIST_MAP, 20);

  image(b_gst, 0, 0, 40, 40);
  tint(255, 100);
  image(b_gst, BRAKING_DIST_MAP, 0, 40, 40);
  pop();
  
  // accel
  push();
  strokeWeight(2);
  translate(width/2+40, 40);
  float ACCEL_MAP = map(ACCEL, 0.1, 1, 10, 40);
  stroke(255, 255, 0);
  line(0, 0, ACCEL_MAP, 0);
  float ACCEL_DIST_MAP = map(ACCEL_DIST, 5, 50, 5, width/3);
  stroke(255, 0, 0);
  line(0, 20, ACCEL_DIST_MAP, 20);
  
  image(gst, 0, 0, 50, 50);
  tint(255, 100);
  image(gst, ACCEL_DIST_MAP, 0, 50, 50);
  pop();
}
