class Population{
  Creature[] population;                     // current population
  int[] gene_freqs;                          // frequency of each genotype in population
  ArrayList<Creature> matingPool; 
  int generations;
  
  // constructor
  Population(){
    population = new Creature[pop_num];
    gene_freqs = new int[3];                          
    matingPool = new ArrayList<Creature>();
    generations = 0;
    
    // make a new set of creatures
    for(int i=0; i<population.length; i++){
      population[i] = new Creature();
    }
  }
 
  void run(){
    run_generation();
    selection();
    reproduction();
  }
  
  // do learning for each generation
  void run_generation(){
    for(int i=0; i<3; i++) gene_freqs[i] = 0; // init gene_freq
    for(int n=0; n<population.length; n++){
      population[n].run();
      int[] freqs = population[n].count_genotype();
      for(int i=0; i<3; i++){
        gene_freqs[i] += freqs[i];
      }      
    }
    println("max fitness: " + getMaxFitness());
  }
  
  // generate mating pool according to fitness
  void selection(){
    matingPool.clear();                      // clear list for each generation
    for(int n=0; n<population.length; n++){
      int fitness = round(population[n].calc_fitness());
      for(int j=0; j<fitness; j++){
        matingPool.add(population[n]);       // add creature * fitness times(1-20)
      }
    }
  }
  
  // choose parent, make next generation
  void reproduction(){
    for(int n=0; n<population.length; n++){  // do this for population.length times
      int m = round(random(1, matingPool.size()))-1;
      int d = round(random(1, matingPool.size()))-1;
      // pick parents
      Gene momgene = matingPool.get(m).gene;
      Gene dadgene = matingPool.get(d).gene;
      // crossover
      Gene child = momgene.crossover(dadgene);
      population[n] = new Creature(child);
    }
   generations ++; 
  }
  
  //function used in main program
  // return generation
  int return_generation(){
    return generations;
  }
  
  // function used in run_generation
  // function highest fitness for the population
  float getMaxFitness(){
    float record = 0;
    for(int n=0; n<population.length; n++){
      if(population[n].calc_fitness() > record){
        record = population[n].calc_fitness();
      }
    }
    return record;
  }
  
}
