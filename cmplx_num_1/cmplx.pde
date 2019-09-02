class cmplx{

  float re;
  float im;
  
  // constructor
  cmplx(float _re, float _im){
    re = _re;
    im = _im;
  }
  
  // output
  void output(){
    println(re, "+", im, "i");
  }  
  // sum
  cmplx add_c(cmplx _c){
    float n_re = this.re + _c.re;
    float n_im = this.im + _c.im;
    cmplx n = new cmplx(n_re, n_im);
    return n;
  }
  // subtraction
  cmplx sub_c(cmplx _c){
    float n_re = this.re - _c.re;
    float n_im = this.im - _c.im;
    cmplx n = new cmplx(n_re, n_im);
    return n;
  }
  // multiply
  cmplx mul_c(cmplx _c){
    float n_re = this.re * _c.re - (this.im * _c.im);
    float n_im = this.re * _c.im + this.im * _c.re;
    cmplx n = new cmplx(n_re, n_im);
    return n;
  }
  // division
  cmplx div_c(cmplx _c){
    float conjugate_im = -_c.im;
    cmplx conj = new cmplx(_c.re, conjugate_im);
    cmplx numr = this.mul_c(conj);
    cmplx denm = _c.mul_c(conj);
    float n_re = numr.re / denm.re;
    float n_im = numr.im / denm.re;
    cmplx n = new cmplx(n_re, n_im);
    return n;
  }
  
  // display
  void display(){
    line(0, 0, this.re * unit, -1 * this.im * unit);
    circle(this.re * unit, -1 * this.im * unit, 2);
  }
}
