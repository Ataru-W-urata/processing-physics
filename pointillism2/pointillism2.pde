// pointillism

import gifAnimation.*;
GifMaker gifExport;
import java.util.Date;
import java.text.SimpleDateFormat;

int period1, period2;             // period of wave1, wave2
int num = 300;                    // number of point draw at edge
int r;                            // basic radius
float r_delta = 25;               // density of point
float alpha;

float ratio;                      // ratio of two waves 0<ratio<1
boolean isRatioIncreasing;

boolean isEdge;                   // if point is not at the edge                  
                                  // the position of point would be randomize a bit
void setup(){
  
  frameRate(12);
  size(400, 300);
  background(255);
  
  gifExport = new GifMaker(this, "pointilism" + timestamp() + ".gif");
  
  ratio = 0;
  alpha = 0;
  isRatioIncreasing = true;
  isEdge = true;  
}

void draw(){
  translate(width/2, height/2);   // translate matrix
  rotate(radians(alpha));
  background(255);
  period1 = 5;
  period2 = 7;
  num = 300;
  
  isEdge = true;                  // draw edge first
  
  
  for(r=100; r>60; r-=5){
    
    for(int i=0; i<num; i++){
      float radius1 = r + r_delta * sin(TWO_PI * period1 * i/num);
      float radius2 = r + r_delta * sin(TWO_PI * period2 * i/num);
      float radius = (radius1 * ratio) + (radius2 * (1-ratio));
      float x =  radius * cos(TWO_PI * i/num);
      float y =  radius * sin(TWO_PI * i/num);
      
      // is point at Edge or not?
      if(!isEdge){
        x = x + 2*(noise(x)-0.5); // -1 ~ 1
        y = y + 2*(noise(x+y)-0.5);
      }
      
      strokeWeight(2);
      point(x,y);
    }    
    num -= 50;
    isEdge = false;
  }
  
  alpha += 1;
  
  // alter ratio
  if(isRatioIncreasing){
    ratio += 1.0/20;
    if(ratio>1){
      ratio = 1.0;
      isRatioIncreasing = false;
    }
  }
  else if(!isRatioIncreasing){
    ratio -= 1.0/20;
    if(ratio<0){
      ratio = 0.0;
      isRatioIncreasing = true;
    }
  }
  gifExport.addFrame();
}

void mousePressed(){
  gifExport.finish();
  noLoop();
}

String timestamp(){
  Date date = new Date();
  SimpleDateFormat sdf = new SimpleDateFormat("yyMMdd-HHmm");
  return sdf.format(date);
}
