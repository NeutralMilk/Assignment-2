class Rocket extends GameObject
{
  //fields
  char move;
  char left;
  char right;
  char fire;
  char boost;  
  int lives;
  int ammo;
  
  Rocket()
  {   
    super(width * 0.5f, height  * 0.5f, 50);         
  }
  
  Rocket(char move, char left, char right, char boost, float startX, float startY, color c)
  {
    super(startX, startY, 50);
    this.move = move;
    this.left = left;
    this.right = right;
    this.boost = boost;
    this.c = c;
    lives = 10;
    ammo = 10;
  }

  boolean moving = false;
  
  void update()
  {
    forward.x = sin(theta);
    forward.y = - cos(theta);
    forward.mult(speed);

    //movement
    if (keys[move])
    {
      pos.add(forward);
    }//end if
    
    if (keys[boost]) 
    {
        speed = 12;
    }//end if
    
    else
    {
      speed = 6;
    }//end else   
    
    if (keys[left])
    {
      theta -= 0.1f;
    }//end if
    
    if (keys[right])
    {
      theta += 0.1f;
    }//end if   
    
    
    //allow top and bottom to wrap around but not left and right
    if (pos.x < 0)
    {
      pos.x = 0;
    }//end if
    
    if (pos.x > width)
    {
      pos.x = width;
    }//end if
    
    if (pos.y < 0)
    {
      pos.y = height;
    }//end if
    
    if (pos.y > height)
    {
      pos.y = 0;
    }//end if
  }
  
  void render()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    strokeWeight(1);
    stroke(c);
    fill(f);
    rotate(theta);
    triangle(halfW, -halfW,-halfW, 0, halfW, halfW);
    
    if (keys[move])
    {
      //flames
      int r = (int)random(150,255);
      int g = (int)random(125);
      
      stroke(r, g, 0);
      fill(r, g, 0);
      triangle(halfW+(.3*halfW), halfW/2, 2.25*halfW, 0, halfW+(.3*halfW), -halfW/2);
    }
    
    popMatrix();
  }   
}