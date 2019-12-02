// note: array must be copied using arrayCopy method
// otherwise, shallow copy would happen

class Creature{
  
  Gene gene;                                    // before learning (contains 9)
  Gene learned_gene;                            // after learning (not contains 9)
  int max_learn_count = 1000;
  float learning_count;
  float fitness;
  
  // constructor: initialization
  Creature(){
    gene = new Gene(); 
    learned_gene = new Gene();
    arrayCopy(gene.genes,learned_gene.genes);   // copy original genetic sequence
    learning_count = 0;
  }
  
  // constructor: new generation
  Creature(Gene _gene){
    gene = _gene;
    learned_gene = new Gene();
    arrayCopy(gene.genes,learned_gene.genes);   // copy original genetic sequence
    learning_count = 0;
  }
  
  void run(){
    learn();
  }
  
  // learning
  void learn(){
    learn: while(!is_fittest()){                 // do while learned_gene != fittest      
      learning_count ++;
      arrayCopy(gene.genes,learned_gene.genes);  // keep original gene   
      learned_gene.render_genotype();            // render learned_gene
      if(learning_count>max_learn_count-1){      // do while max_learn_count times
        break learn;
      }
    }
  }
  
  // function used in Population selection()
  // calc fitness
  float calc_fitness(){
    fitness = 1 + 19 * (1 - learning_count/max_learn_count); // 1 < fitness < 20
    // println(fitness);
    return fitness;
  }
    
  // function used in Population run_generation()
  // count genotype, 0 or 1 or 9
  int[] count_genotype(){
    // println(gene.count_genotype());
    return gene.count_genotype();
  }
  
  // function used in this learn()
  // check whether gene is fittest
  boolean is_fittest(){
    boolean fit_or_not = true;
    for(int i=0; i<learned_gene.genes.length; i++){
      if(learned_gene.genes[i] != fittest[i]){
        fit_or_not = false;
      }
    }
    return fit_or_not;
  }  
}

 
