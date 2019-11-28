// Circuit have genome and develop 12 NAND Gates based on genomic information
// Obtain the shape of the circuit using breadth-first search (BFS)

class Circuit{
  
  final int GATE_NUM = 12;  
  Genome genome;
  Gate[] gates;
  Output output;
  
  IntList operation_sequence; // list of index of all gates that connect to output
  IntList graph_sequence;     // list for displaying gates
  ArrayList <Gate> open;
  ArrayList <Gate> closed;
  boolean[] stream;
  
  // primary inputs
  boolean pi1,pi2,pi3,pi4;
  
  // constructor
  Circuit(boolean _pi1, boolean _pi2, boolean _pi3, boolean _pi4){
    genome = new Genome();
    gates = new Gate[GATE_NUM];
    pi1 = _pi1; pi2 = _pi2; pi3 = _pi3; pi4 = _pi4;
    // init gates
    for(int i=0; i<GATE_NUM; i++){
      gates[i] = new Gate(i, genome.genes.substring(i*8, i*8+4), genome.genes.substring(i*8+4, i*8+8));
    }
    output = new Output(genome.genes.substring(GATE_NUM*8));
    
    operation_sequence = new IntList();
    graph_sequence = new IntList();
    
    // make operation sequence using breadth first search
    if(output.i_address>=0){
      open = new ArrayList<Gate>();
      closed = new ArrayList<Gate>();
      
      open.add(gates[output.i_address]);
      operation_sequence.append(output.i_address);
      graph_sequence.append(output.i_address);
      
      // Do BFS
      int count = 0;
      while(true){
        if(open.size()==0){
          break;
        }
        else{
          count++;
          if(count>100) break;
          Gate current = open.get(0);
          open.remove(0);
          closed.add(current);
          ArrayList<Gate> upstream = current.getInputAddress(gates);
          for(int i=0; i<upstream.size(); i++){
            Gate g = upstream.get(i);
            operation_sequence.append(g.index);
            if(!open.contains(g) && !closed.contains(g)){
              open.add(g);
              graph_sequence.append(g.index);
            }
          }
        }
      }
    }
    else{
      operation_sequence.append(output.i_address);
      graph_sequence.append(output.i_address);
    }
    operation_sequence.reverse();
    graph_sequence.reverse();
  }
  
  // method
  
  // Do NAND Operation from upstream to downstream
  void runCircuit(){ // primary inputs(input1~4)
   
    stream = new boolean[operation_sequence.size()];
    for(int i=0; i<operation_sequence.size(); i++){
        if(operation_sequence.get(i)>=0){
        int input1 = gates[operation_sequence.get(i)].i1_address;
        int input2 = gates[operation_sequence.get(i)].i2_address;
        
        boolean i1;      
        switch(input1){
          case -4: i1 = pi1; break;
          case -3: i1 = pi2; break;
          case -2: i1 = pi3; break;
          case -1: i1 = pi4; break;
          default: i1 = gates[input1].getResult(); break;
        }      
        boolean i2;
        switch(input2){
          case -4: i2 = pi1; break;
          case -3: i2 = pi2; break;
          case -2: i2 = pi3; break;
          case -1: i2 = pi4; break;
          default: i2 = gates[input2].getResult(); break;
        }
        stream[i] = gates[operation_sequence.get(i)].operate(i1, i2);
      }
      else{
        boolean i1;      
        switch(operation_sequence.get(i)){
          case -4: i1 = pi1; break;
          case -3: i1 = pi2; break;
          case -2: i1 = pi3; break;
          case -1: i1 = pi4; break;
          default: i1 = true; break;
        }
        stream[i] = i1;
      }
    }
  }
  
  void display(){
    int Graph_NUM = graph_sequence.size();
    if(graph_sequence.get(0)>=0){
      for(int i=0; i<Graph_NUM; i++){
        int address = graph_sequence.get(i);
        push();
        translate(width*(i+1)/(Graph_NUM+1.0), height/2);
        circle(0, 0, 20);
        if(gates[address].result) fill(0);
        else                                    fill(255,0,0);
        text(gates[graph_sequence.get(i)].index, 0, 0);
        
        if(gates[address].i1_address>=0){
          if(gates[gates[address].i1_address].result) fill(0);
          else                                        fill(255,0,0);
        }
        text(gates[address].i1_address, -12, -18);
        
        if(gates[address].i2_address>=0){
          if(gates[gates[address].i2_address].result) fill(0);
          else                                        fill(255,0,0);
        }
        text(gates[address].i2_address, 12, -18);
        pop();
      }
      String result;
      if(stream[stream.length-1]) result = "TRUE";
      else                        result = "FALSE";
      fill(0);
      text(result, width/2, height/2+50);
    }
  }
}
