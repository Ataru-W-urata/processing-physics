ArrayList<Circle> circles;


void setup(){
  background(10);
  size(640, 360);
  circles = new ArrayList<Circle>();  
  
}

void draw(){
  
  int total = 10;
  int count = 0;
  int attempts = 0;
  
  if(frameCount%20==0){
  while(count<total){
    Circle newC = newCircle();
    if(newC != null){
      circles.add(newC);
      count++;
    }
    attempts++;
    if(attempts > 1000){
      noLoop();
      break;
    }
  }
  }
  
  for (Circle c : circles){
    if(c.growing){
      if(c.edges()){
        c.growing = false;
      } else {
        for(Circle other : circles){
          if(c != other){
            float d = dist(c.x, c.y, other.x, other.y);
            if(d-2 < c.r + other.r){
              c.growing = false;
              float st = map(d, 0, 100, 0, 10);
              strokeWeight(st);
              stroke(200*noise(c.x), 200*noise(c.y), 200*noise(c.x+c.y));
              line(c.x, c.y, other.x, other.y);
              break;
            }
          }
        }
      }
    }
    noFill();
    c.show();
    c.grow();
  
  }
}
