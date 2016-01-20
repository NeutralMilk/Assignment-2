class Comet extends GameObject
{
  float thetaDir;
  Comet()
  {
    super(random(0, width), random(0, height), 50);    
    c = 255;
    f = 0;
    forward.x = random(-1, 1);
    forward.y = random(-1, 1);
    forward.normalize();
    thetaDir = random(-0.01f, 0.01f);
  }
  
  // From the interface. This class won't compile unless it has this method  

  int sides = (int)random(3,10);
  int size = (int)random(10,40);
  void render()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(theta);    
    fill(f);
    stroke(c);
    strokeWeight(3);
    polygon(0, 0, size, sides); 
    popMatrix();
  }//end render()
  
  void polygon(float x, float y, float size, int sides) 
  {
    float angle = TWO_PI / sides;
    beginShape();
    for (float i = 0; i < TWO_PI; i += angle) {
      float sx = x + cos(i) * size;
      float sy = y + sin(i) * size;
      vertex(sx, sy);
    }
    endShape(CLOSE);
  }//end polygon()
  
  void update()
  {
    theta += thetaDir;
    
    pos.add(forward);
    if (pos.x < 0)
    {
       pos.x = width;
    }//end if
    
    if (pos.x > width)
    {
      pos.x = 0;
    }//end if
    
    if (pos.y < 0)
    {
      pos.y = height;
    }//end if
    
    if (pos.y > height)
    {
      pos.y = 0;
    }//end if
    speed = random(1,8);
  }//end update()
  
}//end class