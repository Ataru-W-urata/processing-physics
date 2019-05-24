class DNA{
  
  // The genetic sequence
  float[] genes;
  int len = 20;
  
  // constructor
  DNA(){
    // DNA is random floating point values between 0 and 1
    genes = new float[len];
    for (int i=0; i<genes.length; i++){
      genes[i] = random(0, 1);
    }
  }
  
  DNA(float[] newgenes){
    genes = newgenes;
  }
  
  // function that crossover the parent genome
  DNA crossover(DNA partner){
    float[] child = new float[genes.length];
    int crossover1 = int(random(genes.length-1)); // double point crossover
    int crossover2 = int(random(crossover1,genes.length));
    for(int i=0; i<genes.length; i++){
      if(i>=crossover1 && i<crossover2){child[i] = partner.genes[i];}
      else {child[i] = genes[i];}
    }
    DNA newgenes = new DNA(child);
    return newgenes;
  }
  
  // mutation
  void mutate(float m){
    for(int i=0; i<genes.length; i++){
      if(random(1)<m){
        genes[i] = random(0, 1);
      }
    }
  }
}
