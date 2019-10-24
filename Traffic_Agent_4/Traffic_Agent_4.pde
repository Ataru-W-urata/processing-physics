// continuous model of traffic jam
// 1-dimension(circle)

PFont font;
PImage gst;
int RAD = 100;            // RADIANS of traffic road


// physical parameters
float MAX_VEL = 1;        // max velocity of each agent

float BRAKING_DIST = 30;
float BRAKE = -1;

float ACCEL_DIST = 30;
float ACCEL = 0.01;

int CAR_NUM = 5;
Agent[] cars;


void setup(){
  size(220, 220);
  background(20);
 
  gst = loadImage("pacmangst.png");  
  imageMode(CENTER);
  
  cars = new Agent[CAR_NUM];  
  cars[0] = new Agent(0, 100, 0.5);
  cars[1] = new Agent(1, 0, 0.5);
  cars[2] = new Agent(2, -50, 0.4);
  cars[3] = new Agent(3, 40, 0.3);
  cars[4] = new Agent(4, 250, 0.1);
}

void draw(){
  background(20);
  displayCircle();
  for(Agent car: cars){
    car.update();
    car.display();
  }
}

void displayCircle(){
  push();
  // circle
  translate(width/2, height/2);
  noFill();
  stroke(0, 0, 255);
  strokeWeight(2);
  circle(0, 0, 220);
  circle(0, 0, 180);
  // point
  stroke(255, 255);
  strokeWeight(5);
  point(0, -100);
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
