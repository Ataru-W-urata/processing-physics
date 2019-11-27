// Breadth-first search

// 1. キューを作成し、スタートノードを加える
// 2. 以下ループ
//    2-1. もしキューが空なら探索終了
//    2-2. 先頭のノードを開き、キューから取り除く : FIFO(First-in, First-out)
//    2-3. もし開いたノードがゴールなら、それを解決策として探索終了
//    2-4. 開いたノードの子ノードをキューの後ろに追加する

Node[] nodes = new Node[7];
int step = 0;

// queue
ArrayList<Node> open  = new ArrayList<Node>();
ArrayList<Integer> open_ind = new ArrayList<Integer>();  // Nodeのindexを保存するリスト
ArrayList<Node> close = new ArrayList<Node>(); 
ArrayList<Integer> close_ind = new ArrayList<Integer>(); // Nodeのindexを保存するリスト

void setup(){
  size(300, 300);
  background(255);
  
  initNodes();   
}

void draw(){
  background(255);
  for(Node n:nodes){
    n.display();
  }
  open.add(nodes[0]);
  open_ind.add(nodes[0].index);
  
  // BFS
  while(true){
    println("STEP : " + (step++));
    println("OPEN : "); printArray(open_ind);
    println("CLOSE: "); printArray(close_ind);
    if(open.size()==0){
      println("queue size == 0");
      break;
    }
    else{
      Node current = open.get(0);
      open.remove(0);
      open_ind.remove(0);
      close.add(current);
      close_ind.add(current.index);
      ArrayList<Node> children = current.returnChildren();
      for(int i=0; i<children.size(); i++){
        Node m = children.get(i);
        if(!open.contains(m) && !close.contains(m)){
          open.add(m);
          open_ind.add(m.index);
        }
      }
    }
  }
  noLoop();
}


void initNodes(){
  nodes[0] = new Node(0, 1, 2, 0.5*width, 0.25*height); // first Node
  nodes[1] = new Node(1, 3, 4, 0.3*width, 0.5*height);
  nodes[2] = new Node(2, 5, 6, 0.7*width, 0.5*height);
  nodes[3] = new Node(3, -1, -1, 0.2*width, 0.75*height);
  nodes[4] = new Node(4, -1, -1, 0.4*width, 0.75*height);
  nodes[5] = new Node(5, -1 ,-1, 0.6*width, 0.75*height);
  nodes[6] = new Node(6, -1, -1, 0.8*width, 0.75*height);
  
}

class Node{
  int index;
  int output1;
  int output2;
  float x;
  float y;
  // constructor
  Node(int _ind, int _o1, int _o2, float _x, float _y){
    index = _ind;
    output1 = _o1;
    output2 = _o2;
    x = _x;
    y = _y;
  }
  
  // methods
  ArrayList<Node> returnChildren(){
    ArrayList<Node>children = new ArrayList<Node>();
    if(output1>=0) children.add(nodes[output1]);
    if(output2>=0) children.add(nodes[output2]);
    return children;
  }
  
  void display(){
    ellipse(x, y, 20, 20);
  }
}
