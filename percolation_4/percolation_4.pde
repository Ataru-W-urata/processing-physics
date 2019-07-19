//########################################################
// maker: Ataru-W-uratA
// Site percolation model
// condition: square lattice
// if percolation occurred or n-time trials conducted,
// simulation will be stoped.
// if mouse clicked, simulation re-starts.
// press Enter to save csv file.
//########################################################

Table table;         // save experimantal data into table

Cell[][] cells;
int num = 200;        // number of cell per each axis
int cell_w;          // width of each cell
int cell_h;          // height of each cell
float prob = 0.58;    // probability
int percolated;      // 0: not percolated, 1: percolated
int checkCount;      // how many times did I check?
int maxCount;        // how many times do I have to check?
boolean simFinish;   // Is simlation finished?
int totalSimCount;   // how many times did I run sim?

void setup(){
  table = new Table();
  table.addColumn("prob");
  table.addColumn("percolation state");
  
  size(200, 200);
  colorMode(HSB, 360, 100, 100, 100);
  totalSimCount = 0;
  maxCount = num;
  cell_w = ceil(width/num);
  cell_h = ceil(height/num);
  cells = new Cell[num][num];
  initCell();
}

void draw(){
  // do until percolation occur
  while(percolated==0){      
    background(200, 2, 90, 100);
    updateCell();
    runCell();
    checkCell();
    checkCount++;
    if(checkCount>maxCount){
      // if percolation do not occur within maxCount time trials
      simFinish = true;
      break;
    }
  }
  if(simFinish){
    totalSimCount++;
    if(totalSimCount == 10){
      prob+=0.01;
      totalSimCount = 0;
    }
    println("p: " + prob + ", " + totalSimCount + ": finish: percolation state is " + percolated);
    TableRow newRow = table.addRow();
    newRow.setFloat("prob", prob);
    newRow.setInt("percolation state", percolated);
    noLoop();
  }
}

void mousePressed(){
  loop();
  initCell();
}

void keyPressed(){
  switch(key){
    
    // save CSV
    case ENTER:
      saveTable(table, num + "_percolate.csv");
      
    // change probability value
    case ' ':
      prob += 0.01;
  }
}

// function to init cell
void initCell(){
  simFinish = false;          // simulation start
  percolated = 0;             // no percolation occurred
  checkCount = 0;             // init count
  for(int i=0; i<num; i++){
    for(int j=0; j<num; j++){
      cells[i][j] = new Cell((i+0.5)*cell_w, (j+0.5)*cell_h, i, j);
      // roll a dice
      cells[i][j].init();
    }
  }  
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
      percolated = 1;
      simFinish = true;         // finish Simulation
    }
  }
}
