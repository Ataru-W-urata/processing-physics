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
  population = new Population(0.05, 6);
  surface = new Surface();  
 
  gifExport = new GifMaker(this, "crawl" + timestamp() + ".gif");
}

void draw(){
  box2d.step();
  background(0.9);
  
  Vec2 pos = population.getFittestCar().box.returnPosition();
  population.fitness();
  population.display(pos);
  
  // Display some info
  fill(0);
  text("Generation #: " + population.getGenerations(), 10, 18);
  if(frameCount%10==0){
    gifExport.addFrame();
  }
  
  if(frameCount%600==0){
    population.fitness();
    population.selection();
    population.reproduction();
  }
  
  if(frameCount%3000==0){
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
