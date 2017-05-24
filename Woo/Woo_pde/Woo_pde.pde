PAGE p = PAGE.START;
User player;
PImage testchar;
PImage koro;
PImage dnChibi;


void setup() {
  size(640, 360); // Sets the screen to be 640 x 360 (L X H)
  //textFont(createFont("SourceCodePro-Regular.ttf", 60));
  textAlign(LEFT);
  background(loadImage("startPage.png"));
  koro = loadImage("koro_sensei.png");
  dnChibi = loadImage("DNchibi.png");
  //background(0);
  // frameRate(60);  // 60 fps
  testchar = loadImage("testchar.png");
  player = new User();
  koro = loadImage("koro_sensei.png");

  fill(153, 102, 255);
  //text("Welcome to \n    Our Asylum", 75, 105);
  stroke(255);
  // rect(rectX, rectY, rectXSize, rectYSize);
  //rect(150, 225, 90, 50, 18, 18, 18, 18);
  //rect(400, 225, 90, 50, 18, 18, 18, 18);
  fill(0);

  textFont(createFont("SourceCodePro-Regular.ttf", 24));
  fill(255);
  text("Click to start", 100, 300);

}

void draw() {
  player.move();
  player.display();
}

void mousePressed() {
  /* If Help/ Start are re-implemented 
   if( overRect(150, 225, 90, 50) ) {
   background(loadImage("helpPage.png"));
   fill(140);
   text("This is for \n   Game Start", 75, 105);
   } else if ( overRect(400, 225, 90, 50) ) {
   background(loadImage("helpPage.png"));
   fill(220);
   text("This is for \n   Help", 75, 105);
   } else { */
   switch(p) {
     case START:
       p = PAGE.HELP;  // fall through
     case HELP:
       background(loadImage("helpPage.png"));
       fill(0);
       rect(100,10,500,100);
       fill(255);
       text(p.getNextString(), 110, 35);
       if (p.getNum() > 1)
          image(koro, 0, 0);
         
   }
}

boolean overRect(int x, int y, int width, int height) {
  return (mouseX>x && mouseX<x+width && mouseY>y && mouseY<y+height);
}

public void keyPressed(){ 
   /*
    if (key == 'w'){ //move up
    }
    if (key == 's'){ //move down
    }
   */
    if (key == 'a'){ //move left
      player.left = true;
    }
    if (key == 'd'){ //move right
      player.right = true;
    }

}

public void keyReleased(){
    if (key == 'a'){ //move left
      player.left = false;
    }
    if (key == 'd'){ //move right
      player.right = false;
    }
}

enum PAGE {
 START(), 
 HELP("Where am I...", "Who am I...", "What am I...", "Why am I here...");
 
 int pageNum;
 String[] arr;
 private PAGE(String... var) {
     pageNum = 0;
     arr = var;
 }
 String getNextString() {
   return arr[++pageNum % arr.length];
 }
 int getNum() {
   return pageNum % arr.length;
 }
}