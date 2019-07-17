class Node{
  PVector pos;
  int[] edges;
  int x_num;
  int y_num;
  
  // constructor
  Node(float _x, float _y, int _x_num, int _y_num){
    pos = new PVector(_x, _y);
    edges = new int[2];          // down, right
    x_num = _x_num;
    y_num = _y_num;
    for(int i=0; i<2; i++){
      if(random(1)<prob)edges[i] = 1;
      else edges[i] = 0;
    }
  }
  
  
  // function to display node
  void display(){
    circle(pos.x, pos.y, 20.0/num);
  }
}
