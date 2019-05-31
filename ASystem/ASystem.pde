// Two-node system
// nodes are connected with 4 edges
// the length fo the edges are different for each other
// each edge contains 2 information, pherom value and heuristic value

PFont font; 
PVector n1;                                     // location of node 1
PVector n2;                                     // location of node 2

// parameters of edges, e0, e1, e2, e3
float[] dist = {20, 11, 20, 30};                // distance of each edge
float[] heuris_val = new float[4];              // fixed value: (1/d)^beta. beta = 1.5
float[] total_pherom_val = new float[4];        // dynamic value
int selected_edge = -1;
int[] selected_time = new int[4];

float base_pherom = 0.1;                        // base value of pherom

Ant ant;

void setup(){
  size(400, 300);
  background(240);
  font = loadFont("TimesNewRomanPSMT-18.vlw");
  textFont(font);
  frameRate(1);
  ant = new Ant();
  ant.init_ant();
  // initialize nodes
  n1 = new PVector(30, height/2);         
  n2 = new PVector(width-30, height/2);   
  // initialize edges 
  for(int i=0; i<4; i++){
    heuris_val[i] = pow(1.0/dist[i], 1.5);
    total_pherom_val[i] = 0.1;
    selected_time[i] = 0;
  }
}

void draw(){
  background(240);
  ant.activate_Ant(total_pherom_val);
  selected_edge = ant.getSelectedIndex();
  ant.update_pherom();
  ant.init_ant();
  
  // draw nodes
  strokeWeight(2);
  stroke(0, 50, 200, 50);
  fill(0);
  ellipse(n1.x, n1.y, 20, 20);
  ellipse(n2.x, n2.y, 20, 20);
  // draw edges
  strokeWeight(1);
  stroke(0, 100);
  for(int i=0; i<4; i++){
    line(n1.x, n1.y, 50, (i+1)*height/5);
    line(50, (i+1)*height/5, width-50, (i+1)*height/5);
    line(width-50, (i+1)*height/5, n2.x, n2.y);
    text("Edge: " + (i) + " num: " + selected_time[i], width/2-20, ((i+1)*height/5)-10);
    if(i == selected_edge){
      selected_time[i] += 1;
      ellipse(width/2-50, ((i+1)*height/5)-10, 10, 5);
      selected_edge = -1;
    }
  }
}
  
void mouseClicked(){
  noLoop();
}
  
