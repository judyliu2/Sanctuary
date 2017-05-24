class User extends Character {
  boolean left, right; //if boolean is true, character is moving in corresponding direciton
  User(){
    x = 300;
    y = 270;
    speed = 5;
    left = false;
    right = false;
  }
  
  User (float a, float b){
    super(a,b);
    speed = 10;
    left = false;
    right = false;
  }
  
  public void setLeft(boolean stat){
    left = stat;
  }
  
  public void setRight(boolean stat){
    right = stat;
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
    if (right){//change image
    }
    if (left){//change image
    }
  }
}