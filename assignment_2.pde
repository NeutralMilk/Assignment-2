int[] starX;
int[] starY;
int random;
ArrayList<GameObject> gameObjects = new ArrayList<GameObject>();
boolean[] keys = new boolean[512];

void setup()
{
  size(1600,900);
  background(0);
  
  int arraySize = (int)(height/1.5);
  starX = new int[arraySize];
  starY = new int[arraySize];
  
  Rocket rocket = new Rocket('W', 'A', 'D', ' ', 200, height / 2, color(0, 255, 255));
  gameObjects.add(rocket);
  rocket = new Rocket('I', 'J', 'L', 'K', width - 200, height / 2, color(255, 255, 0));
  gameObjects.add(rocket);
  
  //draw the stars initially
  for (int i = 0; i < height/1.5 ; i++)
  {
    stroke(random(255));
    int x = (int)random(width);
    int y = (int)random(height);
    point(x, y);
    starX[i] = x;
    starY[i] = y;
  }//end for()
  //call the function to draw the stars
  stars();
}//end setup()

void keyPressed()
{
  keys[keyCode] = true;
}

void keyReleased()
{
  keys[keyCode] = false;
}

void draw()
{
  background(0);
  stars();
  for(int i = gameObjects.size() - 1 ; i >= 0   ;i --)
  {
    GameObject go = gameObjects.get(i);
    go.update();
    go.render();
  }
}//end draw()

void stars()
{
  for (int i = 0; i < height/1.5 ; i++)
  {
    stroke(random(255));
    int x = starX[i];
    int y = starY[i];
    point(x, y);
  }//end for()
  
  twinkle();
}//end stars()

void twinkle()
{
  random = (int)random(height/1.5);
  
  int star_colour = (int)random(255);
  stroke(star_colour);
  int x = starX[random];
  int y = starY[random];
  point(x,y);
  
  if(star_colour == 0);
  {
    stroke(0);
    x = (int)random(width);
    y = (int)random(height);
    point(x, y);
    starX[random] = x;
    starY[random] = y;
  }//end if
}//end twinkle()