// connect to the nearest n-nodes
// nodes can be connected to each other
// only when they are within circle


int node_num = 500;             // number of the node
int edge_num = 7;               // the number of edge from one node
node[] nodes = new node[node_num];
field f1;
float x,y;

void setup(){
  noCursor();
  size(400, 400, P2D);
  colorMode(HSB, 360, 100, 100, 100);
  blendMode(SCREEN);
  background(0, 80, 10, 100);
  for(int i=0; i<node_num; i++){
    nodes[i] = new node(new PVector(random(width), random(height)));
  }
  x=y=0;
}

void draw(){
  background(0, 80, 20, 100);
  strokeWeight(4);
  stroke(180, 100, 20, 5);
  
  //x=width/3 + 50*cos(frameCount*0.01) - 50;
  //y=height/2 + 50*sin(frameCount*0.01);
  f1 = new field(mouseX, mouseY, 150);
  
  for(node n: nodes){
    n.run(f1);
  }
  noFill();
  //f1.display_field();
}
