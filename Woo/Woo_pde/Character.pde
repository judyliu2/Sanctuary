class Character {
  String[] inventory = new String[16]; 
  String location;
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