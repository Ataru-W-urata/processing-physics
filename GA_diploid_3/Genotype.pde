// each chromosome has 3-type of genotypes,
// 0, 1 and 9.
// genotype 9 is kind of metastatic genotype and
// can be rendered into gentype 0 or 1 during learning phase.

class Chromosome{
  int gene_len = 20;
  int[] genes;          // original sequence; contains 0, 1, 9;
  int[] learned_genes;  // genes after learning; only contains 0, 1
  int freq_0;           // frequency of each genotype
  int freq_1;
  int freq_9;
  int[] freqs = {0,0,0};
  
  // constructor1: init
  Chromosome(){
    freq_0=freq_1=freq_9=0;
    
    // init gene. choose genotype under same probabilities
    genes = new int[gene_len]; 
    learned_genes = new int[gene_len];
    for(int i=0; i<genes.length; i++){
      int g = 0;
      float prob = random(1);
      if(prob<0.25)                  g = 0;
      else if(prob>=0.25&&prob<0.50) g = 1;
      else                           g = 9;
      genes[i] = g;
    }
    arrayCopy(genes, learned_genes); // copy genes -> learned_genes
  }
  
  // constructor2: make next generation
  // (use this constructor in function: crossover)
  Chromosome(int[] _new_genes){
    freq_0=freq_1=freq_9=0;
    genes = _new_genes;
    learned_genes = new int[gene_len];
    arrayCopy(genes, learned_genes);
  }
  
  // render genotype: render gType 9 into 0 or 1 of learned_genes.
  // render occur several times during 1 generation.
  // every time before the render, copy genes -> learned_genes. 
  // therefore, render process is time-independent.
  int[] render_genotype(){
    arrayCopy(genes, learned_genes);
    for(int i=0; i<genes.length; i++){
      if(learned_genes[i]==9){
        float prob = random(1);
        if(prob<0.5) learned_genes[i] = 0;
        else         learned_genes[i] = 1;
      }
    }
    return learned_genes;
  }
  
  // count each genotype in this chromosome
  // return list of freqency of each genotype
  int[] count_genotype(){
    for(int i=0; i<genes.length; i++){
      if(genes[i] == 0)      freq_0++;
      else if(genes[i] == 1) freq_1++;
      else                   freq_9++;
    }
    freqs[0] = freq_0;
    freqs[1] = freq_1;
    freqs[2] = freq_9;
        return freqs;
  }
  
  // crossover with pair chromosome (2-point cross)
  // and returns 2 next_generation chroms 
  Chromosome[] crossover(Chromosome _partner){
    int[] child1 = new int[genes.length];
    int[] child2 = new int[genes.length];
    int cross_point1 = int(random(genes.length-1));
    int cross_point2 = int(random(cross_point1, genes.length));
    // do dounble point cross over
    for(int i=0; i<genes.length; i++){
      if(i>=cross_point1&&i<cross_point2) {
        child1[i] = _partner.genes[i];
        child2[i] = this.genes[i];
      }
      else{
        child1[i] = this.genes[i];
        child2[i] = _partner.genes[i];
      }
    }
    Chromosome new_chrom1 = new Chromosome(child1); // use constructor2
    Chromosome new_chrom2 = new Chromosome(child2);
    Chromosome[] new_chroms = new Chromosome[2];    // list of chroms
    new_chroms[0] = new_chrom1;
    new_chroms[1] = new_chrom2;
    
    return new_chroms;
  }
}
