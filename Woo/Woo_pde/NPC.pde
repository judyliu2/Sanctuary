class NPC extends Character {
  NPC(){
    super();
  }
  NPC(float a, float b){
    super();
    x = a;
    y = b;
  }
  NPC(PImage p, int a, int b){
    super(p, a, b);
  }
  void display() {
    image(character, x, y, 120, 100);
  }
}
