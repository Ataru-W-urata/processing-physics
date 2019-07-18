Cell[][] cells;
int num = 40;      // number of cell per each axis
int cell_w;        // width of each cell
int cell_h;        // height of each cell
float prob = 0.6;  // probability

void setup(){
  size(200, 200);
  colorMode(HSB, 360, 100, 100, 100);
  cell_w = ceil(width/num);
  cell_h = ceil(height/num);
  cells = new Cell[num][num];
  for(int i=0; i<num; i++){
    for(int j=0; j<num; j++){
      cells[i][j] = new Cell((i+0.5)*cell_w, (j+0.5)*cell_h, i, j);
      // roll a dice
      cells[i][j].init();
    }
  }
}

void draw(){
  background(200, 2, 90, 100);
  updateCell();
  runCell();
  checkCell();
}

// function to display cells
// Exist: black, not Exist: white, 
// not Exist & percolated: blue
void runCell(){
  for(int i=0; i<num; i++){
    for(int j=0; j<num; j++){
      cells[i][j].display();
    }
  }
}


// function to do percolate
// if cell is precolated and
// adjacent cell is not exist,
// the adjacent one will also percolated...

void updateCell(){
  for(int i=0; i<num; i++){
    for(int j=0; j<num; j++){
      if(cells[i][j].IsPerco && !cells[i][j].IsExist){
        if(i>0)     cells[i-1][j].IsPerco = true;
        if(i<num-1) cells[i+1][j].IsPerco = true;
        if(j>0)     cells[i][j-1].IsPerco = true;
        if(j<num-1) cells[i][j+1].IsPerco = true;
      }
    }
  }
}

void checkCell(){
  for(int j=0; j<num; j++){
    if(cells[num-1][j].IsPerco){
      println("Percolated");
      noLoop();
    }
  }
}
