class Comet extends GameObject
{
  float thetaDir;
  Comet()
  {
    super(random(0, width), random(0, height), 50);    
    c = 255;
    f = 0;
    mine = true;
    gold = color(255, 223, 0);
    forward.x = random(-1, 1);
    forward.y = random(-1, 1);
    forward.normalize();
    thetaDir = random(-0.015f, 0.015f);
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
    /*int type = (int)random(0,2);
    int size = (int)random(10,40);
    switch (type)
    {
      case 0:
        rect(0,0,size,size);
        break;
      case 1:
        ellipse(0, 0, size,size);
        break;
      case 2:
        triangle (0, 0, size, size, size, size);
        break;
    }//end switch*/
    popMatrix();
  }//end render()
  
  void polygon(float x, float y, float size, int sides) 
  {
    float angle = TWO_PI / sides;
    beginShape();
    for (float i = 0; i < TWO_PI; i += angle) 
    {
      float newX = x + cos(i) * size;
      float newY = y + sin(i) * size;
      vertex(newX, newY);
    }//end for
    
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

  }//end update()
  
}//end class