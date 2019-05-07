Circle newCircle(){
  float x = random(width);
  float y = random(height);
  
  boolean valid = true;
  for(Circle c : circles){
    float d = dist(x, y, c.x, c.y);
    if(d < c.r){
      valid = false;
      break;
    }
  }
  
  if(valid){
    return new Circle(x, y);
  } else {
    return null;
  }
}
