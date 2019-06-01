// 10 node system
// nodes are connected with 4 edges
// the length fo the edges are different for each other
// each edge contains 2 information, pherom value and heuristic value

PFont font;
PVector[] cities;                                             // list of cities
int city_num = 20;

// parameters of edges
float[][] dist = new float[city_num][city_num];               // distance of each edge
float[][] heuris_val = new float[city_num][city_num];         // fixed value: (1/d)^beta. beta = 1.5
float[][] total_pherom_val = new float[city_num][city_num];   // total amount of pherom
int[][] selected_edge = new int[city_num][city_num];          // edge count on each loop
int[][] selected_edge_total = new int[city_num][city_num];    // total edge count
int sum_ants = 0;                                             // total count of ants
float[][] edge_stroke_weight = new float[city_num][city_num]; // strokeWeight of each edge

float beta = 2;

float base_pherom = 0.1;                                      // base value of pherom

colony ants;                                                  // colony contains 20 ants

void setup(){
  size(400, 300);
  background(240);
  font = loadFont("TimesNewRomanPSMT-18.vlw");
  textFont(font);
  frameRate(60);
  
  // initialize colony
  ants = new colony();  
  ants.init_colony();
  
  // initialize nodes
  cities = new PVector[city_num];
  float theta = 0;
  for(int i=0; i<city_num; i++){ 
    float x = width/2 + 100 * cos(theta) + random(0, 80) - 40;
    float y = height/2 + 100 * sin(theta) + random(0, 80) - 40;
    cities[i] = new PVector(x, y);
    theta += TWO_PI/city_num;
  }
  
  // initialize edges 
  for(int i=0; i<city_num; i++){
    for(int j=0; j<city_num; j++){
      dist[i][j] = PVector.dist(cities[i],cities[j]);
      heuris_val[i][j] = pow(1.0/dist[i][j], beta);
      total_pherom_val[i][j] = 0.1;
      selected_edge[i][j] = 0;
      selected_edge_total[i][j] = 0;
      edge_stroke_weight[i][j] = 0;
    }
  }
}

void draw(){
  background(240);
  ants.activate_colony(total_pherom_val);      // activate 20 ants. they choose edges, move on next node, and produce pherom 
  selected_edge = ants.get_edge_count();       // how many ants selected for each edges?
  for(int i=0; i<city_num; i++){
    for(int j=0; j<city_num; j++){
      selected_edge_total[i][j] += selected_edge[i][j];
      sum_ants += selected_edge[i][j];
    }
  }
  ants.update_colony_pherom();                 // update pherom value of each edges
  ants.init_colony();                          // initialize 20 ants
  
  evap_pherom();

  // draw nodes
  strokeWeight(2);
  stroke(0, 50, 200, 50);
  fill(0);
  for(int i=0; i<city_num; i++){
    ellipse(cities[i].x, cities[i].y, 10, 10);
  }
  
  // draw edges
  stroke(0, 100);
  for(int i=0; i<city_num; i++){
    for(int j=0; j<city_num; j++){
      edge_stroke_weight[i][j] = map(selected_edge_total[i][j], 0, sum_ants, 0.01, 4*city_num);  // more selected, more weightend
      strokeWeight(edge_stroke_weight[i][j]);
      line(cities[i].x, cities[i].y, cities[j].x, cities[j].y);
      selected_edge[i][j] = 0;
    }
  }
    
}

// function to evaporate pherom value
void evap_pherom(){
  for(int i=0; i<city_num; i++){
    for(int j=0; j<city_num; j++){
      total_pherom_val[i][j] *= 0.25;       // half of pherom evaporates at each loop
    }
  }
}


  
void mouseClicked(){
  noLoop();
}


  
