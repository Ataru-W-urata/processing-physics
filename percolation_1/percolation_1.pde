Node[][] nodes;
float edge_len =  10; // distance between adjacent nodes
int x_d;
int y_d;
float prob = 0.25;

void setup(){
  size(200, 200);
  background(240);
  
  // init nodes
  x_d = ceil(width/edge_len) + 1;
  y_d = ceil(height/edge_len) + 1;
  nodes = new Node[x_d][y_d];
  for(int i=0; i<x_d; i++){
    for(int j=0; j<y_d; j++){
      nodes[i][j] = new Node(i*edge_len, j*edge_len);
    }
  }
}

void draw(){
  display();
  connect();
  noLoop();
}


// function display each node
void display(){
  for(int i=0; i<x_d; i++){
    for(int j=0; j<y_d; j++){
      nodes[i][j].display();
    }
  }
}

// function to connect 2 nearest nodes
void connect(){
  horizontal_connect();
  vertical_connect();
}

void horizontal_connect(){
  for(int i=0; i<x_d-1; i++){
    for(int j=0; j<y_d-1; j++){
      // horizontal
      if(random(1)<prob){
        line(nodes[i][j].pos.x, nodes[i][j].pos.y, nodes[i+1][j].pos.x, nodes[i+1][j].pos.y);
      }
    }
  }  
}

void vertical_connect(){
  for(int i=0; i<x_d-1; i++){
    for(int j=0; j<y_d-1; j++){
      // vertical
      if(random(1)<prob){
        line(nodes[i][j].pos.x, nodes[i][j].pos.y, nodes[i][j+1].pos.x, nodes[i][j+1].pos.y);
      }
    }
  }  
}
