PAGE p = PAGE.START;
User player;
PImage testchar;
PImage koro;
PImage dnChibi;
PImage doorClosed;
PImage doorOpen;
PImage bg;    // use this for universal background image


void setup() {
  size(640, 360); // Sets the screen to be 640 x 360 (L X H)
  //textFont(createFont("SourceCodePro-Regular.ttf", 60));
  textAlign(LEFT);
  bg = loadImage("startPage.png");
  background(bg);
  koro = loadImage("koro_sensei.png");
  dnChibi = loadImage("DNchibi.png");
  doorClosed = loadImage("doorClosed.gif");
  doorOpen = loadImage("doorOpen.gif");
  
  //background(0);
  // frameRate(60);  // 60 fps
  testchar = loadImage("testchar.png");
  player = new User(true);
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
/*  if (player.x > 400){
    FileSort test = new FileSort();
    test.displayAllFiles();
    if (mousePressed){
     test.toDo(); 
    }
  }*/
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
       background(bg = loadImage("helpPage.png"));
       if (p.getNum() < p.getArrLen()) {
         fill(0);
         rect(100,10,500,100);
         fill(255);
         text(p.getNextString(), 110, 35);
         if (p.getNum() > 1)
            image(koro, 0, 0);
       } else {
           player.toHide(false);
           if (player.getXcor() < 420)
             image(doorClosed, 510, 240, 80, 120);
           else {
             image(doorOpen, 460, 240, 140, 120);
             if (player.getXcor() > 460) {
               p = PAGE.HOSPITAL;
               player.setX(0);
             }
           }
       }
     case HOSPITAL:
     
       if (p != PAGE.HOSPITAL)
         return;
       bg = loadImage("Hallway_hospital.jpg");
       background(bg);
       player.location = "hallway";
       
         
   }
}

boolean overRect(int x, int y, int width, int height) {
  return (mouseX>x && mouseX<x+width && mouseY>y && mouseY<y+height);
}

public void keyPressed(){ 
   
    if (key == 'w'){ //move up/ jump
     // player.up = true;
  }
    if (key == 's'){// interactable
     if (player.onDoor == true){
       player.setLocation(player.nextLocation); 
     }
     if (player.onObject == true){
     }
  }
   
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

//public boolean doorReached

enum PAGE {
 START(), 
 HELP("Where am I...", "Who am I...", "What am I...", "Why am I here..."),
 HOSPITAL("We are now in the hospital");
 
 int pageNum;
 String[] arr;
 private PAGE(String... var) {
     pageNum = 0;
     arr = var;
 }
 String getNextString() {
   return arr[pageNum++];
 }
 int getNum() {
   return pageNum;
 }
 int getArrLen() {
   return arr.length;
 }
 
}