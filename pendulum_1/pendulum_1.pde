int num = 8;
Mass[] pendulum;

void setup(){
  size(200, 200);
  background(240);
  ellipseMode(RADIUS);
  // init pendulum
  pendulum = new Mass[num];
  for(int i=0; i<num; i++){
    pendulum[i] = new Mass(sqrt((i+1)*1000));
  }
}

void draw(){
  background(240);
  for(int i=0; i<num; i++){
    pendulum[i].run();
    pendulum[i].display();
  }
}
