class Rule{
  // the function of the L_system has at least 4 elements
  // Variables, constants, axiom and rules
  // A > B[A]A
  // B > BB
  char v; // variables ("A" or "B")
  String s; // String which would be generated after replacement
  float d;
  float angle;
  
  // constructor
  Rule(char _v, String _s){
    v = _v;
    s = _s;
  }
  
  // rule for replacement
  void run(){
    s = s.replace("A", "D[C]C");
    s = s.replace("B", "DD");
  }
  
  void run2(){
    s = s.replace("C", "A");
    s = s.replace("D", "B");
  }
  
  // rule for draw
  void differentiate(float _d, float _angle){
    
    float d = _d;
    float angle = _angle;
    resetMatrix();
    translate(width/2, height);
    
    for(int i=0; i<s.length(); i++){
      char current = s.charAt(i);
      switch(current){
        // A: draw a line segment ending in a leaf
        case 'A': line(0, 0, 0, -d);
                  break;
        // [: push position and angle, turn left 45 degrees
        case '[': pushMatrix();
                  rotate(-angle);
                  break;
        // ]: pop position and angle, turn right 45 degrees
        case ']': popMatrix();
                  rotate(angle);
                  break;
        // B: draw a line segment
        case 'B': line(0, 0, 0, -d);
                  translate(0, -d);
                  break;
      }
    }
    
  }
}
