class Particle{
  // We need to keep track of a body and a radius
  Body body;
  float r;
  
  // constructor
  Particle(float x, float y, float _r){
    r = _r;
    makeBody(x, y, r);
  }
  
  // function that make body
  void makeBody(float x, float y, float r){
    
    // Define the body
    BodyDef bd = new BodyDef();
    // position
    bd.position = box2d.coordPixelsToWorld(x, y);
    // type
    bd.type = BodyType.DYNAMIC;
    // create
    body = box2d.world.createBody(bd);
    
    // Define shape
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r);
    
    // Definr Fixture
    FixtureDef fd = new FixtureDef();
    // shape
    fd.shape = cs;
    // properties that affect physics
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.1;
    
    body.createFixture(fd);
    
    // Give it a random initial velocity
    body.setLinearVelocity(new Vec2(random(-10f, 10f), random(5f, 10f)));
    body.setAngularVelocity(random(-10, 10));
  }
  
  void display(Vec2 cen_pos){
    // position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    Vec2 tra_pos = pos.sub(cen_pos);
    // angle
    float a  = body.getAngle();
    
    pushMatrix();
    translate(width/2, height/2);
    rotate(0);
    fill(10, 200, 50, 100);
    stroke(0);
      pushMatrix();
      translate(tra_pos.x, tra_pos.y);
      rotate(-a);
      ellipse(0, 0, r*2, r*2);
      line(0, 0, r, 0);
      popMatrix();
    popMatrix();
  }
  
}
