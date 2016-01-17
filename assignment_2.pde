int[] starX;
int[] starY;
int random;
void setup()
{
  size(1600,900);
  background(0);
  
  starX = new int[height/2];
  starY = new int[height/2];
  
  //call the function to draw the stars
  stars();
}//end setup()

void draw()
{
  twinkle();
}//end draw()

void stars()
{
  for (int i = 0; i < height/2 ; i++)
  {
    stroke(255);
    int x = (int)random(width);
    int y = (int)random(height);
    point(x, y);
    starX[i] = x;
    starY[i] = y;
  }//end for()
  
  twinkle();
}//end stars()

void twinkle()
{
  if(random != 0)
  {
    for(int i = 255; i > -1; i -=5)
    {
      stroke(i);
      int x = starX[random];
      int y = starY[random];
      point(x,y);
    
      if(i == 0)
      {
        stroke(255);
        x = (int)random(width);
        y = (int)random(height);
        point(x, y);
        starX[random] = x;
        starY[random] = y;
        random = 0;
      }//end if
    }//end for()
   }//end if
  else
  {
    random = (int)random(height/2);
  }//end else

}//end twinkle()