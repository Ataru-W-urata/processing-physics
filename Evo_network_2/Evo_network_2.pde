//###########################################################################################
// Spontaneous evolution of modularity and network motifs
// Kashtan and Alon, PNAS, 2005

// Evolution of Electronic circuits (AND, OR, XOR)
// "modularly varying goals lead to the spontaneous evolution of modular network structure"

// The fittest phenotype is (I1 XOR I2) AND (I3 XOR I4)
// (I1, I2, I3, I4, output) 
// -> (t,t,t,t, f), (t,t,t,f, f), (t,t,f,t, f), (t,t,f,f, f)
//    (t,f,t,t, f), (t,f,t,f, t), (t,f,f,t, t), (t,f,f,f, f)
//    (f,t,t,t, f), (f,t,t,f, t), (f,t,f,t, t), (f,t,f,f, f)
//    (f,f,t,t, f), (f,f,t,f, f), (f,f,f,t, f), (f,f,f,f, f)
//###########################################################################################

// TODO: implement BFS in circuit class -> OK
// TODO: DO NAND OPERATION              -> OK
// TODO: implement evolutional process
// TODO: implement population class

boolean DEBUG_MODE = true;

Circuit c;
PFont font;

// primary inputs
boolean PI1 = true;
boolean PI2 = false;
boolean PI3 = true;
boolean PI4 = false;

void setup(){
  size(500, 200);
  background(255);
  font = loadFont("Serif-48.vlw");
  textFont(font, 18);
  textAlign(CENTER, CENTER);
}

void drawMain(){
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
