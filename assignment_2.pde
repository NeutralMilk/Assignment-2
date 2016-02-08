
//variables about stars
int[] starX;
int[] starY;
int[] brightness;

float sideLength;
float border;

int random;

//variables to determine comet amount
StringList level = new StringList();
ArrayList<Integer> cometAmount = new ArrayList<Integer>();
ArrayList<Integer> mineAmount = new ArrayList<Integer>();
ArrayList<Integer> tntAmount = new ArrayList<Integer>();
ArrayList<Integer> goalSize = new ArrayList<Integer>();
boolean create = true;

//arraylist for game objects and loading the data
ArrayList<GameObject> ship = new ArrayList<GameObject>();
ArrayList<GameObject> normalComet = new ArrayList<GameObject>();
ArrayList<GameObject> mineComet = new ArrayList<GameObject>();
ArrayList<GameObject> tntComet = new ArrayList<GameObject>();
ArrayList<String> levelData = new ArrayList <String>();
String[] levelText;


boolean[] keys = new boolean[512];

void setup()
{
  fullScreen();
  background(0);
  
  //load in level data
  levelText = loadStrings("levels.txt");
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

void loadData()
{
  
  //for loop to split the words up and put them in a new array
  for(int i = 0; i < levelText.length; i++)
  {
    //change everything to lowercase, replace full stops and commas with spaces and split at a space
    String temp = levelText[i];
    String[] w = temp.split(",");
    for(String s:w)
    {
      levelData.add(s);
    }//end for
  }//end for
  for(int i = 0; i < levelData.size(); i+= 5)
  {
    level.append(levelData.get(i));
    cometAmount.add(Integer.parseInt(levelData.get(i+1)));
    mineAmount.add(Integer.parseInt(levelData.get(i+2)));
    tntAmount.add(Integer.parseInt(levelData.get(i+3)));
    goalSize.add(Integer.parseInt(levelData.get(i+4)));
    
  }//end for
}//end loadData()

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

boolean menu = true;

void draw()
{
  if(menu == true)
  {
    background(0);
    float boxWidth = width/3;
    float boxHeight = height/5;
    
    float x = width/2 - boxWidth/2;
    float y = height/2 - boxHeight/2;
    
    fill(0);
    stroke(255);
    strokeWeight(5);
    if(mouseX > x && mouseX < x + boxWidth && mouseY > y - boxHeight/1.5 && y < y + boxHeight/1.5)
    {
      stroke(200);
      rect(x, y - boxHeight/1.5, boxWidth, boxHeight);
    }
    else
    {
      stroke(255);
      rect(x, y - boxHeight/1.5, boxWidth, boxHeight);
    }//end else
    rect(x, y + boxHeight/1.5, boxWidth, boxHeight);
    
    textAlign(CENTER);
    fill(255);
    textSize(width/20);
    text("Start Game", width/2, height/2 - boxHeight/2);
    text("Exit Game", width/2, height/2 + boxHeight/1.25);
    strokeWeight(1);

  }//end if
  if(menu == false)
  {
    background(0);
    
    //create the right amount of comets for the level
    createComet();
    
    //draw the spawn point
    spawnPoint();
    
    //refresh the stars
    stars();
    
    //checking if a level is completed
    levelComplete();
    
    //gold comet
    for(int i = mineComet.size() - 1 ; i >= 0 ; i --)
    {
      GameObject go = mineComet.get(i);
      go.update();
      go.render();
    }//end for
    
    //white comet
    for(int i = normalComet.size() - 1 ; i >= 0 ; i --)
    {
      GameObject go = normalComet.get(i);
      go.update();
      go.render();
    }//end for
    
    for(int i = tntComet.size() - 1 ; i >= 0 ; i --)
    {
      GameObject go = tntComet.get(i);
      go.update();
      go.render();
    }//end for
    
    //ship
      GameObject go = ship.get(0);
      go.update();
      go.render();
    
    stroke(255);
    fill(255);
    rect(0, 0, width, sideLength/2);
    
    //set up level
    levelInfo();
  }//end if
}//end draw()

int levelIndex = 0;
void levelComplete()
{
  float h = (height + sideLength) / 2;
  int l = goalSize.get(levelIndex);
  
  if (collected == mineAmount.get(levelIndex))
  { 
    fill(0,255,0);
    stroke(0,255,0);
    rect(0, h - l/2, 10, l);
    
    GameObject go = ship.get(0);
    if(go.pos.x > -1 && go.pos.x < 20 && go.pos.y > h-l/2 && go.pos.y < h - l/2 + l)
    {
      levelIndex ++;
      
      normalComet.clear();
      mineComet.clear();
      tntComet.clear();
      create = true;
      createComet();
      
      ship.remove(0);
      Rocket rocket = new Rocket('W', 'A', 'D',' ', width-sideLength/2-border, height/2, color(255));
      ship.add(rocket);
      collected = 0;
  
    }//end if
  }//end if
}//end levelComplete()
void levelInfo()
{    
  
  float textBorder = height/8;
  textSize(32);
  fill(0);
  text(level.get(levelIndex), width/2, sideLength/3);
  
  //display comet amounts
  rect(width/2+textBorder, sideLength/3, sideLength/4, sideLength/4);
  text(cometAmount.get(levelIndex), width/2+textBorder, sideLength/3);
  text(mineAmount.get(levelIndex), width/2+(textBorder*2), sideLength/3);
  text(tntAmount.get(levelIndex), width/2+(textBorder*3), sideLength/3);

  fill(255);
  strokeWeight(3);
  stroke(0);
  line((width/4 + border/4), (border), (width/4 + border), (border)); 
  
  strokeWeight(1);
}//end levelConfig

void keyPressed()
{
  keys[keyCode] = true;
}

void keyReleased()
{
  keys[keyCode] = false;
}

void spawnPoint()
{
  strokeWeight(3);
  stroke(0, 150, 255);
  fill(0);  
  rect(width-sideLength-border, (height/2)-(sideLength/2), sideLength, sideLength);
  stroke(255);
  strokeWeight(1);  
}//end spawnPoint()

void createComet()
{
  if (create == true)
  {
    for(int i = 0; i < cometAmount.get(levelIndex); i++)
    {      
      Comet comet1 = new Comet();
      normalComet.add(comet1);
    }//end for
    
    for(int i = 0; i < tntAmount.get(levelIndex); i++)
    {      
      TNTComet comet2 = new TNTComet();
      tntComet.add(comet2);
    }//end for
    
    for(int i = 0; i < mineAmount.get(levelIndex); i++)
    {      
      MineComet comet3 = new MineComet();
      mineComet.add(comet3);
      if(i == mineAmount.get(levelIndex)-1)
      {
        create = false;
      }//end
      stroke(255, 223, 0);
    }//end for  
  }
  checkCollisions();
}//end createComet

int collected = 0;

void checkCollisions()
{
 for(int i = ship.size() - 1 ; i >= 0; i --)
 {
    GameObject go = ship.get(0);
    
    //check for mineables
    for(int j = mineComet.size() - 1 ; j >= 0; j --)
    {
       GameObject k = mineComet.get(j);      
       if (go.pos.dist(k.pos) < go.size*1.2 + k.size*1.2)
       {      
          mineComet.remove(k);
          collected++;
       }//end if   
    }//end for
   
    //check for white comets
    for(int j = normalComet.size() - 1 ; j >= 0; j --)
    {
      GameObject k = normalComet.get(j);
      if (go.pos.dist(k.pos) < go.size*1.1 + k.size*1.1)
      {
        normalComet.clear();
        mineComet.clear();
        tntComet.clear();
        
        collected = 0;
        create = true;
        createComet();
        
        ship.remove(0);
        Rocket rocket = new Rocket('W', 'A', 'D',' ', width-sideLength/2-border, height/2, color(255));
        ship.add(rocket);
      }//end if
    }//end for
    
    //check for tnt comets
    for(int j = tntComet.size() - 1 ; j >= 0; j --)
    {
      GameObject k = tntComet.get(j);
      if (go.pos.dist(k.pos) < go.size*1.1 + k.size*1.1)
      {
        levelIndex--;
        normalComet.clear();
        mineComet.clear();
        tntComet.clear();
        
        collected = 0;
        create = true;
        createComet();        
        
        ship.remove(0);
        Rocket rocket = new Rocket('W', 'A', 'D',' ', width-sideLength/2-border, height/2, color(255));
        ship.add(rocket);
      }//end if
    }//end for
  }//end for
  
 for(int i = normalComet.size() - 1; i >= 0; i --)
 {
   GameObject k = normalComet.get(i);
   if(k.pos.x < (width - sideLength - border) && k.pos.x > (width - border) && k.pos.y < (height - sideLength/2) && k.pos.y > (height + sideLength/2))
   {
     k.pos.x = random(width);
     k.pos.y = random(height - sideLength/2);
   }//end if
 }//end for
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