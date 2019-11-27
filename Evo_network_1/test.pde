// test code

// Gate and Output class
void testGateClass(){
  Gate gate = new Gate(1, "1101", "0100");
  // is binary -> int translation OK?
  assert gate.i1_address == 9 : "Gate class: input address error";
  assert gate.i2_address == 0  : "Gate class: input address error";
  // is NAND operation OK?
  assert gate.operate(true,true)==false   : "NAND operation error";
  assert gate.operate(false,true)==true   : "NAND operation error";
  assert gate.operate(true,false)==true   : "NAND operation error";
  assert gate.operate(false,false)==true  : "NAND operation error";
  // is binary -> int translation OK?  
  Output output = new Output("0001");
  assert output.i_address == -3: "Output class: input address error";
  println("Test of Gate_class end successfully");
}

// Genome class
void testGenomeClass(){
  Genome genome = new Genome();
  // Is gene length OK?
  assert genome.genes.length() == 100: "Genome class length error";
  println("Test of Genome_class end successfully");
}

// Circuit class
void testCircuitClass(){
  Circuit circuit = new Circuit();
  // Are gates generated successfully?
  for(int i=0; i<12; i++){
    assert circuit.gates[i].i1_address >= -4: "Circuit class: gate generation error";
    assert circuit.gates[i].i1_address <= 11: "Circuit class: gate generation error";
    assert circuit.gates[i].i2_address >= -4: "Circuit class: gate generation error";
    assert circuit.gates[i].i2_address <= 11: "Circuit class: gate generation error";
  }
  // Is output generated successfully?
  assert circuit.output.i_address >= -4: "Circuit class: output generation error";
  assert circuit.output.i_address <= 11: "Circuit class: output generation error";
  // Do BFS performed successfully?
  println("----------------------------------------------");
  println("OUTPUT ADDRESS: " + circuit.output.i_address);
  println("operation sequence: " + circuit.operation_sequence);
  if(circuit.output.i_address>=0){
    for(int i=0; i<circuit.operation_sequence.size(); i++){
      Gate g = circuit.gates[circuit.operation_sequence.get(i)];
      println("index: " + g.index + ", input1: " + g.i1_address + ", input2: " + g.i2_address);
    }
    println("Test of Circuit_class end successfully");
  }
}
