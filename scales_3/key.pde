class keys{
  String tonic;                                       // tonic = first note
  int[] current_scale;                                // which scale is chosen now?
  int[] key_place = {1,0,1,0,1,1,0,1,0,1,0,1};        // 1: white, 0: black
  int octave = 3;
  float freq;                                         // frequency
  float pos;                                          // position
  float key_width = 10;   
  float key_height = 50;
          
  // constructor
  keys(String _note){
    tonic = _note;
    current_scale = new int[12];
  }
  
  void run(float _x, float _y){
    update();
    display_keys(_x, _y);
  }
  
  void update(){
    current_scale = scales[scaleNum];
  }
  
  void display_keys(float _x, float _y){
    push();
    translate(_x, _y);
    stroke(0);
    strokeWeight(0.5);
    
    for(int i=0; i<12*octave; i++){  
      // white_keys
      if(key_place[i%12] == 1){
        if(current_scale[i%12]==1) fill(0, 50, 100, 50); // key is in scale
        else                       fill(0, 0, 100, 50);  // not in scale
        render_key(i);
      }
    }
    
    for(int i=0; i<12*octave; i++){
      // black_keys;
      if(key_place[i%12] == 0){ 
        if(current_scale[i%12]==1) fill(0, 60, 50, 100);    // key is in scale
        else                       fill(0, 0, 100, 100);  // not in scale
        render_key(i);
      }
    }
    pop();
  }
  
  // render key
  void render_key(int _i){
    int j = _i/12;
    if(_i%12==0) rect(key_width*(_i-5*j), 0, key_width-1, key_height);            // C
    if(_i%12==1) rect(key_width*(_i-0.5-5*j), 0, key_width*0.6, key_height*0.6);  // Cs
    if(_i%12==2) rect(key_width*(_i-1-5*j), 0, key_width-1, key_height);          // D
    if(_i%12==3) rect(key_width*(_i-1.5-5*j), 0, key_width*0.6, key_height*0.6);  // Ds
    if(_i%12==4) rect(key_width*(_i-2-5*j), 0, key_width-1, key_height);          // E
    if(_i%12==5) rect(key_width*(_i-2-5*j), 0, key_width-1, key_height);          // F
    if(_i%12==6) rect(key_width*(_i-2.5-5*j), 0, key_width*0.6, key_height*0.6);  // Fs
    if(_i%12==7) rect(key_width*(_i-3-5*j), 0, key_width-1, key_height);          // G
    if(_i%12==8) rect(key_width*(_i-3.5-5*j), 0, key_width*0.6, key_height*0.6);  // Gs
    if(_i%12==9) rect(key_width*(_i-4-5*j), 0, key_width-1, key_height);          // A
    if(_i%12==10) rect(key_width*(_i-4.5-5*j), 0, key_width*0.6, key_height*0.6); // As
    if(_i%12==11) rect(key_width*(_i-5-5*j), 0, key_width-1, key_height);         // B
  }
}
