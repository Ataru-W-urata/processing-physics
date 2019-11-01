class Predetor{
  
  PVector pos = new PVector(40, ANIME_H/2);
  int radius  = 30;
  boolean feelGood;
  boolean isEdible;
  // probabilities
  float attackOnSolo;
  float attackOnNasty;
  float attackOnModel;
  
  // constructor
  Predetor(){
    feelGood = true;
    isEdible = true;
    // initial probabilities equal to HUNGER LEVEL
    attackOnSolo  = HUNGER_LEV;
    attackOnNasty = HUNGER_LEV;
    attackOnModel = HUNGER_LEV;
  }
  
  // methods
  void Learn(Prey bug){
    float p = random(1);
    switch(bug.phenotype){
      case 1: // Solo
        if(p<attackOnSolo){
          isEdible = true;
          attackOnSolo = attackOnSolo*EDIBILITY + 0.8; // positive learning
          feelGood = true;
          bug.eaten();
        } else {
          isEdible = false;
        }
        break;
        
      case 2: // Nasty
        if(p<attackOnNasty){
          isEdible = true;
          attackOnNasty *= EDIBILITY; // negative learninig
          feelGood = false;
          bug.eaten();
        } else{
          isEdible = false;
        }
        break;
      case 3: // Model or Mimic
        if(p<attackOnModel){
          isEdible = true;
          if(bug.edible){
            attackOnModel = attackOnModel*EDIBILITY + 0.8; // positive learning
            feelGood = true;
          }
          else{
            attackOnModel *= EDIBILITY; // negative learning
            feelGood = false;
          }
          bug.eaten();
        }else{
          isEdible = false;
        }
        break;
    }
    attackOnSolo  = forget(attackOnSolo);
    attackOnNasty = forget(attackOnNasty);
    attackOnModel = forget(attackOnModel);
  }
  
  float forget(float _p){
    float new_prob = (_p-0.5)*FORGET_RATE+0.5;
    return new_prob;
  }
  
  // display
  void display(){
    push();
    translate(pos.x, pos.y);
    if(feelGood){fill(255, 255, 0);}
    else        {fill(100, 100, 255);}
    arc(0, 0, radius, radius, radians(30), radians(330), PIE);
    textAlign(CENTER, CENTER);
    fill(0);
    if(isEdible) {text("Yes!", 0, -25);}
    else         {text("No!", 0, -25);}
    pop();
  }
}
