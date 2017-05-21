class Character {
  //INSTANCE VARS
  String location;
  String[] inventory; //Used as a stact for NPCs and used as an ArrayList for User
  int state;
  float x;
  float y;
  float dx;
  float dy;
  
  Character() {
    location = "1 Ward";
  }
  
  public void setState(int s) { 
    state = s;
  }
  
  public int getState() {
    return state;
  }
  
  
}