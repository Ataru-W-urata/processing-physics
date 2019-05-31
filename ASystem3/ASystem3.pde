// Two-node system
// nodes are connected with 4 edges
// the length fo the edges are different for each other
// each edge contains 2 information, pherom value and heuristic value

PFont font; 
PVector n1;                                     // location of node 1
PVector n2;                                     // location of node 2

// parameters of edges, e0, e1, e2, e3
float[] dist = {11.1, 11.2, 12, 11.3};                // distance of each edge
float[] heuris_val = new float[4];              // fixed value: (1/d)^beta. beta = 1.5
float[] total_pherom_val = new float[4];        // total amount of pherom
int[] selected_edge = new int[4];               // edge count on each loop
int[] selected_edge_total = new int[4];         // total edge count
int sum_ants = 0;                               // total count of ants
float[] edge_stroke_weight = new float[4];      // strokeWeight of each edge

float base_pherom = 0.1;                        // base value of pherom

colony ants;                                    // colony contains 20 ants

void setup(){
  size(400, 300);
  background(240);
  font = loadFont("TimesNewRomanPSMT-18.vlw");
  textFont(font);
  frameRate(1);
  // initialize colony
  ants = new colony();  
  ants.init_colony();
  // initialize nodes
  n1 = new PVector(30, height/2);         
  n2 = new PVector(width-30, height/2);   
  // initialize edges 
  for(int i=0; i<4; i++){
    heuris_val[i] = pow(1.0/dist[i], 1.5);
    total_pherom_val[i] = 0.1;
    selected_edge[i] = 0;
    selected_edge_total[i] = 0;
    edge_stroke_weight[i] = 0;
  }
}

void draw(){
  background(240);
  ants.activate_colony(total_pherom_val);      // activate 20 ants. they choose edges, move on next node, and produce pherom 
  selected_edge = ants.get_edge_count();       // how many ants selected for each edges?
  for(int i=0; i<4; i++){
    selected_edge_total[i] += selected_edge[i];
    sum_ants += selected_edge[i];
  }
  ants.update_colony_pherom();                 // update pherom value of each edges
  ants.init_colony();                          // initialize 20 ants
  
  evap_pherom();

  // draw nodes
  strokeWeight(2);
  stroke(0, 50, 200, 50);
  fill(0);
  ellipse(n1.x, n1.y, 20, 20);
  ellipse(n2.x, n2.y, 20, 20);
  
  // draw edges
  stroke(0, 100);
  for(int i=0; i<4; i++){
    edge_stroke_weight[i] = map(selected_edge_total[i], 0, sum_ants, 0.1, 10);  // more selected, more weightend
    strokeWeight(edge_stroke_weight[i]);
    line(n1.x, n1.y, 50, (i+1)*height/5);
    line(50, (i+1)*height/5, width-50, (i+1)*height/5);
    line(width-50, (i+1)*height/5, n2.x, n2.y);
    text("Edge: " + (i) + ", d: " + dist[i] + ", ants: " + selected_edge_total[i], width/2-100, ((i+1)*height/5)-10);
    selected_edge[i] = 0;
  }
}

// function to evaporate pherom value
void evap_pherom(){
  for(int i=0; i<4; i++){
    total_pherom_val[i] *= 0.25;       // half of pherom evaporates at each loop
  }
}


  
void mouseClicked(){
  noLoop();
}


  
