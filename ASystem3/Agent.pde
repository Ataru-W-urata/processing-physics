class Ant{
  
  int pos;                          // position of ant. node1 or node2
  int[] selected_edge;              // which edge is selected?
  float[] pherom_delta;             // amount of pherom dstributed through a tour
  float total_pherom = 10;          // total amount of pherom an agent produces through a tour
  IntList selectionPool;
  
  // constructor
  Ant(){
    pos = 1;                        // home = node1
    selected_edge = new int[4];     // -1: not selected yet
    pherom_delta = new float[4];    // pherom_delta = total_pherom/distance 
    selectionPool = new IntList();
  }
  
  // function to initialize ant
  void init_ant(){
    pos = 1;
    for(int i=0; i<4; i++){
      selected_edge[i] = 0;
      pherom_delta[i] = 0;
    }
  }
  
  // function to move ant from node1 to node2;
  void activate_Ant(float[] _total_pherom_val){
    if(pos==1){
      int edge_id = choose_edge(_total_pherom_val);  // choose
      distribute_pherom(edge_id);                    // left pherom on selected edge
      pos = 2;                                       // move ant from node1 to node2
    }
  }
  
  // function to choose edge based on pherom val and heuristic val
  int choose_edge(float[] _total_pherom_val){
    // calculate probability
    float[] p = new float[4];          // probability
    selectionPool.clear();
    float[] pherom_val = new float[4]; // pherom val of each edge
    float denominator = 0;
    for(int i=0; i<4; i++){
      pherom_val[i] = pow(_total_pherom_val[i], 1.5);
      denominator += pherom_val[i]*heuris_val[i]; 
    }
    for(int i=0; i<4; i++){
      p[i] = pherom_val[i]*heuris_val[i]/denominator;
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
  void distribute_pherom(int i){
    selected_edge[i] = 1;
    pherom_delta[i] = total_pherom/dist[i];
  }

  
  
  void update_pherom(){
    for(int i=0; i<4; i++){
      total_pherom_val[i] += pherom_delta[i]; 
    }
  }

}
