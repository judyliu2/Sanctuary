class Character {
  String location;
  String[] inventory; //Used as a stact for NPCs and used as an ArrayList for User
  int state;
  
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