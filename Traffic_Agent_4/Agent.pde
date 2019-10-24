// angular

class Agent{
  int   ind;  // index
  float ang;  // angular position 0<=ang<=360
  float vel;  // angular velocity
  float acc;  // angular acceleration
  float max_vel;
  
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
      translate(width/2, height/2);
      float x = RAD * cos(radians(ang));
      float y = RAD * sin(radians(ang));
      ellipse(x, y, 10, 10);
    pop();
  }
  
  // avoid collision 
  void doBrakeAndAccel(){
    // watch car in front of you
    // init car ahead
    Agent car_ahead;
    if(ind == CAR_NUM-1){
      car_ahead = cars[0];
    }
    else{
      car_ahead = cars[ind+1];
    }
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
          car_ahead = car;
        }
      }
    }
    // brake
    if(dd<BRAKING_DIST){
      acc = BRAKE;
      acc = constrain(acc, -this.vel, 0); // in order not to go back
    }
    // accele
    else if(this.vel<=max_vel && dd>ACCEL_DIST){
      acc = ACCEL;
    }
    vel += acc;
    vel = constrain(vel, 0, max_vel);    
    ang += vel;
    acc = 0;
  }
}
