int[] starX;
int[] starY;
int[] brightness;
int cometCount = 0;

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
  brightness= new int[arraySize];
  
  Rocket rocket = new Rocket('W', 'A', 'D', 'C', ' ', width/2, height/2, color(255));
  gameObjects.add(rocket);
  
  //draw the stars initially
  for (int i = 0; i < height/1.5 ; i++)
  {
    brightness[i] = (int)random(5,255);
    stroke(brightness[i]);
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
  
  Comet comet = new Comet();
  switch(cometCount)
  {
    case 0:
      gameObjects.add(comet);
      cometCount++;
      break;
      
    case 1:
      gameObjects.add(comet);
      cometCount++;
      break;
      
    case 2:    
      gameObjects.add(comet);
      cometCount++;
      break;
      
    case 3:
      gameObjects.add(comet);
      cometCount++;
      break;
      
  }

}//end draw()

void stars()
{
  for (int i = 0; i < height/1.5 ; i++)
  {
    stroke(brightness[i]+((int)random(-5,10)));
    //strokeWeight(1);
    int x = starX[i];
    int y = starY[i];
    point(x, y);
  }//end for()
}//end stars()