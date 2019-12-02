class Gene{
  int[] genes;           // genetic sequence, selected from (0, 1, 9)
  int freq_0;            // frequency of genotype '0' in genome
  int freq_1;
  int freq_9;
  int[] freqs = {0, 0, 0};
   
  // constructor: init
  Gene(){
    freq_0 = freq_1 = freq_9 = 0;
    genes = new int[20];
    for(int i=0; i<genes.length; i++){
      int g;
      float prob = random(1);
      if(prob<0.5)                  g = 9;
      else if(prob>=0.5&&prob<0.75) g = 0;
      else                          g = 1;
      genes[i] = g;
    }
  }
  
  // constructor: new generation
  Gene(int[] new_genes){
    freq_0 = freq_1 = freq_9 = 0;
    genes = new_genes;
  }
  
  
  // render_genotype: render 9 into 0 or 1 randomely (50%)
  void render_genotype(){
    for(int i=0; i<genes.length; i++){
      if(genes[i]==9){
        float j = random(1);
        if(j<0.5) genes[i] = 0;
        else      genes[i] = 1;
      }
    }
  }
 
  // count genotype
  int[] count_genotype(){
    freq_0 = freq_1 = freq_9 = 0;    
    for(int i=0; i<genes.length; i++){
      if(genes[i]==0)      freq_0++;
      else if(genes[i]==1) freq_1++;
      else if(genes[i]==9) freq_9++;
    }
    freqs[0] = freq_0;
    freqs[1] = freq_1;
    freqs[2] = freq_9;
    //println("1: "+freq_1+" 0: "+freq_0+" 9: "+freq_9);
    //println(freqs);
    return freqs;
  }
  
  // crossover
  Gene crossover(Gene partner){
    int[] child = new int[genes.length];
    int crossover1 = int(random(genes.length-1));          // double point crossover
    int crossover2 = int(random(crossover1,genes.length));
    for(int i=0; i<genes.length; i++){
      if(i>=crossover1 && i<crossover2){child[i] = partner.genes[i];}
      else {child[i] = genes[i];}
    }
    Gene new_genes = new Gene(child);
    return new_genes;
  }
}
