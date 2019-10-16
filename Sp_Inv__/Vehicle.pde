

class Vehicle{
  int xVal;                // 0 <= xVal <= COLUMN_NUM-1
  int yVal = COLUMN_NUM-1;
  int life;
  
  // constructor
  Vehicle(){
    xVal = 0;
    life = 3;
  }
  
  void display(){
    noStroke();
    gotShot();
    switch(life){
      case 3: fill(0, 255, 0, 200); break;
      case 2: fill(0, 255, 0, 75);  break;
      case 1: fill(0, 255, 0, 50);  break;
      case 0: state = 0; break;
      default:fill(0, 255, 0, 100); break;
      
    }
    float x = dot_diameter*(xVal+0.5);
    float y = dot_diameter*(yVal+0.5);
    circle(x, y, dot_diameter*0.8);
    
  }
  
  void move(int k){
    if(k==37){ // left
      xVal--;
    }
    else if(k==39){ // right
      xVal++;
    }
    xVal = constrain(xVal, 0, COLUMN_NUM-1);
  }
  
  void shoot(){
    Bullet b = new Bullet(xVal, yVal, -1); // myBullets go upward along y-axis (that means veloc = -1)
    myBullets.add(b);
  }
  
  boolean gotShot(){
    boolean shot = false;
    if(life>0){
      check: for(Bullet b: enemyShots){
        if(b.xVal==this.xVal && b.yVal==this.yVal){
          shot = true;
          b.toDelete = true;
          life--;
          break check;
        }
      }
    }
    return shot;
  }
}
