//##############################################################
//
// strange attractors
// reference: http://mathworld.wolfram.com/StrangeAttractor.html
//
//##############################################################

// select one of coefficient values 

//String coF_Alph = "AMTMNQQXUYGA";
// String coF_Alph = "FIRCDERRPVLD";
String coF_Alph = "GLXOESFTTPSV";
// String coF_Alph = "HGUHDPHNSGOH";
// String coF_Alph = "LUFBBFISGJYS";
// String coF_Alph = "MDVAIDOYHYEA";
// String coF_Alph = "QFFVSLMJJGCR";
// String coF_Alph = "VBWNBDELYHUL";
// String coF_Alph = "CVQKGHQTPHTE";
// String coF_Alph = "GIIETPIQRRUL";
// String coF_Alph = "GXQSNSKEECTX";
// String coF_Alph = "ILIBVPKJWGRR";
// String coF_Alph = "MCRBIPOPHTBN";
// String coF_Alph = "ODGQCNXODNYA";
// String coF_Alph = "UWACXDQIGKHF";
// String coF_Alph = "WNCSLFLGIHGL";

float[] coF = new float[12];

float x, y, xx, yy;

void setup(){
  size(200, 200);
  background(5);
  blendMode(SCREEN);
  
  // alphabet corresponds to number. A=-1.2, B=-1.1, ... , Y=1.1, Z=1.2
  for(int i=0; i<coF.length; i++){
    coF[i] = ((int(coF_Alph.charAt(i)-'A'))- 12)/10.0;
    println(coF[i]);
  }
  
  // initial value = 0
  x=y=xx=yy=0;

}

void draw(){
  translate(width/2, height/2);
  update();
}


void update(){
  xx = coF[0] + coF[1]*x + coF[2]*x*x + coF[3]*x*y + coF[4]*y + coF[5]*y*y;
  yy = coF[6] + coF[7]*x + coF[8]*x*x + coF[9]*x*y + coF[10]*y + coF[11]*y*y;
  stroke(2, 200, 200);
  strokeWeight(1);
  point(80*xx, -80*yy);
  x = xx;
  y = yy;
}
