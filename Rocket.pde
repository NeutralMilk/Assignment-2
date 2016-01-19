class Rocket extends GameObject
{
  // Fields!
  char move;
  char left;
  char right;
  char fire;
  char boost;
  
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
  
  Rocket(char move, char left, char right, char boost, char fire, float startX, float startY, color c)
  {
    super(startX, startY, 50);
    this.move = move;
    this.left = left;
    this.right = right;
    this.fire = fire;
    this.boost = boost;
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
    forward.mult(speed);

    if (keys[move])
    {
      pos.add(forward);
    }//end if
    
    if (keys[boost]) 
    {
        speed = 20;
    }//end if
    
    else
    {
      speed = 6;
    }//end else   
    
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
    strokeWeight(1);
    stroke(c);
    fill(f);
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