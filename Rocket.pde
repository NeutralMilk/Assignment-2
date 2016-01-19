class Rocket extends GameObject
{
  // Fields!
  char move;
  char left;
  char right;
  char fire;
  
  int lives;
  int ammo;
  
  // Constructor!!
  // HAS NO RETURN TYPE
  // Name is always the same as the class
  Rocket()
  {
    // Constructor chaining. Call a constructor in the super class
    super(width * 0.5f, height  * 0.5f, 50);     
    
  }
  
  Rocket(char move, char left, char right, char fire, float startX, float startY, color c)
  {
    super(startX, startY, 50);
    this.move = move;
    this.left = left;
    this.right = right;
    this.fire = fire;
    this.c = c;
    lives = 10;
    ammo = 10;
  }

  int elapsed = 12;
  boolean moving = false;
  
  void update()
  {
    forward.x = sin(theta);
    forward.y = - cos(theta);
    side.mult(speed)
    forward.mult(speed);

    if (keys[move])
    {
      moving = true;
      pos.add(forward);
      speed+=.5;
      if(speed >= 6)
      {
        speed = 6;
      }//end if
    }
    
    if(moving  = false)
    {
      speed = 0;
      forward.mult(speed);
      moving = false;
    }//end else*/
    
    if (keys[left])
    {
      theta -= 0.1f;
    }
    
    if (keys[right])
    {
      theta += 0.1f;
    }      

    
    if (pos.x < 0)
    {
      pos.x = width;
    }
    
    if (pos.x > width)
    {
      pos.x = 0;
    }
    
    if (pos.y < 0)
    {
      pos.y = height;
    }
    
    if (pos.y > height)
    {
      pos.y = 0;
    }
    elapsed ++;
  }
  
  void render()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    stroke(c);
    fill(0);
    rotate(theta);
    triangle(-halfW,halfW,0,-halfW,halfW,halfW);
    
    if (keys[move])
    {
      //flames
      int r = (int)random(150,255);
      int g = (int)random(125);
      
      stroke(r, g, 0);
      fill(r, g, 0);
      triangle(halfW/2, halfW+3, 0, 2*halfW,-halfW/2, halfW+3);
    }
    
    popMatrix();
  }   
}