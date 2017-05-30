class User extends Character {
  boolean left, right, up, down; //if boolean is true, character is moving in corresponding direciton
  boolean hidden;
  boolean onDoor;
  boolean onItem;
  float  gravity;
  float  baseY;
  float dy;
  boolean isSorting;
  boolean nearChar;
  boolean nearItem;
  float reachx, reachy;
  int state;
  User(boolean hide){
    this(300, 280, hide);
  }
  
  User (float a, float b, boolean hide){
    super(a,b);
    dx = 10;
    dy = 10;
    gravity = - 2;
    baseY = this.y;
    left = false;
    right = false;
    hidden = hide;
    state = 1;
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
  
  public boolean isOnDoor(Door d){
    //f (x == d.getXcor()){
    if ((x < d.getXcor() + d.getWidth()/2) && (x > d.getXcor() - d.getWidth()/2) && (y < d.getYcor() + d.getLength()/2) && (y > d.getYcor() - d.getLength()/2)){
      onDoor = true;
    }
    else{
      onDoor = false;
    }
    return onDoor;
  }
  
   public boolean isNearChar(NPC c){
    int range = 30;
  if (x < c.getXcor() + range && x > c.getXcor() - range ){
    nearChar = true;
  }
  else{
    nearChar = false;
  }
  return nearChar;
  }
  
  public boolean isNearIem(Item i){
    int range = 30;
  if (x < i.getXcor() + range && x > i.getXcor() - range ){
    nearItem = true;
  }
  else{
    nearItem = false;
  }
  return nearItem;
  }
  
  public void display(){
    if (hidden)
      return;
    
    mousePressed();
    image(testchar, x, y-50, 150, 150);
  }
  
  public void move(){
    if (hidden)
      return;
    if (state == 2){
       if (x < reachx){
         x += 10;
       }
       else{
        state = 1; 
       }
    }
    if (left && x > 0){
      background(bg);
      x -= dx;
    }
    if (right && x < width - 50){
      background(bg);
      x += dx;
    }
    if (up && y < 240){
      background(bg);
      //y += dy;
    }
    if (down && y > 0){
      background(bg);
    }
    if (right){//change image
    }
    if (left){//change image
    }
    if (up){// animation for it?
    } 
    if (down){// animation for it?
    }
  }
}