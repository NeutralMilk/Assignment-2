abstract class GameObject
{
  PVector pos;
  PVector forward;
  float theta = 0.0f;
  float w;
  float halfW;
  float speed = 5;
  color c; 
 
  GameObject()
  {
    // Constructor chaining
    this(width * 0.25f, height  * 0.25f, 50);     
  }
  
  GameObject(float x, float y, float w)
  {
    pos = new PVector(x, y);
    forward = new PVector(0, 0);
    this.w = w; // Disambiguate w by using this
    this.halfW = w * 0.25f;
    this.theta = 0.0f;
  }
  
  abstract void update();  
  abstract void render();
  
}