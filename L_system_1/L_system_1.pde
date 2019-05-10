char V = 'A';
String S = "A";
int num = 4;

float d = 10; // the length of a asegment with a leaf
float angle;

Rule rule;

void setup(){
  frameRate(20);
  size(400, 300);
  background(0);
  
  stroke(255);
  strokeWeight(1);
}

void draw(){
  background(0);
  float mouse = map(mouseX, 0, width, 0, 180);
  angle = radians(20*noise(frameCount)-20 + mouse);
  rule = new Rule(V, S);
  for(int i=0; i<num; i++){
    rule.run();
    rule.run2();
  }
  rule.differentiate(d, angle);
}

void mouseClicked(){
  num ++;
  d = d/2;
}
