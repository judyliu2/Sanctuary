class User extends Character {
  boolean left, right; //if boolean is true, character is moving in corresponding direciton
  User(){
    x = 300;
    y = 270;
    speed = 10;
    left = false;
    right = false;
  }
  
  User (float a, float b){
    super(a,b);
    speed = 10;
    left = false;
    right = false;
  }
  
  public void display(){
    image(testchar, x, y);
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