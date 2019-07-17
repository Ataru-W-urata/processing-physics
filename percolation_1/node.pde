class Node{
  PVector pos;
  
  // constructor
  Node(float _x, float _y){
    pos = new PVector(_x, _y);
  }
  
  void display(){
    push();
    noStroke();
    fill(100);
    circle(pos.x, pos.y, 2);
    pop();
  }
}
