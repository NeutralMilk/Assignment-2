class LevelData
{
  int numComets;
  int numObjectives;
  int goalSize;

  LevelData(String data)
  {
    String[] num = line.split(" ");
    numComets = num[0];
    numObjectives = num[1];
    goalSize = num[2];
  }
  
}