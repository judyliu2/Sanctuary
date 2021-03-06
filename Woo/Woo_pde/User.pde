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
  int fatness = 150;
  User(boolean hide) {
    this(300, 280, hide);
  }

  User (float a, float b, boolean hide) {
    super(a, b);
    dx = 10;
    dy = 10;
    gravity = - 2;
    baseY = this.y;
    left = false;
    right = false;
    hidden = hide;
    state = 1;
  }

  public void setLeft(boolean stat) {
    left = stat;
  }

  public void setRight(boolean stat) {
    right = stat;
  }
  public void setX(int newx) {
    x = newx;
  }
  public void toHide(boolean hide) {
    hidden = hide;
  }

  public boolean isOnDoor(Door d) {
    //f (x == d.getXcor()){
    if ((x < d.getXcor() + d.getWidth()/2) && (x > d.getXcor() - d.getWidth()/2) && (y < d.getYcor() + d.getLength()/2) && (y > d.getYcor() - d.getLength()/2)) {
      onDoor = true;
    } else {
      onDoor = false;
    }
    return onDoor;
  }

  public boolean isNearChar(Character c) {
    return (nearChar = x < c.getXcor() + 40 && x > c.getXcor() - 40);
  }

  public boolean isNearIem(Item i) {
    int range = 30;
    if (x < i.getXcor() + range && x > i.getXcor() - range ) {
      nearItem = true;
    } else {
      nearItem = false;
    }
    return nearItem;
  }

  public void display() {
    if (p != PAGE.START)
      mousePressed();
    if (hidden)
      return;

    image(testchar, x, y-50, fatness, 150);
  }

  public void move() {
    if (hidden)
      return;
    if (state == 2) {
      if (reachx > x) {
        x += dx;
      } else if (reachx < x) {
        x -= dx;
      }
      if (Math.abs(x-reachx) < 10) {
        x = reachx;
        state = 1;
      }
    }
    if (left && x > -40){
      background(bg);
      x -= dx;
    }
    if (right && x < width -100){
      background(bg);
      x += dx;
    }
    if (up && y < 240) {
      background(bg);
      //y += dy;
    }
    if (down && y > 0) {
      background(bg);
    }

  }
  
  void setThickness(int newThickness) {
    fatness = newThickness;
  }
  
}
