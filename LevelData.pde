class LevelData
{
  int numComets;
  int numObjectives;
  int goalSize;

  LevelData(int data)
  {
    String[] num = data.split(" ");
    numComets = num[0];
    numObjectives = num[1];
    goalSize = num[2];
  }
  
}