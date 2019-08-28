// save input text into JSON

ArrayList<String> saved_string;
String test  = "";
String saved = "";
boolean IsSaved;
JSONArray json;

float angle = -360.0/20;
PFont font;

void setup(){
  size(200,200);
  background(240);
  
  // check whether JSON file already exists
  String dataPath = sketchPath() + "/data/test.json";
  File f = dataFile(dataPath);
  boolean exist = f.isFile();
  if(exist) json = loadJSONArray("test.json");
  else      json = new JSONArray();
 
  font = loadFont("AppleBraille-15.vlw");
  textFont(font, 20);
  fill(0);
  
  saved_string = new ArrayList<String>();
  IsSaved = false;
}

void draw(){
  background(240);
  display_saved();
  display();
  saveJSON();
}

void keyPressed(){
  switch(key){
    case(ENTER):
      saved = test;
      test = "";
      IsSaved = true;
      break;
    case(' '): 
      test+='_'; 
       break;
    case(BACKSPACE): 
      if(test.length()>0) test=test.substring(0,test.length()-1); 
      break;
    default:
      boolean isAlph = (key>='a'&&key<='z' || key>='A'&&key<='Z');
      boolean isNum  = (key>='0'&&key<='9');
      if(isAlph||isNum) test+=key;
      break;
  }
}

void display(){
  if(test.length()==0){
    translate(0, height/2);
    fill(150);
    textSize(15);
    text("Type text and Enter", 10, 0);
  }
  else{
    translate(width/2, height/2);
    rotate(test.length()*0.2);
    for(int i=0; i<test.length(); i++){
      rotate(radians(angle));
      float r = 60 - 6*sqrt(i+1);
      fill(0);
      textSize(20-0.3*i);
      text(test.charAt(i), 0, r);
    }
  }
}

void display_saved(){
  push();
  translate(10, 0);
  for(String s: saved_string){
    translate(0, 12);
    fill(150);
    textSize(10);
    text(s, 0, 0);
  }
  pop();
}

void saveJSON(){
  if(IsSaved){
    println(saved);
    saved_string.add(saved);
    json.append(saved);
    saveJSONArray(json, "data/test.json");
  }
  IsSaved = false;
}
