//##############################
//
// discrete cellular model of
// Fick's laws of diffusion
// flux J = -D(dc/dx)
//
//##############################

int   cell_n = 20;
float cell_w;

Cell[] cells;
Cell[] prev_cells; // store prev informaiton

void setup(){
  size(200, 200);
  colorMode(HSB, 360, 100, 100, 100);
  background(0, 0, 90);
  cell_w = (float)width/cell_n;
  // init cells
  cells = new Cell[cell_n];
  prev_cells = new Cell[cell_n];
  for (int i=0; i<cell_n; i++){
    cells[i] = new Cell(i, random(1));
    prev_cells[i] = new Cell(i, 0);
    prev_cells[i].A = cells[i].A;
  }
}

void draw(){
  background(0, 0, 90);
  display_cell();
  update_cell();
}

void update_cell(){
  // store info into prev_cell
  for(int i=0; i<cell_n; i++){
    cells[i].update();
  }
  for(int i=0; i<cell_n; i++){
    prev_cells[i].A = cells[i].A;
  }
}

void display_cell(){
  for(int i=0; i<cell_n; i++){
    float sat = map(cells[i].A, 0, 1, 0, 100);
    strokeWeight(0.5);
    fill(0, sat, 100, 100);
    rect(i*cell_w, 10, cell_w, cell_w*5);
  }
}

void mousePressed(){
  noLoop();
}
