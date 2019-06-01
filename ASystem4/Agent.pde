class Ant{
  
  int pos;                          // position of ant
  IntList notVisitedIndex;          // not visited list
  int[][] selected_edge;            // which edge is selected?
  float total_dist;
  float[][] pherom_delta;           // amount of pherom dstributed through a tour
  float total_pherom = 5*city_num;          // total amount of pherom an agent produces through a tour
  IntList selectionPool;
  boolean StillTouring;             // Is ant still touring?
  
  // constructor
  Ant(){
    pos = 0;                                         // home = node0
    notVisitedIndex = new IntList();
    selected_edge = new int[city_num][city_num];     // 0:not_selected, 1:selected
    pherom_delta = new float[city_num][city_num];    // pherom_delta = total_pherom/distance 
    selectionPool = new IntList();
    total_dist = 0;
  }
  
  // function to initialize ant
  void init_ant(){
    pos = 0;
    notVisitedIndex.clear();
    for(int i=0; i<city_num; i++){
      notVisitedIndex.append(i);                     // append all city index
      for(int j=0; j<city_num; j++){
        selected_edge[i][j] = 0;
        pherom_delta[i][j] = 0;
      }
    }
    notVisitedIndex.removeValue(0);                  // we already visit node0
    total_dist = 0;
    StillTouring = true;                             
  }
  
  // function to move ant from node1 to node2;
  void activate_Ant(float[][] _total_pherom_val){
    if(StillTouring){
      int next_city_id;
      while(notVisitedIndex.size() != 0){
        next_city_id = choose_next_city(_total_pherom_val);      // choose
        memorize_route(next_city_id);                            // memorize selected edge
        total_dist += dist[pos][next_city_id];
        pos = next_city_id;                                      // move ant to next city
        notVisitedIndex.removeValue(pos);
      }
      // ant have to go back home(city 0)
      next_city_id = 0;
      memorize_route(next_city_id);
      total_dist += dist[pos][next_city_id];
      pos = 0;
      distribute_pherom();
      StillTouring = false;                                      // finish tour
    }
  }
  
  // function to choose edge based on pherom val and heuristic val
  int choose_next_city(float[][] _total_pherom_val){
    // calculate probability
    float[] p = new float[city_num];                             // probability
    selectionPool.clear();
    float[] pherom_val = new float[city_num];                    // pherom val of each edge
    float denominator = 0;
    for(int i: notVisitedIndex){
      pherom_val[i] = pow(_total_pherom_val[pos][i], 1.5);       // calculate p[pos][i]
      denominator += pherom_val[i]*heuris_val[pos][i]; 
    }
    for(int i: notVisitedIndex){
      p[i] = pherom_val[i]*heuris_val[pos][i]/denominator;
      int prob = (int)(p[i] * 100);
      for(int n=0; n<prob; n++){
        selectionPool.append(i);        
      }
    }
    // choose edge index
    int next = int(random(selectionPool.size()));
    return selectionPool.get(next);
  }

  // function to distribute pherom
  void memorize_route(int i){
    selected_edge[i][pos] = 1;
    selected_edge[pos][i] = 1;
  }
  
  void distribute_pherom(){
    for(int i=0; i<city_num; i++){
      for(int j=0; j<city_num; j++){
        pherom_delta[i][j] = selected_edge[i][j] * total_pherom / (total_dist*total_dist);
      }
    }
  }

  
  
  void update_pherom(){
    for(int i=0; i<city_num; i++){
      for(int j=0; j<city_num; j++){
        total_pherom_val[i][j] += pherom_delta[i][j];
      } 
    }
  }
}
