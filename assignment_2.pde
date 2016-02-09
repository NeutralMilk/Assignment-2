import ddf.minim.*;

//variables about stars
int[] starX;
int[] starY;
int[] brightness;

float sideLength;
float border;

int bomb = 0;
int random;

AudioPlayer bombSound;
AudioPlayer rocketSound;
AudioPlayer nextLevelSound;
AudioPlayer collectSound;
AudioPlayer levelDownSound;
Minim minim;

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
  //fullScreen();
  size(1600,900);
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
  
  minim = new Minim(this);
  bombSound = minim.loadFile("bomb.wav", 2048);
  rocketSound = minim.loadFile("rocket.wav", 2048);
  nextLevelSound = minim.loadFile("levelUp.mp3", 2048);
  levelDownSound = minim.loadFile("levelDown.mp3", 2048);
  collectSound = minim.loadFile("coin.mp3", 2048);
  
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
boolean firstTime = true;

void draw()
{
  if(menu == true)
  {
    menu();
  }//end if
  
  if(menu == false)
  {
    game();
  }//end if
  
}//end draw()

//draw the menu
void menu()
{
  float boxWidth = width/3;
  float boxHeight = height/5;
  
  float x = width/2 - boxWidth/2;
  float y = height/2 - boxHeight/2;
  
  fill(0);
  stroke(255);
  strokeWeight(5);
  
  if(mouseX > x && mouseX < x + boxWidth && mouseY > y - boxHeight/1.5 && mouseY < y + boxHeight/3)
  {
    fill(50);
    if(mousePressed)
    {
      menu = false;
    }//end if
  }
  else
  {
    fill(0);
  }//end else
  
  rect(x, y - boxHeight/1.5, boxWidth, boxHeight);

      
  if(mouseX > x && mouseX < x + boxWidth && mouseY > y + boxHeight/1.5 && mouseY < y + boxHeight*1.7)
  {
    fill(50);
    if(mousePressed)
    {
      exit();
    }//end if
  }
  else
  {
    fill(0);
  }//end else  
  
  rect(x, y + boxHeight/1.5, boxWidth, boxHeight);
  
  textAlign(CENTER);
  fill(255);
  textSize(width/20);
  if(firstTime == true)
  {
    text("Start Game", width/2, height/2 - boxHeight/2);
  }//end if
  
  else
  {
    text("Resume", width/2, height/2 - boxHeight/2);
  }//end else
  
  text("Exit Game", width/2, height/2 + boxHeight/1.25);
  strokeWeight(1);

}//end menu()

//run all the game functions
void game()
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
}//end game()

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
      nextLevelSound.play();
      nextLevelSound.rewind();
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
      bomb = 0;
  
    }//end if
  }//end if
}//end levelComplete()

void levelInfo()
{    
  
  float textSpace = height/8;
  float textBorder = height/32;
  textSize(32);
  fill(0);
  text(level.get(levelIndex), width/2, sideLength/3);
  
  fill(218, 165, 32);
  //display comet amounts
  text(collected, width/2 + textSpace, sideLength/3);
  text("/", width/2+(textSpace + textBorder), sideLength/3);
  text(mineAmount.get(levelIndex), width/2+(textSpace + textBorder*2), sideLength/3);
  
  fill(255, 0, 0);
  text(bomb, width/2 - textSpace, sideLength/3);
}//end levelConfig

void keyPressed()
{
  keys[keyCode] = true;
  
  if (key == 'm') 
  {
    firstTime = false;
   
    if(menu == true)
    {
      menu = false;
    }//end if
    
    else
    {
      menu = true;
    }//end else
  }//end if
}

void keyReleased()
{
  keys[keyCode] = false;
  rocketSound.pause();
  rocketSound.rewind();
}

void mouseClicked()
{  
  for(int i = 0; i < tntComet.size(); i ++)
  {
    GameObject go = tntComet.get(i);
    PVector mousePos = new PVector(mouseX, mouseY);
    
    if(bomb > 0)
    {
      bombSound.play();
      bombSound.rewind();
      if(go.pos.dist(mousePos) < go.size*4)
      {    
        tntComet.remove(i);
        stroke(255);
        fill(255, 0, 0);
        ellipse(go.pos.x, go.pos.y, go.size*10, go.size*10);
        destroyComets();
      }//end if
    }//end if  
  }//end for
  
  bomb --;
  if(bomb < 0)
  {
    bomb = 0;
  }//end if
}//end mouseClicked()

void destroyComets()
{
  for(int i = 0; i < tntComet.size(); i ++)
  {
    GameObject go = tntComet.get(i);     
    
    for(int j = 0; j < normalComet.size(); j ++)
    {
      GameObject n = normalComet.get(j);
      if(n.pos.dist(go.pos) < go.size*5)
      {
        normalComet.remove(j);
      }//end if
    }//end for
    for(int j = 0; j < mineComet.size(); j ++)
    {
      GameObject m = mineComet.get(j);      
      if(m.pos.dist(go.pos) < go.size*5)
      {
        collectSound.play();
        collectSound.rewind();
        mineComet.remove(j);
        collected++;
      }//end if
    }//end for
  }//end for
}//end destroyComets()

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
    if(levelIndex == -1)
    {
      levelIndex = 0;
    }//end if
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
          collectSound.play();
          collectSound.rewind();
          mineComet.remove(k);
          collected++;
          
          bomb++;   
       }//end if   
    }//end for
   
    //check for white comets
    for(int j = normalComet.size() - 1 ; j >= 0; j --)
    {
      GameObject k = normalComet.get(j);
      if (go.pos.dist(k.pos) < go.size*1.1 + k.size*1.1)
      {
        levelDownSound.play();
        levelDownSound.rewind();
        normalComet.clear();
        mineComet.clear();
        tntComet.clear();
        
        collected = 0;
        bomb = 0;
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
        levelDownSound.play();
        levelDownSound.rewind();
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