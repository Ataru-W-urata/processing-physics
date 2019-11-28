// See suplemental fig.6 ,table.1 and Supporting Text
// there's 12 genes coding gates, and 1 gene coding output

// each gate gene encoding information about 'input 1 address' and 'input 2 address'
// and output gene encoding only information about 'input address'

// genotype-phenotype mapping:
// (address code: Physical address) -> (0000: Input1), (0001: Input2), (0010: Input3), (0011: Input4)
//                                   (0100: Gate0), (0101: Gate1), (0110: Gate2), (0111: Gate3),
//                                   (1000: Gate4), (1001: Gate5), (1010: Gate6), (1011: Gate7),
//                                   (1100: Gate8), (1101: Gate9), (1110: Gate10), (1111: Gate11)

// genome size: (4+4)*12 + 4 = 100


class Genome{
  String genes;        // binary genes
  int G_SIZE = 100;
  
  // constructor
  Genome(){
    // init genome
    StringBuffer sb = new StringBuffer(); 
    for(int i=0; i<G_SIZE; i++){
      String base = String.valueOf(round(random(1)));
      sb.append(base);
    }
    genes = sb.toString();
  }
  
  // method
  void printGene(){
    println(genes);
  }
  
  void mutate(){
    
  }
}
