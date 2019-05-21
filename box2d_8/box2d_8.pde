import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;

Box2DProcessing box2d;

int t = 0;
int number = 2;

// object
Car[] cars = new Car[number];
Surface surface;

void setup(){
 size(400, 300);
 box2d = new Box2DProcessing(this);
 box2d.createWorld();
 surface = new Surface();
 for(int i=0; i<number; i++){ 
   cars[i] = new Car(random(80,120), random(80,120));
 }
}

void draw(){
  box2d.step();
  
  background(255);
  
  Vec2 pos = cars[0].box.returnPosition();
  surface.display(pos);
  for(int i=0; i<number; i++){
    cars[i].display(pos);
  }
}

void mousePressed(){
  t++;
  if(t%2==0) noLoop();
  else loop();
}
