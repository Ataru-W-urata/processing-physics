// Circuit have genome and develop 12 NAND Gates based on genomic information
// Obtain the shape of the circuit using breadth-first search (BFS)

class Circuit{
  
  final int GATE_NUM = 12;  
  Genome genome;
  Gate[] gates;
  Output output;
  
  IntList operation_sequence; // list of index of all gates and inputs
  ArrayList <Gate> open;
  ArrayList <Gate> closed;
  
  // constructor
  Circuit(){
    genome = new Genome();
    gates = new Gate[GATE_NUM];
    // init gates
    for(int i=0; i<GATE_NUM; i++){
      gates[i] = new Gate(i, genome.genes.substring(i*8, i*8+4), genome.genes.substring(i*8+4, i*8+8));
    }
    output = new Output(genome.genes.substring(GATE_NUM*8));
    
    // make operation sequence using breadth first search
    if(output.i_address>=0){
      operation_sequence = new IntList();
      open = new ArrayList<Gate>();
      closed = new ArrayList<Gate>();
      
      open.add(gates[output.i_address]);
      
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
          operation_sequence.append(current.index);
          ArrayList<Gate> upstream = current.getInputAddress(gates);
          for(int i=0; i<upstream.size(); i++){
            Gate g = upstream.get(i);
            if(!open.contains(g) && !closed.contains(g)){
              open.add(g);
            }
          }
        }
      }
    }
    else{
      operation_sequence = new IntList();
      operation_sequence.append(output.i_address);
    }
    operation_sequence.reverse();
  }
  
  // method
  void runCircuit(int _pi1, int _pi2, int _pi3, int _pi4){ // primary inputs
    
  }
  
  void display(){
    
  }
}
