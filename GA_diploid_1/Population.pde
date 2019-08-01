class Population{
  Creature[] creatures;
  int[] gene_freqs;
  ArrayList<Creature> male_Pool;
  ArrayList<Creature> female_Pool;
  int generations;
  
  // constructor
  Population(){
    creatures = new Creature[pop_num];
    gene_freqs = new int[3];
    male_Pool =  new ArrayList<Creature>();
    female_Pool = new ArrayList<Creature>();
    generations = 0;
    
    // make new Creatures
    for(int n=0; n<creatures.length; n++){
      creatures[n] = new Creature();
    }
  }
  
  // do under functions in one generation
  void run(){
    run_generation();
    selection();
    reproduction();
    
  }
  
  // do learning for each generation
  void run_generation(){
    for(int i=0; i<3; i++) gene_freqs[i] = 0; // init gene freq
    for(int n=0; n<creatures.length; n++){
      creatures[n].learn();
      int[] freqs = creatures[n].count_genotype();
      for(int i=0; i<3; i++){
        gene_freqs[i] += freqs[i];
      }
    }
    println(gene_freqs);
  }
  
  // generate mating pools according to fitness
  void selection(){
    male_Pool.clear();
    female_Pool.clear();
    for(int n=0; n<creatures.length; n++){
      int fitness = round(creatures[n].calc_fitness());
      for(int j=0; j<fitness; j++){
        if(creatures[n].y_chrom==0) female_Pool.add(creatures[n]); // female
        else                        male_Pool.add(creatures[n]);   // male
      }
    }
  }
  
  // choose parent, make germ_line cells, and reprodction
  void reproduction(){
    for(int n=0; n<creatures.length; n++){
      int m = round(random(1, female_Pool.size()))-1;
      int d = round(random(1, male_Pool.size()))-1;     
      // Pick Parents
      Creature mom = female_Pool.get(m);
      Creature dad = male_Pool.get(d);
      // for each creature, crossover gene and make germ_line
      Chromosome[] mom_set = mom.chrom1.crossover(mom.chrom2);
      Chromosome[] dad_set = dad.chrom1.crossover(dad.chrom2);
      // choose chrom set to heritage
      int mc = round(random(1)); // 0 or 1
      int dc = round(random(1));
      // make new Creature
      creatures[n] = new Creature(mom_set[mc], dad_set[dc]);
    }
    generations ++;
  }
  
  // return generations
  int return_generation(){
    return generations;
  }
}
