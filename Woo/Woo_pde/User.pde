class User extends Character {
  boolean left, right; //if boolean is true, character is moving in corresponding direciton
  User(){
    x = 300;
    y = 270;
    dx = 5;
    left = false;
    right = false;
  }
  
  User (float a, float b){
    super(a,b);
    dx =5;
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
      background(loadImage("helpPage.png"));
      x -= dx;
    }
    if (right && x < width){
      background(loadImage("helpPage.png"));
      x += dx;
    }
    if (right){//change image
    }
    if (left){//change image
    }
  }
}