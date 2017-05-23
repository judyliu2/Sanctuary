class User extends Character {
  boolean left, right; //if boolean is true, character is moving in corresponding direciton
  User(){
    inventory = new String[16];
    x = 320;
    y = 30;
    speed = 10;
    left = false;
    right = false;
  }
  
  User (float a, float b){
    super(a,b);
    speed = 10;
    left = false;
    right = false;
    inventory = new String[16];
  }
  
  public void display(){
  }
  
  public void move(){
    if (left && x > 0){
      x -= speed;
    }
    if (right && x < width){
      x += speed;
    }
  }
}