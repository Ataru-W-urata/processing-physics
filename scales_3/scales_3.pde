//##############################################################################
// graphical expression of musical notes and scales
// A = 432Hz ?
//##############################################################################

PFont font, font2;
float rad = 40;                           // radius for polygon  

int scaleNum;
String[] notes = {"C","Cs","D","Ds","E","F","Fs","G","Gs","A","As","B"}; 
String first_note = "C";

keys k;
CheckBox c;

void setup(){
  colorMode(HSB, 360, 100, 100, 100);
  size(400, 200);
  
  // font
  font = loadFont("Apple-Chancery-20.vlw");
  font2 = loadFont("Apple-Chancery-15.vlw");
  
  // keys
  c = new CheckBox(10, 40);
  k = new keys(first_note);
}


void draw(){
  fill(0);
  background(0, 0, 90);
  scaleNum = c.return_BtnVal();         // type of scale: penta? hepta? or else.
  write_title();
  display_dodecagon(width/5, height/2+20);
  k.run(170, height/2);
  c.run();
}



// functions

// title
void write_title(){
  textFont(font);
  textAlign(CENTER);
  text("Geometry corresponds to scales", width/2, 20);    
}

// function to display left-half indicator
void display_dodecagon(float _x, float _y){  
  push();
  noFill();
  translate(_x, _y);
  
  // circle
  stroke(100, 10, 50, 80);
  circle(0, 0, rad*2);
    
  // alphabet
  textFont(font2);
  textAlign(CENTER, CENTER);
  for(int i=0; i<12; i++){
    text(notes[i], (rad+10)*cos(radians(30*i-90)), (rad+10)*sin(radians(30*i-90)));
  }
  
  // polygon
  stroke(200, 100, 50, 80);
  beginShape();
  for(int i=0; i<12; i++){
    if(scales[scaleNum][i]==1){
      vertex(rad*cos(radians(30*i-90)), rad*sin(radians(30*i-90)));
    }
  }
  endShape(CLOSE);
  pop();
}
