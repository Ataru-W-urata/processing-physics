//##################################################
//
// GA with learing (Baldwin Effect)
// genome is composed of 3 kinds of genes
// '0', '1', '9'.
// GA contains only selection and crossover,
// and not contain mutation.
//
//##################################################
PFont font;

int pop_num = 1000; // number of population
Population p;
int[] fittest;
int[] fittest1 = {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}; // fittest genotype
int[] fittest2 = {1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0};
int[] fittest3 = {1,1,1,1,1,1,1,1,1,0,0,1,1,0,0,0,0,0,0,0};

// parameters for display graph
float graph_w;
float graph_h;
int generations;
int[] genotype = {0, 0, 0};
FloatList freq_0 = new FloatList();
FloatList freq_1 = new FloatList();
FloatList freq_9 = new FloatList();

void setup(){
  frameRate(24);
  size(400, 400); 
  graph_w = 0.8*width; 
  graph_h = 0.5*width;
  colorMode(HSB, 360, 100, 100, 100);
  background(0, 0, 30);
  font = loadFont("GillSans-Light-15.vlw");
  
  fittest = fittest1; 
  generations = 0;
  p = new Population();
}

void draw(){
  background(0, 0, 30);
  generations = p.return_generation();
  println(generations);
  p.run();
  render_graph();
  
  //if(frameCount%10==0) change_ecology();
}

// let's change fittest genotype
// (same with changing ecological value)
void change_ecology(){
  int i = round(random(1, 19)); 
  fittest[i] = round(random(1));
}

// function to display graph
void render_graph(){
  genotype = p.gene_freqs;
  float total_num = 20 * pop_num;
  float rat_0 = map(genotype[0], 0, total_num, 0, graph_h);
  float rat_1 = map(genotype[1], 0, total_num, 0, graph_h);
  float rat_9 = map(genotype[2], 0, total_num, 0, graph_h);
  
  freq_0.append(rat_0);
  freq_1.append(rat_0+rat_1);
  freq_9.append(rat_0+rat_1+rat_9);
  
  stroke(200, 0, 100, 50);
  strokeWeight(0.5);
  fill(30, 100, 90, 100);
  rectMode(CENTER);rect(width/2-120, 0.84*height-5, 10, 10);
  beginShape();
  vertex(0.1*width, 0.1*height);
  vertex(0.1*width, 0.1*height+freq_9.get(0));
  for(int i=0; i<freq_9.size();i++) vertex(0.1*width+(i+1)*graph_w/freq_9.size(), 0.1*height+freq_9.get(i));
  vertex(0.9*width, 0.1*height);
  endShape();
    
  fill(150, 100, 90, 100);
  rectMode(CENTER);rect(width/2-120, 0.78*height-5, 10, 10);
  beginShape();
  vertex(0.1*width, 0.1*height);
  vertex(0.1*width, 0.1*height+freq_1.get(0));
  for(int i=0; i<freq_1.size();i++) vertex(0.1*width+(i+1)*graph_w/freq_1.size(), 0.1*height+freq_1.get(i));
  vertex(0.9*width, 0.1*height);
  endShape();
  
  fill(280, 100, 90, 100);
  rectMode(CENTER);rect(width/2-120, 0.72*height-5, 10, 10);
  beginShape();
  vertex(0.1*width, 0.1*height);
  vertex(0.1*width, 0.1*height+freq_0.get(0));
  for(int i=0; i<freq_0.size();i++) vertex(0.1*width+(i+1)*graph_w/freq_0.size(), 0.1*height+freq_0.get(i));
  vertex(0.9*width, 0.1*height);
  endShape();
  
  for(int i=0; i<freq_9.size();i++){
    stroke(0, 0, 100, 50);
    strokeWeight(0.5);
    line(0.1*width+(i+1)*graph_w/freq_0.size(), 0.1*height ,0.1*width+(i+1)*graph_w/freq_0.size(), 0.1*height+graph_h);
  
  textFont(font, 15);
  fill(0, 0, 100);
  textAlign(CENTER);
  String s1 = "Generation: " + (generations+1);
  String s2 = "Frequency of Geneotype 0:  " + nf(genotype[0], 5); 
  String s3 = "Frequency of Geneotype 1:  " + nf(genotype[1], 5);
  String s4 = "Frequency of Geneotype 9:  " + nf(genotype[2], 5);
  text(s1, width/2, 0.65*height);
  text(s2, width/2, 0.72*height);
  text(s3, width/2, 0.78*height);
  text(s4, width/2, 0.84*height);
  
  
  }
}

void keyPressed(){
  noLoop();
}
