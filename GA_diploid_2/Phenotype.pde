// each creature has a set of 2 chromosomes, chrom1 and chrom2.
// Before mating, these 2 chroms make germline cells by crossing over.
// (Germline cells contains only 1 chromosome)

class Creature{
  int y_chrom;         // y_chrom=0: female, 1: male
  Chromosome chrom1;   // chrom1 (from parent1)
  Chromosome chrom2;   // chrom2 (from parent2)
  int[] learn1;        // chrom1 after learning
  int[] learn2;        // chrom2 after learning
  int learning_count;  // how many time did i try?
  int max_count = 1000;
  float fitness;       // 1<fitness<20;
  int[] geno_count = new int[3];
  
  // constructor1: init
  Creature(){
    y_chrom = round(random(1));
    chrom1 = new Chromosome();
    chrom2 = new Chromosome();
    learn1 = new int[chrom1.gene_len];
    learn2 = new int[chrom2.gene_len];
    learning_count = 0;
  }
  
  //constructor2: make naxt generation
  Creature(Chromosome _chrom1, Chromosome _chrom2){
    y_chrom = round(random(1));
    chrom1 = _chrom1;
    chrom2 = _chrom2;
    learn1 = new int[chrom1.gene_len];
    learn2 = new int[chrom2.gene_len];
    learning_count = 0;
  }
  
  // learning: render genotype 9 into 0 or 1.
  // learning occur 1-1000 times for both chroms
  // in every generations
  void learn(){
    learn: while(!is_fittest()){
      learning_count++;
      learn1 = chrom1.render_genotype();
      learn2 = chrom2.render_genotype();
      
      if(learning_count>max_count-1){       // break if learn occur 1000 times
        break learn;
      }
    }
  }
  
  // function used in Population selection
  // calc fitness according to fitness function
  float calc_fitness(){
    fitness = 1 + 19 * (1 - (1.0*learning_count)/max_count);
    return fitness;
  }
  
  // function used in displaying graph
  // count genotype
  int[] count_genotype(){
    int[] ch1 = chrom1.count_genotype();
    int[] ch2 = chrom2.count_genotype();
    for(int i=0; i<3; i++) geno_count[i] = ch1[i] + ch2[i];
    return geno_count;
  }
  
  // check whether phenotype is fittest or not
  // if learn1[i]!=fittest[i] and learn2[i]!=fittest[i],
  // (means both chroms are not fit), return false
  boolean is_fittest(){
    boolean fit_or_not = true;
    for(int i=0; i<chrom1.gene_len; i++){
      if(learn1[i]!=fittest[i] && learn2[i]!=fittest[i]){
        fit_or_not = false;
      }
    }
    return fit_or_not;
  }
}
