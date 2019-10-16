
class Alien{
  int xVal;
  int yVal;
  int type; // type = (0, 1, 2)
  int moveMax;
  int moveCount;
  boolean moveRight;
  boolean live;
  
  Alien(int _xVal, int _yVal, int _type){
    xVal = _xVal;
    yVal = _yVal;
    type = _type;
    moveMax = COLUMN_NUM - ALIEN_NUM; // how many times should i move in one direction?
    moveCount = 0;
    moveRight = true;
    live = true;
  }
  
  void display(){
    
    // check whether got shot or not
    if(gotShot()) {
      live = false;
      soundfile1.amp(0.1);
      soundfile1.play();
    }
    
    // update position
    update();
    
    // display image
    // display only living aliens
    noStroke();
    float x = dot_diameter*(xVal+0.5);
    float y = dot_diameter*(yVal+0.5);
    if(live){
      shoot();
      switch(type){  
        case 0: {
          image(invader1, x, y, dot_diameter*0.8, dot_diameter*0.8);
          break;
        }
        case 1: {
          image(invader2, x, y, dot_diameter*0.8, dot_diameter*0.8);
          break;
        }
        case 2: {
          image(invader3, x, y, dot_diameter*0.8, dot_diameter*0.8);
          break;
        }
        default:{
          fill(255, 255, 0); 
          circle(x, y, dot_diameter*0.8);
          break;
        }
      }
    }
  }
  
  // got hit?
  boolean gotShot(){
    boolean shot = false;
    if(live){
      check: for(Bullet b: myBullets){
        if(b.xVal==this.xVal && b.yVal==this.yVal){
          shot = true;
          b.toDelete = true;
          break check;
        }
      }
    }
    return shot;
  }
  
  // aliens move along x- and y-axis
  void update(){
    if(frameCount%20==0){
      if (moveCount%(moveMax+1)==0){yVal++;}
      else if(moveRight)           {xVal++;}
      else                         {xVal--;}

      moveCount++;
      
      if(moveCount%(moveMax+1)==0 && moveRight){
        moveRight = false;
      }
      else if(moveCount%(moveMax+1)==0 && !moveRight){
        moveRight = true;
      }
    }
  }
  
  // aliens randomely shoot bullets
  void shoot(){
    float p = random(1);
    if(p<0.01){
      Bullet b = new Bullet(xVal, yVal, 1); // myBullets go upward along y-axis (that means veloc = -1)
      enemyShots.add(b);
    }
  }
}
