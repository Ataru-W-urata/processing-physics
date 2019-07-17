// BFS
// start: nodes[0][0]
// goal: nodes[num-1][num-1]
Node[][] nodes;
ArrayList<Node> que;
int num = 3;
int x_len;
int y_len;
float prob = 0.3;
float line_col = 0;

void setup(){
  size(200, 200);
  colorMode(HSB, 360, 100, 100, 100);
  background(0, 0, 90, 100);
  nodes = new Node[num][num];     // num x num
  que = new ArrayList<Node>();
  // init nodes
  x_len = int(width/num);
  y_len = int(height/num);
  for(int i=0; i<num; i++){
    for(int j=0; j<num; j++){
      nodes[i][j] = new Node((i+0.5)*x_len, (j+0.5)*y_len, i, j);
    }
  }
}


void draw(){
  background(0, 0, 90, 100);
  display();
  search();
}
// BFS
void search(){
  que.add(nodes[0][0]);           // nodes[0][0] is start point
  BFS: while(!que.isEmpty()){          // do while arraylist is not empty
 
    Node n = que.get(0);
    int i = n.x_num;              // n = nodes[i][j]
    int j = n.y_num;
    if(i<num-1&&n.edges[0]==1) {
      que.add(nodes[i+1][j]);
      if(i+1==num-1&&j==num-1){
        println("goal");
        noLoop();
        break BFS;
      }
    }
    if(j<num-1&&n.edges[1]==1) {
      que.add(nodes[i][j+1]);
      if(i==num-1&&j+1==num-1){
        println("goal");
        noLoop();
        break BFS;
      }
    }
    que.remove(0);                  // remove from que
  }
}



void display(){
  // display nodes
  noStroke();
  fill(100);
  for(int i=0; i<num; i++){
    for(int j=0; j<num; j++){
      nodes[i][j].display();
    }
  }
  // display edges
  stroke(200, 50, 100, 90);
  strokeWeight(2);
  for(int i=0; i<num; i++){
    for(int j=0; j<num; j++){
      if(i<num-1&&nodes[i][j].edges[0]==1) {
        line(nodes[i][j].pos.x, nodes[i][j].pos.y, nodes[i][j].pos.x+x_len, nodes[i][j].pos.y);
      }
      if(j<num-1&&nodes[i][j].edges[1]==1) {
        line(nodes[i][j].pos.x, nodes[i][j].pos.y, nodes[i][j].pos.x, nodes[i][j].pos.y+y_len);
      }
    }
  }  
}
