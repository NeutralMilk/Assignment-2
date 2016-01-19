int[] starX;
int[] starY;
int[] brightness;
int cometCount = 0;
float sideLength;
float border;

int random;
ArrayList<GameObject> gameObjects = new ArrayList<GameObject>();

boolean[] keys = new boolean[512];

void setup()
{
  size(1600,900);
  background(0);
  
  //some variables that allow the stars to keep a constant position
  int arraySize = (int)(height/1.5);
  starX = new int[arraySize];
  starY = new int[arraySize];
  brightness= new int[arraySize];
  
  //size of the spawn point
  sideLength = height/10;
  border = sideLength/10;
  
  //create the rocket
  Rocket rocket = new Rocket('W', 'A', 'D',' ', width-sideLength/2-border, height/2, color(255));
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
  strokeWeight(3);
  stroke(0,125,255);
  fill(0);
  
  rect(width-sideLength-border, (height/2)-(sideLength/2), sideLength, sideLength);
  stroke(255);
  strokeWeight(1);
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
    int x = starX[i];
    int y = starY[i];
    point(x, y);
  }//end for()
}//end stars()