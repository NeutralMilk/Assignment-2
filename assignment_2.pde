//variables about stars
int[] starX;
int[] starY;
int[] brightness;

//variables to determine comet amount
int cometAmount = 10;
boolean create = true;

float sideLength;
float border;

int random;

//arraylist for game objects and loading the data
ArrayList<GameObject> gameObjects = new ArrayList<GameObject>();
ArrayList<LevelData> Data = new ArrayList<LevelData>();

boolean[] keys = new boolean[512];

void setup()
{
  size(1600,900);
  background(0);
  
  //load in level data
  loadData();
  
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

void loadData()
{
  String[] data = loadStrings("levels.txt");
}//end loadData()

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
  
  //draw the spawn point
  spawnPoint();
  
  //refresh the stars
  stars();
  
  //create the right amount of comets for the level
  createComet();
  
  for(int i = gameObjects.size() - 1 ; i >= 0   ;i --)
  {
    GameObject go = gameObjects.get(i);
    go.update();
    go.render();
  }//end for    
  
  //println(numComets);
}//end draw()

void spawnPoint()
{
  strokeWeight(3);
  stroke(0,125,255);
  fill(0);  
  rect(width-sideLength-border, (height/2)-(sideLength/2), sideLength, sideLength);
  stroke(255);
  strokeWeight(1);  
}//end spawnPoint()

void createComet()
{
  if (create == true)
  {
    for(int i = 0; i < cometAmount; i++)
    {
      Comet comet = new Comet();
      gameObjects.add(comet);
      if(i == cometAmount-1)
      {
        create = false;
      }//end
    }//end for
  }//end if

}//end createComet

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