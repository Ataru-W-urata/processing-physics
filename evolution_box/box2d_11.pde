import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import gifAnimation.*;
import java.util.Date;
import java.text.SimpleDateFormat;
import org.jbox2d.dynamics.contacts.*;


Box2DProcessing box2d;
GifMaker gifExport;

int lifecycle;
int lifetime;
int recordtime;
int pop_num = 10;

// for displaying the phylogenetic graph
int[][] dad_num = new int[10][pop_num];  // generation * num
int[][] mom_num = new int[10][pop_num];

// object
Population population;
Surface surface;

void setup(){
  frameRate(60);
  size(400, 300);
  // RGB strength is mapped under 1.0
  colorMode(RGB, 1.0);
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  population = new Population(0.1, pop_num);
  surface = new Surface();  
 
  gifExport = new GifMaker(this, "crawl" + timestamp() + ".gif");
}

void draw(){
  box2d.step();
  background(0.9);
  
  int FittestNum = population.getFittestNum();
  Vec2 pos = population.population[FittestNum].box.returnPosition();
  pos.y = 100; // fix the y-axis

  
  // landscape
  int r1, r2;
  for(int x= -10; x<width*3; x+=50){
    // sky
    r1 = 10;
    for(int y=0; y<300; y+=40){
      strokeWeight(0.2);
      stroke(0, 0.1, 1, 1);
      fill(0, 0.1, 1, 0.5);
      ellipse(x-pos.x, y-pos.y, r1, r1);
      r1--;
    }
    // land
    r2 = 4;
    for(int y=360; y<800; y+=50){
      strokeWeight(0.2);
      stroke(0, 1, 0.1, 1);
      fill(0, 1, 0.1, 0.5);
      ellipse(x-pos.x, y-pos.y, r2, r2);
      r2++;
    }
  }
  
  // display population
  population.fitness();
  population.display(pos);
  
  // Display some info
  int generation = population.getGenerations();
  fill(0);
  text("Generation #: " + generation, 10, 18);
  
  
  for(int i=0; i<generation+1; i++){
    for(int j=0; j<pop_num; j++){
      text(j, 40*i+20, 15*j+35);
    }
  }
  // draw the phylogeny

  for(int j=0; j<pop_num; j++){
    dad_num[generation][j] = population.population[j].dad_num;
    mom_num[generation][j] = population.population[j].mom_num;
  }
  // draw the phylogeny
  for(int i=1; i<generation+1; i++){
    for(int j=0; j<pop_num; j++){
      stroke(1,0,0, 0.5);
      line(40*(i-1)+20, 15*dad_num[i][j]+35, 40*i+20, 15*j+35);
      stroke(0,0,1, 0.5);
      line(40*(i-1)+20, 15*mom_num[i][j]+35, 40*i+20, 15*j+35);
    }
  }
  
  
  if(frameCount%10==0){
    gifExport.addFrame();
  }
  
  if(frameCount%800==0){
    population.fitness();
    population.selection();
    population.reproduction();
  }
  
  if(frameCount%8000==0){
    gifExport.finish();
    noLoop();
    println("end");
  }
  
  
}

String timestamp(){
  Date date = new Date();
  SimpleDateFormat sdf = new SimpleDateFormat("yyMMdd-HHmm");
  return sdf.format(date);
}

void mouseClicked(){
  noLoop();
}
