// angular

class Agent{
  int   ind;  // index
  float ang;  // angular position 0<=ang<=360
  float vel;  // angular velocity
  float acc;  // angular acceleration
  float max_vel;
  boolean braking = false;
  
  // constructor
  Agent(int _ind, float _ang, float _vel){
    ind = _ind;
    ang = _ang;
    vel = _vel;
    acc = 0;
    max_vel= MAX_VEL;
  }
  
  void update(){
    doBrakeAndAccel();
  }
  
  void display(){
    push();
      noStroke();
      fill(250);
      translate(RAD*1.2, height-RAD*1.2);
      float x = RAD * cos(radians(ang));
      float y = RAD * sin(radians(ang));
      if(braking) image(b_gst, x, y, 20, 20);
      else        image(gst, x, y, 20, 20);
    pop();
  }
  
  // avoid collision 
  void doBrakeAndAccel(){
    // watch car in front of you
    // init car ahead
    float phi = 100;
    float dd  = 100;
    float d;
    for(Agent car: cars){
      if(car!=this){
        if(car.ang-this.ang>0){
          phi = car.ang - this.ang;
        }
        else if(car.ang-this.ang<-300){
          phi = car.ang - this.ang + 360;
        }
        d = radians(phi) * RAD;
        if(d<dd){
          dd = d;
        }
      }
    }
    // brake
    if(dd<BRAKING_DIST || this.vel>max_vel){
      acc = BRAKE;
      acc = constrain(acc, -this.vel, 0); // in order not to go back
      braking = true;
    }
    // accele
    else if(this.vel<=max_vel && dd>ACCEL_DIST){
      acc = ACCEL;
      braking = false;
    }
    vel += acc;
    vel = constrain(vel, 0, max_vel);    
    ang += vel;
    acc = 0;
  }
}
