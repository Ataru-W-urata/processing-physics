class Box{
  // We need to keep track of a body and a width and height
  Body body;
  float w;
  float h;
  float red, green, blue;
  color c;
  
  // constructor
  Box(float x, float y, float _w, float _h, boolean lock, color _c){
    w = _w;
    h = _h;
    c = _c;
    // Define the body
    BodyDef bd = new BodyDef();
    // position
    bd.position = box2d.coordPixelsToWorld(new Vec2(x, y));
    // type
    if(lock) bd.type = BodyType.STATIC;
    else bd.type = BodyType.DYNAMIC;
    // create body
    body = box2d.world.createBody(bd);
    
    // Define the shape
    PolygonShape ps = new PolygonShape();
    //width and height
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    ps.setAsBox(box2dW, box2dH);
    
    // Define the fixture
    FixtureDef fd = new FixtureDef();
    // shape
    fd.shape = ps;
    // parameters that affect physics
    fd.density = 2;
    fd.friction = 1;
    fd.restitution = 0.5;
    // if group index of filter is negative value, the same group never collide
    fd.filter.groupIndex = -2;
    
    body.createFixture(fd);
    
    // set initial velocity
    body.setLinearVelocity(new Vec2(0, 0));
    body.setAngularVelocity(0);
  }
  
  void display(Vec2 cen_pos){
    // position
    Vec2 pos = box2d.getBodyPixelCoord(body); 
    Vec2 tra_pos = pos.sub(cen_pos);
    //get angle
    float a = body.getAngle();
    
    rectMode(PConstants.CENTER);
    pushMatrix();
    translate(width/2, height/2);
    pushMatrix();
      translate(tra_pos.x, tra_pos.y);
      rotate(-a);
      fill(c, 0.2);
      stroke(c);
      strokeWeight(2);
      rect(0, 0, w, h);
      popMatrix();
    popMatrix();
  }
  
  // function that returns position of the box
  Vec2 returnPosition(){
    Vec2 pos = box2d.getBodyPixelCoord(body);
    return pos;
  }
}
