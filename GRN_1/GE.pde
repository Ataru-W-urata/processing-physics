// Gene expression
// expression level is described in a binary way, 0 or 1.
// Gene receives input information and,
// if input < _spTh, expression will be suppressed()

class Gene{
  int     ExpLev;                      // 0: not expressed, 1: expressed
  IntList ExpLevList;       
  float   acTh;                        // activation threshold
  float   spTh;                        // supression threshold
  int     outputVal;                   // output level, equals to ExpLev
  float   inputVal;                
  float   r;                           // radius of particle anime
  
  // constructor
  Gene(int init, float _spTh, float _acTh){
    ExpLevList = new IntList();
    ExpLev = init;
    acTh = _acTh;
    spTh = _spTh;
    r = 0;
  }
  
  // update gene Exp level
  void update(float input){
    inputVal = input;
    
    if(input>acTh)      ExpLev = 1;
    else if(input<spTh) ExpLev = 0;
    
    // save values into list
    ExpLevList.insert(0,ExpLev);
    if(ExpLevList.size()>100){
      for(int n=100; n<ExpLevList.size(); n++){
        ExpLevList.remove(n);
      }
    }
    outputVal = ExpLev;
  }
  
  // display ExpLev as graph
  void disp_exp(float _x, float _y){
    push();
    stroke(250);
    strokeWeight(2);
    
    translate(_x, _y);
    line(0, 0, 0, -50);     // vertical
    line(0, 0, 100, 0);     // horizontal

    beginShape();
    noFill();
    for(int i=0; i<ExpLevList.size();i++){
      vertex(i, ExpLevList.get(i)*(-10)-20);
    }
    endShape();
    pop();
  }
  
  // display ExpLev as particle
  void disp_ptc(float _x, float _y){
    textFont(font);
    textAlign(CENTER, CENTER);
    
    push();
    fill(255);
    text("ExpLev: " + ExpLev + ", input: " + inputVal, _x, _y-30);
    
    noStroke();
    if(ExpLev == 1) {
      fill(10, 240, 240, 100);
      r = 20;
    }
    else{
      fill(10, 10, 10, 100);
      r = 15;
    }
    circle(_x, _y, r);
    pop();
  }
}
