// discrete system

// should alien save as arrayList or just a list?

// TODO:
// add win/gameover window
// add more sounds


// state that controls window
int state; // 1: main window; 0: game over; 99: continue

// import sound and images
import processing.sound.*;
SoundFile soundfile1;

PImage invader1, invader2, invader3;

// property
int COLUMN_NUM = 20;
int dot_diameter;         

Vehicle V;                                              // Vehicle

int ALIEN_NUM  = 6;
int ALIEN_TYPE = 3;
ArrayList<Alien>martian;                                // Alien

ArrayList<Bullet>myBullets;                             // Bullets
ArrayList<Bullet>enemyShots;

void setup(){
  frameRate(12);
  size(400, 400);
  background(10);
  smooth();
  imageMode(CENTER);
  
  // state
  state = 1;
  
  // load files
  soundfile1 = new SoundFile(this, "howan.mp3");        // load mp3 file
  invader1 = loadImage("invaders_1.png");               // load png image
  invader2 = loadImage("invaders_2.png");
  invader3 = loadImage("invaders_3.png");
  
  dot_diameter = (int)width/COLUMN_NUM;
  
  // vehicle
  V = new Vehicle();
  
  // bullets
  myBullets = new ArrayList<Bullet>();
  enemyShots = new ArrayList<Bullet>();
  
  // aliens
  martian = new ArrayList<Alien>();
  for(int i=0; i<ALIEN_NUM; i++){
    for(int t=0; t<ALIEN_TYPE; t++){
      Alien a = new Alien(i, t, t);
      martian.add(a);
    }
  };
  
}

void draw(){
  switch(state){
    case 1:  display_main(); break;
    case 0:  displayOverMenu(); break;
    case 99: initMain(); state=1; break;
  }
}

void initMain(){
  V = new Vehicle();
  
  // bullets
  myBullets.clear();
  enemyShots.clear();
  
  // aliens
  martian.clear();
  for(int i=0; i<ALIEN_NUM; i++){
    for(int t=0; t<ALIEN_TYPE; t++){
      Alien a = new Alien(i, t, t);
      martian.add(a);
    }
  };
    
}

void display_main(){
  background(10);
  
  // display vehicle and bullets
  V.display();
  
  // display aliens
  for(int i=0; i<martian.size(); i++){
    martian.get(i).display();
  }
  
  // display mybullets
  for(Bullet b: myBullets){
    b.display();
  }
  if(myBullets.size()>COLUMN_NUM){
    myBullets.remove(0);  
  }
  for(int i=0; i<myBullets.size(); i++){
    Bullet b = myBullets.get(i);
    if(b.toDelete){
      myBullets.remove(i);
    }
  }
  
  // display enemyShots
  for(Bullet b: enemyShots){
    b.display();
  }
  if(enemyShots.size()>COLUMN_NUM){
    enemyShots.remove(0);  
  }
  for(int i=0; i<enemyShots.size(); i++){
    Bullet b = enemyShots.get(i);
    if(b.toDelete){
      enemyShots.remove(i);
    }
  }
}

void displayOverMenu(){
  background(255);
  if(keyPressed){
    state = 99;
  }
}

void keyPressed(){
  switch(keyCode){
    case 32: V.shoot();  break; // space
    case 37: V.move(37); break; // left
    case 39: V.move(39); break; // right
    case 48: state = 0;  break; // key = 0
    case 49: state = 1;  break; // key = 1 
  }
}
