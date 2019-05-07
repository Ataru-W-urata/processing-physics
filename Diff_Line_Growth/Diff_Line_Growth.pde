float _maxForce = 0.5; // Maximum steering force
float _maxSpeed = 0.5; // Maximum speed
float _desiredSeparation = 10;
float _separationCohesionRation = 1.1;
float _maxEdgeLen = 7;

// creating object
DifferentialLine _diff_line;

void setup(){
  size(800, 600, FX2D);
  _diff_line = new DifferentialLine(_maxForce, _maxSpeed, _desiredSeparation, _separationCohesionRation, _maxEdgeLen);
  float nodeStart = 20;
  float angInc = TWO_PI/nodeStart;
  float rayStart = 10;
  for(float a=0; a<TWO_PI; a+=angInc){
    float x = width/2 + cos(a) * rayStart;
    float y = height/2 + sin(a) * rayStart;
    _diff_line.addNode(new Node(x,y, _diff_line.maxForce, _diff_line.maxSpeed));
  }
}

void draw(){
  background(50);
  stroke(220, 220, 100);
  _diff_line.run();
  fill(100, 100, 0, 10);
  _diff_line.renderShape();
}
