class Population{
  float mutationRate;        // mutation rate
  Car[] population;                // current population
  ArrayList<DNA> matingPool; // Arraylist which we will use for our "mating Pool"
  int generations;           // Number of generations
  
  // constructor
  // initialize the population
  Population(float m, int num){
    mutationRate = m;
    population = new Car[num];
    matingPool = new ArrayList<DNA>();
    generations = 0;
    
    // make a new set of creatures
    for(int i=0; i<population.length; i++){
      population[i] = new Car(new DNA(), 40, 160, 0, 0);
      // record the number of the object into its genome
      population[i].dna.genes[20] = i;
    }
  }
  
  // calculate fitness for each creature
  void fitness(){
    for(int i=0; i<population.length; i++){
      population[i].fitness();
    }
  }
  
  // function highest fitness for the population
  float getMaxFitness(){
    float record = 0;
    for(int i=0; i<population.length; i++){
      if(population[i].getFitness() > record){
        record = population[i].getFitness();
      }
    }
    return record;
  }
  
  // generate a mating pool
  void selection(){
    // clear the Arrayist
    matingPool.clear();
    
    // calculate total fitness of whole population
    float maxFitness = getMaxFitness();
    
    for(int i=0; i<population.length; i++){
      float fitnessNormal = map(population[i].getFitness(), 0, maxFitness, 0, 1);
      int n = (int)(fitnessNormal * 100);
      for(int j=0; j<n; j++){
        matingPool.add(population[i].getDNA());
      }
    }
  }
  
  void reproduction(){
    // the fittest car in the previous generation will be
    // replicated in the next generation
    int fittestNum = getFittestNum();
    DNA fittestDNA = population[fittestNum].dna;
    population[0].killBody();
    population[0] = new Car(fittestDNA,40, 160, fittestNum, fittestNum);
    
    // Refill the population with children from the mating pool
    for(int i=1; i<population.length; i++){
      
      int m = int(random(matingPool.size()));
      int p = int(random(matingPool.size()));
      // pick parents
      DNA momgenes = matingPool.get(m);
      DNA dadgenes = matingPool.get(p);
      
      DNA child = momgenes.crossover(dadgenes);
      child.mutate(mutationRate);
      population[i].killBody();
      population[i] = new Car(child, 40, 160, (int)dadgenes.genes[20], (int)momgenes.genes[20]);
      // dad/momgenes.genes[20] restores data about the number of dad/mom
      population[i].dna.genes[20] = i;
      // stores its own number into its genome
    }
    generations ++;
  }
  
  int getGenerations(){
    return generations;
  }
  
  // returns Car with higher fitness
  int getFittestNum(){
    int fittestNum = 0;
    float record = 0;
    for(int i=0; i<population.length; i++){
      if(population[i].getFitness() > record){
        record = population[i].getFitness();
        fittestNum = i;
      }
    }
    return fittestNum;
  }
  
  void display(Vec2 pos){
    surface.display(pos);
    for(int i=0; i<population.length; i++){
      population[i].display(pos);
    } 
  }
}
