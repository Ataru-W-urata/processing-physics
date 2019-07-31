//##################################################
// GA with learing
// genome is composed of 3 kinds of genes
// '0', '1', '9'.
//##################################################

int pop_num = 1000; // number of population
Population p;
int[] fittest = {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}; // fittest genotype

// parameters for display graph
int generations;
int[] genotype = {0, 0, 0};
FloatList freq_0 = new FloatList();
FloatList freq_1 = new FloatList();
FloatList freq_9 = new FloatList();

void setup(){
  frameRate(3);
  size(200, 100);
  colorMode(HSB, 360, 100, 100);
  background(0, 0, 100);
  generations = 0;
  p = new Population();
}

void draw(){
  background(0, 0, 100);
  generations = p.return_generation();
  println(generations);
  p.run();
  render_graph();
}

// function to display graph
void render_graph(){
  genotype = p.gene_freqs;
  float total_num = 20 * pop_num;
  float rat_0 = map(genotype[0], 0, total_num, 0, height);
  float rat_1 = map(genotype[1], 0, total_num, 0, height);
  float rat_9 = map(genotype[2], 0, total_num, 0, height);
  println(rat_0 + ":" + rat_1 + ":" + rat_9);
  
  freq_0.append(rat_0);
  freq_1.append(rat_0+rat_1);
  freq_9.append(rat_0+rat_1+rat_9);
  
  strokeWeight(0.5);
  fill(0, 50, 100, 80);
  beginShape();
  vertex(0, 0);
  vertex(0, freq_9.get(0));
  for(int i=0; i<freq_9.size();i++) vertex((i+1)*width/freq_9.size(), freq_9.get(i));
  vertex(width, 0);
  endShape();
    
  fill(100, 50, 100, 80);
  beginShape();
  vertex(0, 0);
  vertex(0, freq_1.get(0));
  for(int i=0; i<freq_1.size();i++) vertex((i+1)*width/freq_1.size(), freq_1.get(i));
  vertex(width, 0);
  endShape();
  
  fill(200, 50, 100, 80);
  beginShape();
  vertex(0, 0);
  vertex(0, freq_0.get(0));
  for(int i=0; i<freq_0.size();i++) vertex((i+1)*width/freq_0.size(), freq_0.get(i));
  vertex(width, 0);
  endShape();
}

void keyPressed(){
  noLoop();
}
