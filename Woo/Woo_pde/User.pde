class User extends Character {
  boolean left, right; //if boolean is true, character is moving in corresponding direciton
  boolean hidden;
  User(boolean hide){
    this(300, 270, hide);
  }
  
  User (float a, float b, boolean hide){
    super(a,b);
    dx = 5;
    left = false;
    right = false;
    hidden = hide;
  }
  
  public void setLeft(boolean stat){
    left = stat;
  }
  
  public void setRight(boolean stat){
    right = stat;
  }
  public void setX(int newx) {
    x = newx;
  }
  public void toHide(boolean hide) {
    hidden = hide;
  }
  
  public void display(){
    if (hidden)
      return;
    
    mousePressed();
    image(testchar, x, y);
  }
  
  public void move(){
    if (hidden)
      return;
    if (left && x > 0){
      background(bg);
      x -= dx;
    }
    if (right && x < width - 50){
      background(bg);
      x += dx;
    }
    if (right){//change image
    }
    if (left){//change image
    }
  }
}
