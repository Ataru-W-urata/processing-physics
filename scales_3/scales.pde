// 0: not play, 1: play

int[][] scales = {
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, // no scale
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, // monotonic
  {1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0}, // ditonic
  {1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0}, // tritonic
  {1, 0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0}, // tetratonic
  {1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 0}, // pentatonic
  {1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0}, // hexatonic (prometheus)
  {1, 0, 1, 0, 1, 1, 0, 1, 0, 1, 0, 1}, // heptatonic
  {1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1}  // octatonic
};
