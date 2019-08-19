class Mass{
  PVector pos;
//  PVector f;                   // force
//  PVector v;                   // velocity
  float   a;                   // angular acceleration
  float   w;                   // anglular velocity
  float   l;                   // length of pendulum
  float angle;                 // init angle = 30
  
  // constructor
  Mass(float _l){
//    f = new PVector(0, 0);
//    v = new PVector(0, 0);
    a = 0;
    w = 0;
    l = _l;
    angle = 10;
    float x = width/2 - l*sin(radians(angle));
    float y = 1/3*height + l*(cos(radians(angle)));
    pos = new PVector(x, y);
  }
  
  void run(){
    a = (-9.8) * 10 / l * sin(radians(angle));
    w += a;
    angle += w;
    pos.x = width/2 - l*sin(radians(angle));
    pos.y = 1/3*height + l*(cos(radians(angle)));
  }
  
  void display(){
    push();
    stroke(50);
    strokeWeight(1.5);
    line(width/2, 1/3*height, pos.x, pos.y);
    noStroke();
    fill(10, 10, 200, 100);
    circle(pos.x, pos.y, 10);
    pop();
  }
}
