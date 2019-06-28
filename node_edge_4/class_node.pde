// class
class node{
  PVector pos;                  // position
  PVector v;                    // velocity
  PVector a;                    // acceleration
  PVector[] n_nodes;            // list of nearest nodes
  boolean isInField;            // is node inside the field? 
  
  // constructor
  node(PVector _pos){
    pos = _pos;
    v = PVector.random2D();
    a = new PVector(0, 0);
    n_nodes = new PVector[edge_num];
    isInField = false;
  }
  
  // function to run below functions
  void run(field f){
    check_field(f);
    connect_node();
    move_node();
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
    for(int i=0; i<edge_num; i++){
      if(this.isInField) {line(this.pos.x, this.pos.y, n_nodes[i].x, n_nodes[i].y);}
    }
    //point(pos.x, pos.y);
    //total_dist = map(total_dist, 0, 100, 0, 360);
    //fill(total_dist, 100, 100, 60);
    //noFill();
    //beginShape();
    //vertex(this.pos.x, this.pos.y);
    //for(int i=0; i<edge_num; i++){
    //  vertex(n_nodes[i].x, n_nodes[i].y); 
    //}
    //endShape();
  }
  
  // function to check whether node is inside the field
  void check_field(field f){
    float cx = pos.dist(f.center);
    if(cx<(f.rad)/2) isInField = true;
    else isInField = false;
  }
  
  
  // function to display node
  void display_node(){
    circle(this.pos.x, this.pos.y, 10);
  }
}
