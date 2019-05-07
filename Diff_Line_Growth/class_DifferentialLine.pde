class DifferentialLine{
  ArrayList<Node> nodes; // List for nodes
  float maxForce; 
  float maxSpeed;
  float desiredSeparation;
  float sq_desiredSeparation;
  float separationCohesionRation;
  float maxEdgeLen;
  
  // Constructor
  DifferentialLine(float mF, float mS, float dS, float sCr, float eL){
    nodes = new ArrayList<Node>();
    maxSpeed = mS;
    maxForce = mF;
    desiredSeparation = dS;
    sq_desiredSeparation = sq(desiredSeparation);
    separationCohesionRation = sCr;
    maxEdgeLen = eL;
  }
  // add new Node
  void addNode(Node n){
    nodes.add(n);
  }
  void addNodeAt(Node n, int index){
    nodes.add(index, n);
  }
  // run differentiate() and growth()
  void run(){
    differentiate();
    growth();
  }
  // adding new Node between 2 Nodes where Length of Edge is wider than maxEdgeLen
  void growth(){
    for(int i=0; i<nodes.size()-1; i++){
      Node n1 = nodes.get(i);
      Node n2 = nodes.get(i+1);
      float d = PVector.dist(n1.position, n2.position);
      if(d>maxEdgeLen){
        int index = nodes.indexOf(n2);
        PVector middleNode = PVector.add(n1.position, n2.position).div(2);
        addNodeAt(new Node(middleNode.x, middleNode.y, maxForce, maxSpeed), index);
      }
    }
  }
  void differentiate(){
    PVector[] SeparationForces = getSeparationForces();
    PVector[] cohesionForces = getEdgeCohesionForces();
    for(int i=0; i<nodes.size(); i++){
      PVector separation = SeparationForces[i];
      PVector cohesion = cohesionForces[i];
      // if separationForce should be stronger than cohesion,
      // SeparationCohesionRate > 1
      separation.mult(separationCohesionRation);
      // apply forces to each Node
      nodes.get(i).applyForce(separation);
      nodes.get(i).applyForce(cohesion);
      nodes.get(i).update();
    }
  }
  
  PVector[] getSeparationForces(){
    int n = nodes.size();
    PVector[] separateForces = new PVector[n];
    int [] nearNodes = new int[n];
    Node nodei;
    Node nodej;
    // calculate separationForces for each nodes
    for(int i=0; i<n; i++){
      separateForces[i] = new PVector(); 
    }
    for(int i=0; i<n; i++){
      nodei = nodes.get(i);
      for (int j=i+1; j<n; j++){
        nodej = nodes.get(j);
        PVector forceij = getSeparationForce(nodei, nodej);
        if(forceij.mag()>0){
          separateForces[i].add(forceij);
          // the direction of these 2 vectors should be opposite 
          separateForces[j].sub(forceij);
          nearNodes[i]++;
          nearNodes[j]++;
        }
      }
      if(nearNodes[i]>0){
        separateForces[i].div((float)nearNodes[i]);
      }
      if(separateForces[i].mag()>0){
        separateForces[i].setMag(maxSpeed);
        separateForces[i].sub(nodes.get(i).velocity);
        separateForces[i].limit(maxForce);
      }
    }
    return separateForces; 
  }
  
  // calculate separation force
  PVector getSeparationForce(Node n1, Node n2){
    PVector steer = new PVector(0, 0);
    float sq_d = sq(n2.position.x-n1.position.x)+sq(n2.position.y-n1.position.y);
    if(sq_d>0 && sq_d<sq_desiredSeparation){
      PVector diff = PVector.sub(n1.position, n2.position);
      diff.normalize();
      diff.div(sqrt(sq_d)); // Weight by Distance
      steer.add(diff);
    }
    return steer;
  }
  PVector[] getEdgeCohesionForces(){
    int  n = nodes.size();
    PVector[] cohesionForces  =new PVector[n];
    for(int i=0; i<nodes.size(); i++){
      PVector sum = new PVector(0, 0);
      if(i!=0 && i!=nodes.size()-1){
        sum.add(nodes.get(i-1).position).add(nodes.get(i+1).position);
      } else if(i == 0){
        sum.add(nodes.get(nodes.size()-1).position).add(nodes.get(i+1).position);
      } else if(i == nodes.size()-1){
        sum.add(nodes.get(i-1).position).add(nodes.get(0).position);
      }
      sum.div(2);
      cohesionForces[i] = nodes.get(i).seek(sum);
    }
    return cohesionForces;
  }
  // drawing shape
  void renderShape(){
    beginShape();
    for(int i=0; i<nodes.size(); i++){
      vertex(nodes.get(i).position.x, nodes.get(i).position.y);
    }
    endShape(CLOSE);
  }
  void renderLine(){
    for(int i=0; i<nodes.size()-1; i++){
      PVector p1 = nodes.get(i).position;
      PVector p2 = nodes.get(i+1).position;
      line(p1.x, p1.y, p2.x, p2.y);
      if(i==nodes.size()-2){
        line(p2.x, p2.y, nodes.get(0).position.x, nodes.get(0).position.y);
      }
    }
  }
}
