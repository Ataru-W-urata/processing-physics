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
float[] f_list_copy;
ArrayList<float[]> f_array = new ArrayList<float[]>();         // list fore store fitness

void setup(){
  frameRate(3);
  size(400, 550); 
  graph_w = 0.8*width;                       // width of the graph
  graph_h = 0.4*width;                       // height of the graph
  colorMode(HSB, 360, 100, 100, 100);
  background(0, 0, 30);
  font = loadFont("GillSans-Light-15.vlw");
  generations = 0;
  p = new Population();
}

void draw(){
  background(0, 0, 30);
  generations = p.return_generation();
  // println(generations);
  p.run();
  render_P_graph();
  render_G_graph();
  
  if(frameCount%10==0) change_ecology();
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
void render_P_graph(){
  f_list_copy = new float[pop_num];
  arrayCopy(p.f_list, f_list_copy);
  f_array.add(f_list_copy);
  push();
    translate(0.1*width, 0.08*height);
    fill(0, 0, 40);
    rectMode(CORNER);
    noStroke();
    rect(0, 0, graph_w,graph_h);
    strokeWeight(2);
    stroke(0, 0, 90);
    line(0, graph_h, 0, 0+2);
    line(0, graph_h, graph_w-2, graph_h);
    
    // plot fitness vals
    strokeWeight(3);
    stroke(0, 0, 90, 40);
    for(int i=0; i<f_array.size(); i++){
      println(f_array.get(i)[1]);
      float x = (i+0.5) * (graph_w/(f_array.size()));
      for(int j=0; j<f_array.get(i).length; j++){     
        float y = map(f_array.get(i)[j],0, 20, graph_h, 10);
        point(x, y);
      }
    }  
  pop();
  
  textFont(font, 15);
  fill(0, 0, 100);
  textAlign(CENTER);
  String s = "Fitness";
  text(s, width/2, 0.06*height);
  
}



void render_G_graph(){
   
  genotype = p.gene_freqs;
  float total_num = 20 * pop_num * 2;                       //  gene_length * total_num * polyploid
  float rat_0 = map(genotype[0], 0, total_num, 0, graph_h);
  float rat_1 = map(genotype[1], 0, total_num, 0, graph_h);
  float rat_9 = map(genotype[2], 0, total_num, 0, graph_h);
  // println(rat_0 + ":" + rat_1 + ":" + rat_9);
  
  freq_0.append(rat_0);
  freq_1.append(rat_0+rat_1);
  freq_9.append(rat_0+rat_1+rat_9);
  
  push();
    translate(0.1*width, 0.45*height); // Upper-Left corner point of the graph
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
    vertex(0, freq_0.get(0));
    for(int i=0; i<freq_0.size();i++) vertex((i+1)*graph_w/freq_0.size(), freq_0.get(i));
    vertex(graph_w, 0);
    endShape();
 
    for(int i=0; i<freq_9.size();i++){
      stroke(0, 0, 100, 50);
      strokeWeight(1.5);
      line((i+1)*graph_w/freq_0.size(), 0 ,(i+1)*graph_w/freq_0.size(), graph_h);
    }
    strokeWeight(2);
    stroke(0, 0, 90);
    line(0, graph_h, 0, 0+2);
    line(0, graph_h, graph_w-2, graph_h);
   pop();
  
  textFont(font, 15);
  fill(0, 0, 100);
  textAlign(CENTER);
  String s = "Genotype";
  String s1 = "Generation: " + (generations+1);
  String s2 = "Frequency of Geneotype 0:  " + nf(genotype[0], 5); 
  String s3 = "Frequency of Geneotype 1:  " + nf(genotype[1], 5);
  String s4 = "Frequency of Geneotype 9:  " + nf(genotype[2], 5);
  text(s,  width/2, 0.43*height);
  text(s1, width/2, 0.6*height + 110);
  fill(280, 40, 90, 100);
  text(s2, width/2, 0.6*height + 135);
  fill(150, 40, 90, 100);
  text(s3, width/2, 0.6*height + 160);
  fill(30, 40, 90, 100);
  text(s4, width/2, 0.6*height + 185);
  
}

void keyPressed(){
  noLoop();
}

void mousePressed(){
  change_ecology();
}
