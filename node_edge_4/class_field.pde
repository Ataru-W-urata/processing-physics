class field{
  PVector center;        // position of center
  float rad;             // radius
  // constructor
  field(float x, float y, float _rad){
    center = new PVector(0, 0);
    center.x = x;
    center.y = y;
    rad = _rad;
  }
  // function to display
  void display_field(){
    circle(center.x, center.y, rad);
  }
}
