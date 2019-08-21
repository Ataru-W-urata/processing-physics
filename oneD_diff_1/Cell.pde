// cells      = Cell[cell_n]
// prev_cells = Cell[cell_n]
class Cell{
  int pos;        // positional information
  float A;        // concentration of molecule A
  float D;        // Diffusion constant;
  
  // constructor
  Cell(int _pos, float _A){
    pos = _pos;
    A = _A;
    D = 0.01;
  }
  
  // function to update concentration
  void update(){
    float flux = 0;
    
    if(pos==0){
      flux = -D*(this.A - prev_cells[pos+1].A)/2;
    }
    else if(pos==cell_n-1){
      flux = -D*(this.A - prev_cells[pos-1].A)/2;
    }
    if(pos!=0 && pos!=cell_n-1){
      float flux_l = -D*(this.A - prev_cells[pos-1].A)/2;
      float flux_r = -D*(this.A - prev_cells[pos+1].A)/2;
      flux = flux_l + flux_r;
    }
    this.A += flux; 
  }
}
