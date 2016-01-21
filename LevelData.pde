class LevelData
{
  String numComets;
  String numObjectives;
  String goalSize;

  LevelData(String data)
  {
    String[] num = data.split(" ");
    numComets = num[0];
    numObjectives = num[1];
    goalSize = num[2];
  }
  
}