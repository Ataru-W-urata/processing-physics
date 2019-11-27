//###########################################################################################
// Spontaneous evolution of modularity and network motifs
// Kashtan and Alon, PNAS, 2005

// Evolution of Electronic circuits (AND, OR, XOR)
// "modularly varying goals lead to the spontaneous evolution of modular network structure"
//###########################################################################################

// TODO: implement BFS in circuit class -> OK
// TODO: DO NAND OPERATION
// TODO: implement evolutional process
// TODO: implement population class

boolean DEBUG_MODE = true;
Circuit c;

void setup(){
  size(200, 200);
  background(255);
}

void drawMain(){
  c = new Circuit();
  noLoop();
}

void draw(){  
  if(DEBUG_MODE){
    doAssertionTest();
  }
  else{
    drawMain();
  }
}

// test code
void doAssertionTest(){
  println("<< DEBUG_MODE >>");
  testGateClass();
  testGenomeClass();
  testCircuitClass();
  noLoop();
}
