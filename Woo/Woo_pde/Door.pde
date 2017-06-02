class Door {
  float xcor;
  float ycor;
  float widthh;
  float lengthh;
  String nextLocation;
  boolean isOpen;

  Door() { 
    this(490.0, 230.0, 70.0, 150.0, true);
  }
  Door( float x, float y, float w, float l, boolean notLocked) {
    xcor = x;
    ycor = y;
    widthh = w;
    lengthh = l;
    isOpen = notLocked;
  }

  Door( boolean notLocked) {
    this();
    isOpen = notLocked;
  }

  void displayDoor() {
    if (player.isOnDoor(this) && isOpen) {
      image(doorOpen, xcor - 30, ycor, widthh + 60, lengthh);
    } else {
      image(doorClosed, xcor, ycor, widthh, lengthh);
    }
  }

  public void setLocation(String newLocation) {
    nextLocation = newLocation;
  }

  public String getNextLocation() {
    return nextLocation;
  }
  public float getXcor() {
    return xcor;
  }

  public float getYcor() {
    return ycor;
  }

  public float getWidth() {
    return widthh;
  }

  public float getLength() {
    return lengthh;
  }
}