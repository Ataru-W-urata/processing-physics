//###################################################
// 
// GA with diploid and male/female system
// 
//###################################################
PFont font;

int pop_num = 1000; // number of population
Population p;
int[] fittest = {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}; // fittest genotype
int[] fittest_a = {1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0};
int[] fittest_b = {0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1};

// parameters for display graph
float graph_w;
float graph_h;
int generations;
int[] genotype = {0, 0, 0};
FloatList freq_0 = new FloatList();
FloatList freq_1 = new FloatList();
FloatList freq_9 = new FloatList();

void setup(){
  frameRate(3);
  size(400, 400); 
  graph_w = 0.8*width;                       // width of the graph
  graph_h = 0.5*width;                       // height of the graph
  colorMode(HSB, 360, 100, 100, 100);
  background(0, 0, 30);
  font = loadFont("GillSans-Light-15.vlw");
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
  //if(frameCount%20<10) fittest = fittest_a;
  //else fittest = fittest_b;
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
  float total_num = 20 * pop_num * 2;                       //  gene_length * total_num * polyploid
  float rat_0 = map(genotype[0], 0, total_num, 0, graph_h);
  float rat_1 = map(genotype[1], 0, total_num, 0, graph_h);
  float rat_9 = map(genotype[2], 0, total_num, 0, graph_h);
  println(rat_0 + ":" + rat_1 + ":" + rat_9);
  
  freq_0.append(rat_0);
  freq_1.append(rat_0+rat_1);
  freq_9.append(rat_0+rat_1+rat_9);
  
  push();
    translate(0.1*width, 0.1*height); // Upper-Left corner point of the graph
    stroke(200, 0, 100, 50);
    strokeWeight(0.5);
    fill(30, 100, 90, 100);
    //rectMode(CENTER);rect(width/2-120, 0.84*height-5, 10, 10);
    beginShape();
    vertex(0, 0);
    vertex(0, freq_9.get(0));
    for(int i=0; i<freq_9.size();i++) vertex((i+1)*graph_w/freq_9.size(), freq_9.get(i));
    vertex(graph_w, 0);
    endShape();
      
    fill(150, 100, 90, 100);
    //rectMode(CENTER);rect(width/2-120, 0.78*height-5, 10, 10);
    beginShape();
    vertex(0, 0);
    vertex(0, freq_1.get(0));
    for(int i=0; i<freq_1.size();i++) vertex((i+1)*graph_w/freq_1.size(), freq_1.get(i));
    vertex(graph_w, 0);
    endShape();
    
    fill(280, 100, 90, 100);
    //rectMode(CENTER);rect(width/2-120, 0.72*height-5, 10, 10);
    beginShape();
    vertex(0, 0);
    vertex(0, 0.1*height+freq_0.get(0));
    for(int i=0; i<freq_0.size();i++) vertex((i+1)*graph_w/freq_0.size(), freq_0.get(i));
    vertex(graph_w, 0);
    endShape();
 
    for(int i=0; i<freq_9.size();i++){
      stroke(0, 0, 100, 50);
      strokeWeight(1.5);
      line((i+1)*graph_w/freq_0.size(), 0 ,(i+1)*graph_w/freq_0.size(), graph_h);
    }
   pop();
  
  textFont(font, 15);
  fill(0, 0, 100);
  textAlign(CENTER);
  String s1 = "Generation: " + (generations+1);
  String s2 = "Frequency of Geneotype 0:  " + nf(genotype[0], 5); 
  String s3 = "Frequency of Geneotype 1:  " + nf(genotype[1], 5);
  String s4 = "Frequency of Geneotype 9:  " + nf(genotype[2], 5);
  text(s1, width/2, 0.6*height + 25);
  fill(280, 40, 90, 100);
  text(s2, width/2, 0.6*height + 50);
  fill(150, 40, 90, 100);
  text(s3, width/2, 0.6*height + 75);
  fill(30, 40, 90, 100);
  text(s4, width/2, 0.6*height + 100);
  
}

void keyPressed(){
  noLoop();
}

void mousePressed(){
  change_ecology();
}
