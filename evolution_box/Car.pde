class Car {
  
  DNA dna;
  float fitness;
  Box box;
  Box wheel1;
  Box wheel2;
  Box wheel3;
  
  // the object stores information about generation, its parents and fitness value
  // Based on above information, we can trace the phylogenetic tree of objects.
  int generation;
  int dad_num;
  int mom_num;
  
  
  // constructor
  Car(DNA _dna, float x, float y, int _dad, int _mom){
    // initialize shape of the box
    dna = _dna;
    fitness = 0;
    dad_num = _dad;
    mom_num = _mom;
    
    // shape of the box, Anchor point, rotation speed and torque
    // are defined by the genomic sequence
    
    // body
    float bodySizeW = map(dna.genes[0], 0, 1, 60, 80); // body width,  genes[0], 60<w<80
    float bodySizeH = map(dna.genes[1], 0, 1, 10, 40);  // body height, genes[1], 10<h<40
    color c         = color(dna.genes[2], dna.genes[3], dna.genes[4]);
    
    // wheel1
    float wh1pos    = map(dna.genes[5], 0, 1, 0, 20);   // wh1     pos, genes[5], 0<x<20
    float wh1SizeW  = map(dna.genes[6], 0, 1, 5, 20);   // wh1   width, genes[6], 5<w<20
    float wh1SizeH  = map(dna.genes[7], 0, 1, 5, 20);   // wh1   height,genes[7], 5<h<20
    float wh1motorS = map(dna.genes[8], 0, 1, 2, 5);    // wh1   Speed, genes[8], 2<v<5
    float wh1motorT = map(dna.genes[9], 0, 1, 300, 1000);  // wh1   Torque,genes[9], 2<T<5
    
    // wheel2
    float wh2pos    = map(dna.genes[10], 0, 1, 20, 40);  // wh2     pos, genes[10], 20<x<40
    float wh2SizeW  = map(dna.genes[11], 0, 1, 5, 20);   // wh2   width, genes[11], 5<w<20
    float wh2SizeH  = map(dna.genes[12], 0, 1, 5, 20);   // wh2   height,genes[12], 5<h<20
    float wh2motorS = map(dna.genes[13], 0, 1, 2, 5);    // wh2   Speed, genes[13], 2<v<5
    float wh2motorT = map(dna.genes[14], 0, 1, 300, 1000);  // wh2   Torque,genes[14], 2<T<5
    
    // wheel3
    float wh3pos    = map(dna.genes[15], 0, 1, 40, 60);  // wh3     pos, genes[15], 40<x<60
    float wh3SizeW  = map(dna.genes[16], 0, 1, 5, 20);   // wh3   width, genes[16], 5<w<20
    float wh3SizeH  = map(dna.genes[17], 0, 1, 5, 20);   // wh3   height,genes[17], 5<h<20
    float wh3motorS = map(dna.genes[18], 0, 1, 2, 5);    // wh3   Speed, genes[18], 2<v<5
    float wh3motorT = map(dna.genes[19], 0, 1, 300, 1000);  // wh3   Torque,genes[19], 2<T<5
    
    
    box = new Box(x, y, bodySizeW, bodySizeH, false, c);
    // initialize position of two wheels
    wheel1 = new Box(x-(bodySizeW/2)+wh1pos, y+3, wh1SizeW, wh1SizeH, false, c);
    wheel2 = new Box(x-(bodySizeW/2)+wh2pos, y+3, wh2SizeW, wh2SizeH, false, c);
    wheel3 = new Box(x-(bodySizeW/2)+wh3pos, y+3, wh3SizeW, wh3SizeH, false, c);
    
    // Define joints
    RevoluteJointDef rjd1 = new RevoluteJointDef();
    rjd1.bodyA = box.body;
    rjd1.bodyB = wheel1.body;
    rjd1.localAnchorA = box2d.vectorPixelsToWorld(new Vec2(-(bodySizeW/2)+wh1pos, 3));
    rjd1.localAnchorB = box2d.vectorPixelsToWorld(new Vec2(0, 5));
    
    // parameters that affect Phyisics
    rjd1.motorSpeed = -PI * wh1motorS;
    rjd1.maxMotorTorque = wh1motorT;
    rjd1.enableMotor = true;
    box2d.world.createJoint(rjd1);
    
    RevoluteJointDef rjd2 = new RevoluteJointDef();
    rjd2.bodyA = box.body;
    rjd2.bodyB = wheel2.body;
    rjd2.localAnchorA = box2d.vectorPixelsToWorld(new Vec2(-(bodySizeW/2)+wh2pos, 3));
    rjd2.localAnchorB = box2d.vectorPixelsToWorld(new Vec2(0, 5));
    rjd2.motorSpeed = -PI*wh2motorS;
    rjd2.maxMotorTorque = wh2motorT;
    rjd2.enableMotor = true;
    box2d.world.createJoint(rjd2);
    
    RevoluteJointDef rjd3 = new RevoluteJointDef();
    rjd3.bodyA = box.body;
    rjd3.bodyB = wheel3.body;
    rjd3.localAnchorA = box2d.vectorPixelsToWorld(new Vec2(-(bodySizeW/2)+wh3pos, 3));
    rjd3.localAnchorB = box2d.vectorPixelsToWorld(new Vec2(0, 5));
    rjd3.motorSpeed = -PI*wh3motorS;
    rjd3.maxMotorTorque = wh3motorT;
    rjd3.enableMotor = true;
    box2d.world.createJoint(rjd3);
  }
  
  void display(Vec2 pos){
    box.display(pos);
    wheel1.display(pos);
    wheel2.display(pos);
    wheel3.display(pos);
  }
  
  // function that returns fitness
  void fitness(){
    // get the position of the body
    Vec2 pos = box2d.getBodyPixelCoord(box.body);
    // function corresponds to the distance of the car running 
    fitness = pos.x;
    fitness = pow(fitness, 4);
  }
  
  float getFitness(){
    return fitness;
  }
  
  DNA getDNA(){
    return dna;
  }
  
  // function that kills body
  void killBody(){
    box2d.destroyBody(box.body);
    box2d.destroyBody(wheel1.body);
    box2d.destroyBody(wheel2.body);
    box2d.destroyBody(wheel3.body);
  }
  
  
}
