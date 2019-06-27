// connect to the nearest n-nodes
int node_num = 100;             // number of the node
int edge_num = 4;               // the number of edge from one node
node[] nodes = new node[node_num];

void setup(){
  size(300, 300, P2D);
  colorMode(HSB, 360, 100, 100, 100);
  background(0, 80, 20, 100);
  for(int i=0; i<node_num; i++){
    nodes[i] = new node(new PVector(random(width), random(height)));
  }
}

void draw(){
  background(0, 80, 20, 100);
  strokeWeight(4);
  stroke(180, 100, 100, 20);
  for(node n: nodes){
    n.connect_node();
    // n.display_node();
    n.move_node();
  }
}

// class
class node{
  PVector pos;                  // position
  PVector v;                    // velocity
  PVector a;                    // acceleration
  
  // constructor
  node(PVector _pos){
    pos = _pos;
    v = PVector.random2D();
    a = new PVector(0, 0);
  }
  
  // function to move node
  void move_node(){
    pos.add(v);
    if(pos.x<0 || pos.x>width){
      v.x = -v.x;
    }
     if(pos.y<0 || pos.y>height){
      v.y = -v.y; 
    }
  }
  
  
  // function to connect each other
  void connect_node(){
    float[] n_dist = new float[edge_num];
    PVector[] n_nodes = new PVector[edge_num];
    for(int i=0; i<edge_num; i++){
      n_dist[i] = 1000;
      n_nodes[i] = new PVector(0, 0);
    }   
    for(node n: nodes){
      if(n!=this){
        float dist = this.pos.dist(n.pos);

        for(int i=0; i<edge_num; i++){
          if(n_dist[i]>dist){
            for(int j=edge_num-1; j>i; j--){
              n_dist[j] = n_dist[j-1];
              n_nodes[j] = n_nodes[j-1];
            }
            n_dist[i] = dist;
            n_nodes[i] = n.pos;
            break;
          }
        }
      }
    }
    float total_dist = 0;
    for(int i=0; i<edge_num; i++){
      line(this.pos.x, this.pos.y, n_nodes[i].x, n_nodes[i].y);
      total_dist += n_dist[i];
    }
    
    total_dist = map(total_dist, 0, 100, 0, 360);
    
    //fill(total_dist, 100, 100, 60);
    noFill();
    beginShape();
    vertex(this.pos.x, this.pos.y);
    for(int i=0; i<edge_num; i++){
      vertex(n_nodes[i].x, n_nodes[i].y); 
    }
    endShape();
  }
  
  // function to display node
  void display_node(){
    circle(this.pos.x, this.pos.y, 10);
  }
}
