class Surface{
  // We'll keep track of all of the surface points
  ArrayList<Vec2> surface;
  
  // constructor
  Surface(){
    surface = new ArrayList<Vec2>();
    
    float theta = 0;
    
    for (float x=width*2; x>-10; x-=5){
      float y = map(sin(theta), -1, 1, 180, 200);
      theta +=0.15;
      surface.add(new Vec2(x, y));
    }
    

    
    
    // put the surface in the world
    ChainShape chain = new ChainShape();
    
    Vec2[] vertices = new Vec2[surface.size()];
    for(int i=0; i<vertices.length; i++){
      vertices[i] = box2d.coordPixelsToWorld(surface.get(i));
    }
    
    chain.createChain(vertices, vertices.length);
    
    // Define body
    BodyDef bd = new BodyDef();
    Body body = box2d.world.createBody(bd);
    
    // Define fixture
    FixtureDef fd = new FixtureDef();
    // shape 
    fd.shape = chain;
    fd.friction = 1;
    body.createFixture(fd);
    
  }
  
  void display(Vec2 cen_pos){

    stroke(0);
    noFill();
    pushMatrix();
    translate(width/2, height/2);
    beginShape();
    for(Vec2 v: surface){
      Vec2 tra_pos = v.sub(cen_pos);
      vertex(tra_pos.x, tra_pos.y);
    }
    endShape();
    popMatrix();
  }
}
