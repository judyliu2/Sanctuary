
PAGE p = PAGE.START;
User player;
Door door1 = new Door(); //p = HOSPITAL
Door hall1 = new Door(45, 230, 70, 150); //p = HALLWAY
Door hall2 = new Door(270, 230, 70, 150); //p = HALLWAY
Door hall3 = new Door(); //p = HALLWAY
Door bipolar1 = new Door(270, 230, 70, 150); //p = BIPOLAR

ArrayList<PVector> history = new ArrayList();

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
  door1.setLocation("Golden hallway.png");
  //background(0);
  // frameRate(60);  // 60 fps
  testchar = loadImage("koro_sensei.png");
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
   /*
  noCursor();
  
  PVector mouse = new PVector(mouseX, mouseY);
  history.add(mouse);
  if (history.size() > 40) {
    history.remove(0);
  }
  for (int i = 0; i <history.size(); i++) {
    noStroke();
    fill(153-i*5, 0, 0);//fill(255 - i*5);//fill(255,255,153);
    PVector position = history.get(i);
    ellipse(position.x, position.y, i, i);
  }
  */
  
  
}
int i = 0;
void mousePressed() {
  System.out.printf("%05d-%-9s %5b(%03.0f, %03.0f, %02.0f%02.0f)\n", i++, p, player.up, player.x, player.y, player.dy, player.gravity);
  if (player.up) {
    player.y -= player.dy;
    player.dy += player.gravity;
    if (player.y > player.baseY) {
      System.out.println("DOWN FORCE, bottom reached");
      player.up = false;
      player.y = player.baseY;
    }
  }
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
    p = PAGE.HOSPITAL;  // fall through
  case HOSPITAL:
    background(bg = loadImage("helpPage.png"));
    fill(150, 20, 0);
    if (p.getNum() < p.getArrLen()) {
      fill(0);
      rect(100, 10, 500, 100);
      fill(255);
      text(p.getNextString(), 110, 35);
      if (p.getNum() > 1)
        image(koro, 0, 0);
    } else {
      player.toHide(false);
      //if (player.isOnDoor(door1)){
      image(doorClosed, door1.getXcor(), door1.getYcor(), door1.getWidth(), door1.getLength());
      //}
      if (player.isOnDoor(door1)) {
        image(doorOpen, 460, 240, 140, 120);
      }
    }
    break;
  case HALLWAY:
    bg = loadImage("Golden hallway.png");
    background(bg);
    //rect(45, 230, 70, 150);
    //rect(270, 230, 70, 150);
    player.location = "hallway";
    break;

  case HELP:
    bg = loadImage("helpPage.png");
    break;

  case BIPOLAR:
    BipolarRoom bipolar = new BipolarRoom();
    bipolar.drawMe();
    player.location = "bipolar";
    break;
  }
}

//public void setBackground(String background){
//  background(loadImage(background));
//}
boolean overRect(int x, int y, int width, int height) {
  return (mouseX>x && mouseX<x+width && mouseY>y && mouseY<y+height);
}

public void keyPressed() { 
  if (key == 'w' && !player.up) { //move up/ jump
    player.up = true;
    player.dy = 17;
    player.gravity = -2;
    player.y -= player.dy;
  }
  if (key == 's') {// interactable
    switch(p) {
    case HOSPITAL:
      if (player.isOnDoor(door1)) {
        //bg = loadImage(door1.nextLocation);
        p = PAGE.HALLWAY;
      }

      break;

    case HALLWAY:
      if (player.isOnDoor(hall1)) {
        p = PAGE.HOSPITAL;
      }
      if (player.isOnDoor(hall2)) {
        p = PAGE.BIPOLAR;
      }
      if (player.isOnDoor(hall3)) {
        p = PAGE.HOSPITAL;
      }
      break;

    case BIPOLAR:
      if (player.isOnDoor(bipolar1)) {
        p = PAGE.HALLWAY;
      }
      break;
    }

    //if (player.onItem == true){
    //}
  }

  if (key == 'a') { //move left
    player.left = true;
  }
  if (key == 'd') { //move right
    player.right = true;
  }
  if (key == 's') { //move down
    player.down = true;
  }
  if ( key == 'w') { // move up
    player.up = true;
  }
}

public void keyReleased() {
  if (key == 'a') { //move left
    player.left = false;
  }

  if (key == 'd') { //move right
    player.right = false;
  }

  if (key == 's') {
    player.down = false;
  }

  if (key == 'w') {
    //player.up = false;
  }
}

//public boolean doorReached

enum PAGE {
  START(), 
    HELP("Where am I...", "Who am I...", "What am I...", "Why am I here..."), 
    HOSPITAL("We are now in the hospital"), 
    HALLWAY("Do we want to go in?"), 
    BIPOLAR("Greetings. I am L.");


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