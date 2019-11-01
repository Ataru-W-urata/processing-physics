// possible conditions
//(phenotype, edible) -> (1, true), (2, false), (3, false), (3, true)

class Prey{
  PVector pos;
  PVector sub_pos;
  int phenotype; // 1:Solo, 2:Nasty, 3:Model and Mimic
  boolean edible;
  boolean selected;
  boolean inFront;
  boolean eaten;
  
  // constructor
  Prey(PVector _pos, int _phenotype, boolean _edible){
    pos = _pos;
    sub_pos = new PVector(0, 0);
    phenotype = _phenotype;
    edible = _edible;
    selected = false;
    inFront = false;
    eaten = false;
  }
  
  // display
  void display(){
    push();
    rectMode(CENTER);
    strokeWeight(2);
    
    int alpha;
    if(selected)  {alpha = 63;}
    else          {alpha = 255;}
    
    color edge_col;
    if(edible) edge_col = color(0, 0, 255); // edible:    blue edge
    else       edge_col = color(255, 0, 0); // not-edible: red edge
    switch(phenotype){
      case 1:
        fill(250,alpha);
        stroke(edge_col, alpha);
        circle(pos.x, pos.y, 15);
        if(inFront){
          fill(250);
          stroke(edge_col);
          circle(120, ANIME_H/2, 25);
        }
        if(selected){
          fill(250);
          stroke(edge_col);
          circle(sub_pos.x, sub_pos.y, 15);
        }
        break;
      case 2:
        fill(200, alpha);
        push();
        translate(pos.x, pos.y);
        rotate(radians(45));
        stroke(edge_col, alpha);
        rect(0, 0, 12, 12);
        pop();
        if(inFront){
          fill(200);
          stroke(edge_col);
          push();
          translate(120, ANIME_H/2);
          rotate(radians(45));
          rect(0, 0, 22, 22);
          pop();
        }
        if(selected){
          push();
          translate(sub_pos.x, sub_pos.y);
          fill(200);
          stroke(edge_col);
          rotate(radians(45));
          rect(0, 0, 12, 12);
          pop();
        }
        break;
      case 3:
        fill(255, 255, 0, alpha);
        stroke(edge_col, alpha);
        rect(pos.x, pos.y, 14, 14);
        if(inFront){
          fill(255,255,0);
          stroke(edge_col);
          rect(120, ANIME_H/2, 24, 24);
        }
        if(selected){
          fill(255, 255, 0);
          stroke(edge_col);
          rect(sub_pos.x, sub_pos.y, 14, 14);
        }
        break;
      default:
        point(pos.x, pos.y);
    }
    pop();
  }
  
  void setSubPos(float _x, float _y){
    sub_pos = new PVector(_x, _y);
  }
  
  void selected(){
    selected = true;
  }
  
  void FaceToPred(){
    inFront = true;
  }
  
  void runaway(){
    inFront = false;
  }
    
  void eaten(){
    eaten = true;
  }
}
