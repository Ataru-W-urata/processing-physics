// NAND Gate and simple output
// 2-input and 1-output
// possess information about input address

// Gates could have self inputs or two identical inputs.

class Gate{
  int index;                    // 0~11
  int i1_address, i2_address;   // select from Input1~4 and Gates 0~11
  
  // constructor
  Gate(int _i, String _i1, String _i2){       // _i1 and _i2 are binary data
    index = _i;
    i1_address = unbinary(_i1) - 4; // -4~11:
    i2_address = unbinary(_i2) - 4; // (address, input) -> (-4, Input1), (-3, Input2), (-2, Input3), (-1, Input4), (0, Gate0), ... , (11, Gate11)
  }
  
  // methods
  // Do NAND operation and return boolean
  boolean operate(boolean _b1, boolean _b2){  // _b1 and _b2 are boolean
    boolean result = true;                    // default_output: true
    if(_b1&&_b2==true){result = false;}
    else              {result = true;}
    return result;
  }
  
  // return upstream gates
  ArrayList<Gate> getInputAddress(Gate[] _gates){
    ArrayList<Gate>upstream = new ArrayList<Gate>();
    if(i1_address>=0) upstream.add(_gates[i1_address]);
    if(i2_address>=0) upstream.add(_gates[i2_address]);
    return upstream;
  }
}

class Output{
  int i_address;
  
  // constructor
  Output(String _in){
    i_address = unbinary(_in) - 4; // -4~11
  }
}
