//variables about stars
int[] starX;
int[] starY;
int[] brightness;

//variables to determine comet amount
int cometAmount = 10;
int mineAmount = 2;
boolean create = true;

float sideLength;
float border;

int random;

//arraylist for game objects and loading the data
ArrayList<GameObject> ship = new ArrayList<GameObject>();
ArrayList<GameObject> normalComet = new ArrayList<GameObject>();
ArrayList<GameObject> mineComet = new ArrayList<GameObject>();

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
  ship.add(rocket);
  
  //draw the stars initially
  initialStars();
  
}//end setup()

void initialStars()
{
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

}//end initialStars

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
  
  //white comet
  for(int i = normalComet.size() - 1 ; i >= 0   ;i --)
  {
    GameObject go = normalComet.get(i);
    go.update();
    go.render();
  }//end for
  
  //gold comet
  for(int i = mineComet.size() - 1 ; i >= 0   ;i --)
  {
    GameObject go = mineComet.get(i);
    go.update();
    go.render();
  }//end for
  
  //ship
  for(int i = ship.size() - 1 ; i >= 0   ;i --)
  {
    GameObject go = ship.get(i);
    go.update();
    go.render();
  }//end for 
  
  stroke(255);
  fill(255);
  rect(0, 0, width, sideLength/2);
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
    for(int i = 0; i < cometAmount-mineAmount; i++)
    {      
      Comet comet1 = new Comet();
      normalComet.add(comet1);
    }//end for
    
    for(int i = 0; i < mineAmount; i++)
    {      
      MineComet comet2 = new MineComet();
      mineComet.add(comet2);
      if(i == mineAmount-1)
      {
        create = false;
      }//end
      stroke(255, 223, 0);
    }//end for
  }//end if
  
  checkCollisions();
}//end createComet

void checkCollisions()
{
  //check ship against mineable comets
 for(int i = ship.size() - 1 ; i >= 0; i --)
 {
    GameObject go = ship.get(i);
    if (go instanceof Rocket)
    {
      for(int j = mineComet.size() - 1 ; j >= 0   ;j --)
      {
        GameObject k = mineComet.get(j);
        if (k instanceof MineComet) 
          // Bounding circle collisions
          if (go.pos.dist(k.pos) < go.halfW + k.halfW)
          {
            mineComet.remove(k);
          }
        }
      }
 }
 //check ship against dangerous comets
 for(int i = ship.size() - 1 ; i >= 0; i --)
 {
    GameObject go = ship.get(i);
    if (go instanceof Rocket)
    {
      for(int j = normalComet.size() - 1 ; j >= 0   ;j --)
      {
        GameObject k = normalComet.get(j);
        if (k instanceof Comet)
        {
          // Bounding circle collisions
          if (go.pos.dist(k.pos) < go.halfW + k.halfW)
          {
            normalComet.clear();
            mineComet.clear();
            
            create = true;
            createComet();
            
            ship.remove(0);
            Rocket rocket = new Rocket('W', 'A', 'D',' ', width-sideLength/2-border, height/2, color(255));
            ship.add(rocket);
          }
        }
      }
    }
 } 
}//end checkCollisions()
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