class Item {
  PImage item; 
  int id;
  float x;
  float y;
  float dx;
  float wdth;
  float hght;

  Item (PImage p, float a, float b, float c, float d){
    item = p;
    x = a;
    y = b;
    wdth = c;
    hght = d;
  }
  
  public void display(){
    image(item,x,y, wdth,hght);
  }
  public float getDx() {
    return dx;
  }
  public float getXcor() {
    return x;
  }
  public float getYcor() {
    return y;
  }
}