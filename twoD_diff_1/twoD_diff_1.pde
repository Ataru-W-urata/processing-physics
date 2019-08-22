//#####################################
//
// continuous model of
// Fick's law of diffusion
//
//#####################################

float[][] conA;         // concentration of A
float[][] prev_conA;
float[][] Laplace;
float D = 0.2;        // Diffusion constant
float del_t = 0.5;      // delta_t

void setup(){
  size(200, 200);
  colorMode(HSB, 360, 1, 1, 1); // 0<S<1, 0<B<1
  background(0, 0, 95);
  
  conA      = new float[width][height];
  prev_conA = new float[width][height];
  Laplace   = new float[width][height];
  
  for(int i=0; i<width; i++){
    for(int j=0; j<height; j++){
      if(100<i && 120>i && 100<j && 120>j){
        conA[i][j] = 0.8;
      }
      else{
        conA[i][j] = 0;
      }
      prev_conA[i][j] = conA[i][j];
    }
  }
}

void draw(){
  background(0, 0, 95);
  strokeWeight(0.9);
  for(int i=1; i<width; i++){
    for(int j=0; j<height; j++){
      stroke(0, conA[i][j], 1, 0.8);
      point(i, j);
    }
  }
  update_conA(del_t);
}

float calc_derivative(float f, float f_plus, float del_x){
  float y = (f_plus - f)/del_x;
  return y;
}

float[][] calc_Laplacian(){
  float[][] Laplace = new float[width][height];
  float Nabla1, Nabla2, Nabla3, Nabla4, Laplac;
  for(int i=0; i<width; i++){
    for(int j=0; j<height; j++){
      if(i==0)        Nabla1 = 0; 
      else            Nabla1 = calc_derivative(prev_conA[i-1][j], prev_conA[i][j], 1);
      if(i==width-1)  Nabla2 = 0;
      else            Nabla2 = calc_derivative(prev_conA[i][j], prev_conA[i+1][j], 1);
      if(j==0)        Nabla3 = 0;
      else            Nabla3 = calc_derivative(prev_conA[i][j-1], prev_conA[i][j], 1);
      if(j==height-1) Nabla4 = 0;
      else            Nabla4 = calc_derivative(prev_conA[i][j], prev_conA[i][j+1], 1);   
      
      Laplac = calc_derivative(Nabla1, Nabla2, 1) + calc_derivative(Nabla3, Nabla4, 1);
      Laplace[i][j] = Laplac;
    }
  }
  return Laplace;
}

void update_conA(float _del_t){
  Laplace = calc_Laplacian();
  for(int i=0; i<width; i++){
    for(int j=0; j<height; j++){
      conA[i][j] = (D * Laplace[i][j]) * _del_t + prev_conA[i][j];
      prev_conA[i][j] = conA[i][j];
    }
  }  
}
