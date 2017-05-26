class Door{
  float xcor;
  float ycor;
  float widthh;
  float lengthh;
  String nextLocation;
  
  Door(){ 
    this(510.0, 240.0, 80.0, 120.0);
  }
  Door( float x, float y, float w, float l){
    xcor = x;
    ycor = y;
    widthh = w;
    lengthh = l;
  }
  
  public void setLocation(String newLocation){
    nextLocation = newLocation;
  }
  
  public String getNextLocation(){
    return nextLocation;
  }
  public float getXcor(){
    return xcor;
  }
  
  public float getYcor(){
    return ycor;
  }
  
  public float getWidth(){
    return widthh;
  }
  
  public float getLength(){
    return lengthh;
  }
}
