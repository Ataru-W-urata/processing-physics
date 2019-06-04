// 20 node system
// the length fo the edges are different for each other
// each edge contains 2 information, pherom value and heuristic value

import controlP5.*;                                           

// controller
ControlP5 cp5;
Knob alpha_knob;                                              // weight of pherom value
Knob beta_knob;                                               // weight of heuristic value
Knob evap_knob;                                               // rate of pherom evaporation

PFont font;

// city
PVector[] cities;// list of cities
int city_num = 20;

// parameters of edges
float[][] dist = new float[city_num][city_num];               // distance of each edge
float[][] heuris_val = new float[city_num][city_num];         // fixed value: (1/d)^beta. beta = 1.5
float[][] total_pherom_val = new float[city_num][city_num];   // total amount of pherom
int[][] selected_edge = new int[city_num][city_num];          // edge count on each loop
int[][] selected_edge_total = new int[city_num][city_num];    // total edge count
int sum_ants;                                                 // total count of ants
float[][] edge_stroke_weight = new float[city_num][city_num]; // strokeWeight of each edge

float search_prob = 0.5;
float alpha = 1.2;
float beta = 5.0;
float evap_rate = 0.95;

float base_pherom = 0.1;                                      // base value of pherom

colony ants;                                                  // colony contains 20 ants

void setup(){
  size(500, 300);
  background(255);
  frameRate(100);
  colorMode(HSB, 360, 100, 100, 100);
  
  // initialize button and Knob
  cp5 = new ControlP5(this); 
  alpha_knob = cp5.addKnob("alpha_val")
    .setRange(0, 3.00)
    .setValue(1.20)
    .setPosition(30, 30)
    .setRadius(20)
    .setNumberOfTickMarks(10);
    
  beta_knob = cp5.addKnob("beta_val")
    .setRange(0, 10.00)
    .setValue(5.00)
    .setPosition(30, 100)
    .setRadius(20)
    .setNumberOfTickMarks(10);
    
  evap_knob = cp5.addKnob("rho_val")
    .setRange(0, 1.00)
    .setValue(0.95)
    .setPosition(30, 170)
    .setRadius(20)
    .setNumberOfTickMarks(10);
  
  
  font = loadFont("GillSans-Light-12.vlw");
  textFont(font);
  
  // initialize colony
  ants = new colony();  
  ants.init_colony();
  sum_ants = 0;
  
  // initialize nodes
  cities = new PVector[city_num];
  float theta = 0;
  for(int i=0; i<city_num; i++){ 
    float x = (width/2 + 60) + 100 * cos(theta) + random(0, 80) - 40;
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
  background(0);
  // get knob value
  alpha = alpha_knob.getValue();
  beta = beta_knob.getValue();
  evap_rate = evap_knob.getValue();
  
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
  stroke(100, 100, 100, 100);
  fill(100, 80, 100, 100);
  for(int i=0; i<city_num; i++){
    ellipse(cities[i].x, cities[i].y, 15, 15);
  }
  
  // draw edges
  stroke(0, 100);
  for(int i=0; i<city_num; i++){
    for(int j=0; j<city_num; j++){
      edge_stroke_weight[i][j] = map(selected_edge_total[i][j], 0, sum_ants, 0.01, 10*city_num);  // more selected, more weightend
      strokeWeight(edge_stroke_weight[i][j]);
      float saturation = map(selected_edge_total[i][j], 0, sum_ants/2, 0, 500);
      float blightness = map(selected_edge_total[i][j], 0, sum_ants, 9, 0);
      stroke(50, 80-saturation, 100, 80);
      line(cities[i].x, cities[i].y, cities[j].x, cities[j].y);
      selected_edge[i][j] = 0;
    }
  }
  
  // draw some text
  fill(360, 0, 100, 100);
  text("Press 'Enter' to re-organize city", 20, 260);
  text("Press 'Space' to re-start the ants", 20, 280);
    
}

// function to evaporate pherom value
void evap_pherom(){
  for(int i=0; i<city_num; i++){
    for(int j=0; j<city_num; j++){
      total_pherom_val[i][j] = total_pherom_val[i][j]*(1 - evap_rate);
      if(total_pherom_val[i][j]<0) total_pherom_val[i][j] = base_pherom;
    }
  }
}

// re-evaluate the route
void keyPressed(){
  switch(key){
    // init city
    case ENTER:
    cities = new PVector[city_num];
    float theta = 0;
    for(int i=0; i<city_num; i++){ 
      float x = (width/2 + 60) + 100 * cos(theta) + random(0, 80) - 40;
      float y = height/2 + 100 * sin(theta) + random(0, 80) - 40;
      cities[i] = new PVector(x, y);
      theta += TWO_PI/city_num;
    }
    
    case ' ':
    ants.init_colony();
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
    sum_ants=0;
  }
}

void mouseDragged(MouseEvent e){
  for(int i=0; i<city_num; i++){
    if(mouseX <= cities[i].x+10 && mouseX >= cities[i].x-10 &&
       mouseY <= cities[i].y+10 && mouseY >= cities[i].y-10){
      cities[i].x = mouseX;
      cities[i].y = mouseY;
    }  
  }
}



  
