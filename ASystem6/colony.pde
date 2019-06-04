// set of ants

class colony{
  int num = city_num;                    // num of ants
  Ant[] ants;
  int[][] sum_edge_selected;               // sum of selected edge count
  float[][] total_colony_pherom;
  
  // constructor
  colony(){
    ants = new Ant[num];
    for(int n=0; n<num; n++){
      ants[n] = new Ant();
    }
    sum_edge_selected = new int[city_num][city_num];
    total_colony_pherom = new float[city_num][city_num];
  }
  
  // function to initialize all ants
  void init_colony(){
    for(int n=0; n<num; n++){
      ants[n].init_ant();                // initialize of all ants 
    }
    for(int i=0; i<city_num; i++){
      for(int j=0; j<city_num; j++){
        sum_edge_selected[i][j] = 0;     // edge is not selected yet
        total_colony_pherom[i][j] = 0;
      }
    }
  }
  
  // function to activate each ant
  void activate_colony(float[][] _total_pherom_val){
    for(int n=0; n<num; n++){
      ants[n].activate_Ant(_total_pherom_val);
    }
    // calculate the count
    count_selected_edges();
  }
  
  // function to calculate the number of ants passing each edge
  void count_selected_edges(){
    for(int n=0; n<num; n++){
      for(int i=0; i<city_num; i++){
        for(int j=0; j<city_num; j++){
          sum_edge_selected[i][j] += ants[n].selected_edge[i][j]; 
        }
      }
    } 
  }
  
  void update_colony_pherom(){
    for(int n=0; n<num; n++){
      for(int i=0; i<city_num; i++){
        for(int j=0; j<city_num; j++){
          total_colony_pherom[i][j] += ants[n].pherom_delta[i][j]; // how many times each edges was selected? 
        }
      }
    }
    for(int i=0; i<city_num; i++){
      for(int j=0; j<city_num; j++){
        total_pherom_val[i][j] += total_colony_pherom[i][j]; 
      }  
    }
  }
  
  int[][] get_edge_count(){
    return sum_edge_selected;
  }
}
