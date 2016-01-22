abstract class GameObject
{
  //fields
  PVector pos;
  PVector forward;
  float theta = 0.0f;
  float w;
  float halfW;
  float speed = 6;
  color c;
  color f;
  color gold;
  boolean mine;
  int sides;
  int size;
 
  GameObject()
  {
    this(width * 0.25f, height  * 0.25f, 50);     
  }
  
  GameObject(float x, float y, float w)
  {
    pos = new PVector(x, y);
    forward = new PVector(-1, 0);
    this.w = w;
    this.halfW = w * 0.25f;
    this.theta = 0.0f;
  }
  
  abstract void update();  
  abstract void render();
  
}