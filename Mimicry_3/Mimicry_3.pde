// J.R.G.Turner et al., 1984
// Mimicry and the Monte Carlo predetor:
// the palatability spectrum nad the origins of mimicry

// 4 population of prey: Solo, Nasty, Model and Mimic
// Solo: edible
// Nasty: not edible
// Model: not edible as Nasty
// Mimic: edible as Solo
// Model and Mimic have identical patterns

PFont font;
// rendering parameters
int ANIME_W = 200;
int ANIME_H = 400;
FloatList onSolo;
FloatList onNasty;
FloatList onModel;

// parameters
float EDIBILITY = 0.2;
float HUNGER_LEV = 0.5;
float FORGET_RATE = 0.98;

// Predetor
Predetor pac;

// Prey population
Prey[] pop;
int PREY_NUM = 50;
Prey victim; // selected prey
ArrayList<Prey> select_pool; // pop of non-selected
ArrayList<Prey> eaten_list;
ArrayList<Prey> not_eaten_list;

void setup(){
  frameRate(1);
  font = loadFont("SansSerif-48.vlw");
  textFont(font, 15);
  textAlign(CENTER, CENTER);
  size(400, 400);
  background(240);
  initPrey();
  initPac();
  dispPop();
}

void draw(){
  background(240);
  dispProb();
  selectPrey();
  dispPop();
  victim.runaway();
}

// initialize popualation of prey
void initPrey(){  
  pop = new Prey[PREY_NUM];
  select_pool = new ArrayList<Prey>();
  eaten_list = new ArrayList<Prey>();
  not_eaten_list = new ArrayList<Prey>();
  
  // generate population randomely
  for(int i=0; i<PREY_NUM; i++){
    float x =  (i%10+1)*ANIME_W/11;  // disp 10 preys in each row
    int y =  (i/10 + 1) * 20 + 20;
    
    PVector _pos = new PVector(x, y);
    int type = ceil(random(4)); // type : 1, 2, 3, 4
    switch(type){
      case 1: // Solo
        pop[i] = new Prey(_pos, 1, true);
        break;
      case 2: // Nasty
        pop[i] = new Prey(_pos, 2, false);
        break;
      case 3: // Model
        pop[i] = new Prey(_pos, 3, false);
        break;
      case 4: // Mimic
        pop[i] = new Prey(_pos, 3, true);
        break;
    }
    select_pool.add(pop[i]);
  }
}

// initialize Predetor
void initPac(){
  pac = new Predetor();
  onSolo = new FloatList();
  onNasty = new FloatList();
  onModel = new FloatList();
}

// display Preys and Predetor
void dispPop(){
  fill(0);
  text("Population", ANIME_W/2, 20);
  textFont(font, 14);
  text("Eaten", 50, ANIME_H*0.6);
  text("Not-Eaten", ANIME_W-50, ANIME_H*0.6);
  for(Prey p: pop){
    p.display();
  }
  pac.display();
}

// select victim from select_Pool
// and display in front of a predetor
void selectPrey(){
  int select_id = floor(random(select_pool.size()));
  if(select_pool.size()>0){
    victim = select_pool.get(select_id);
    select_pool.remove(select_id);
    
    victim.selected();   // selected = true;
    victim.FaceToPred(); // inFront = true;  
    
    eatAndLearn(victim);
  }
}

// pac: eat prey and learn
void eatAndLearn(Prey _victim){
    pac.Learn(_victim);
    
    // eaten? or not-eaten?
    // add victim into eaten and not-eaten lists
    if(_victim.eaten){
      eaten_list.add(_victim);
      int i = eaten_list.size()-1;
      float x = (i%4+1) * ANIME_W/10;
      float y = (i/4 + 1) * 20 + ANIME_H*0.6;
      _victim.setSubPos(x, y);
    } else {
      not_eaten_list.add(_victim);
      int i = not_eaten_list.size()-1;
      float x = (i%4+1) * ANIME_W/10 + ANIME_W/2;
      float y =  (i/4 + 1) * 20 + ANIME_H*0.6;
      _victim.setSubPos(x, y);
    }
}

// display probabilities
void dispProb(){
  
  // display digit
  push();
  textAlign(LEFT, CENTER);
  textFont(font, 14);
  translate(ANIME_W + 10, 40);
  text("p on Solo", 0, 0);
  text(": " + nf(pac.attackOnSolo,1,3), 100, 0);
  text("p on Nasty", 0, 20);
  text(": " + nf(pac.attackOnNasty,1,3), 100, 20);
  text("p on Model", 0, 40);
  text(": " + nf(pac.attackOnModel,1,3), 100, 40);
  pop();
  
  // display graph 
  push();
  translate(ANIME_W + 10, ANIME_H/2 + 40);
  float y_max = -100;
  float x_max = ANIME_W - 30;
  line(0, 0, 0, y_max);
  line(0, 0, x_max, 0);
  
  float solo_map =  map(pac.attackOnSolo, 0, 1, 0, y_max);
  float nasty_map = map(pac.attackOnNasty, 0, 1, 0, y_max);
  float model_map = map(pac.attackOnModel, 0, 1, 0, y_max);
  onSolo.append(solo_map);
  onNasty.append(nasty_map);
  onModel.append(model_map);
  
  noFill();
  strokeWeight(2);
  // solo
  stroke(0, 0, 255);
  beginShape();
  vertex(0, onSolo.get(0));
  for(int i=0; i<onSolo.size(); i++){
    vertex((i+1)*x_max/onSolo.size(), onSolo.get(i));
  }
  endShape();
  // nasty
  stroke(255, 0, 0);
  beginShape();
  vertex(0, onNasty.get(0));
  for(int i=0; i<onNasty.size(); i++){
    vertex((i+1)*x_max/onNasty.size(), onNasty.get(i));
  }
  endShape();
  // Model and Mimic
  stroke(20);
  beginShape();
  vertex(0, onModel.get(0));
  for(int i=0; i<onModel.size(); i++){
    vertex((i+1)*x_max/onModel.size(), onModel.get(i));
  }
  endShape();
  
  pop();
}

void keyPressed(){
  switch(key){
    case ENTER:
      noLoop();
      break;
    case ' ':
      loop();
      break;
  }
}
