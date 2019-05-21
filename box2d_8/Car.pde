class Car {
  Box box;
  Particle wheel1;
  Particle wheel2;
  
  // constructor
  Car(float x, float y){
    // initialize position of the box
    box = new Box(x, y, 30, 10, false);
    // initialize position of two wheels
    wheel1 = new Particle(x-10, y+3, random(3, 8));
    wheel2 = new Particle(x+10, y+3, random(3, 8));
    
    // Define joints
    RevoluteJointDef rjd1 = new RevoluteJointDef();
    rjd1.initialize(box.body, wheel1.body, wheel1.body.getWorldCenter());
    // parameters that affect Phyisics
    rjd1.motorSpeed = -PI*2;
    rjd1.maxMotorTorque = 300.0;
    rjd1.enableMotor = true;
    box2d.world.createJoint(rjd1);
    
    RevoluteJointDef rjd2 = new RevoluteJointDef();
    rjd2.initialize(box.body, wheel2.body, wheel2.body.getWorldCenter());
    rjd2.motorSpeed = -PI*2;
    rjd2.maxMotorTorque = 300.0;
    rjd2.enableMotor = true;
    box2d.world.createJoint(rjd2);
  }
  
  void display(Vec2 pos){
    box.display(pos);
    wheel1.display(pos);
    wheel2.display(pos);
  }
}
