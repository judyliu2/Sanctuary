class Character {
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