PAGE p = PAGE.START;
User player;
NPC ocdnpc;
Door door1 = new Door(true); //p = HOSPITAL
Door hall1 = new Door(45, 230, 70, 150, false); //p = HALLWAY
Door hall2 = new Door(270, 230, 70, 150, true); //p = HALLWAY
Door hall3 = new Door(true); //p = HALLWAY
Door bipolar1 = new Door(270, 230, 70, 150, true); //p = BIPOLAR

ArrayList<PVector> history = new ArrayList();

PImage testchar;
PImage npcchar;
PImage koro;
//PImage dnChibi;
PImage doorClosed;
PImage doorOpen;
PImage bg;    // use this for universal background image

String bipolarText = "";
float decayVar;
ArrayList<biBox> bipolarBox;  // p = BIPOLAR_PUZZLE;
ArrayList<String> biSolution;  // p = BIPOLAR_PUZZLE;
int biPick = 0;               // p = BIPOLAR_PUZZLE;
boolean biClicked = false;    // p = BIPOLAR_PUZZLE;
int biXOffset;                // p = BIPOLAR_PUZZLE;

void setup() {
  size(640, 360); // Sets the screen to be 640 x 360 (L X H)
  textAlign(LEFT);
  bg = loadImage("startPage.png");
  npcchar = loadImage("testchar.png");
  background(bg);
  koro = loadImage("koro_sensei.png");
  //dnChibi = loadImage("DNchibi.png");
  doorClosed = loadImage("doorClosed.gif");
  doorOpen = loadImage("doorOpen.gif");
  door1.setLocation("Golden hallway.png");
  testchar = loadImage("koro_sensei.png");
  player = new User(true);
  koro = loadImage("koro_sensei.png");
  fill(153, 102, 255);
  //text("Welcome to \n    Our Asylum", 75, 105);
  stroke(255);
  // rect(rectX, rectY, rectXSize, rectYSize);
  // rect(150, 225, 90, 50, 18, 18, 18, 18);
  // rect(400, 225, 90, 50, 18, 18, 18, 18);
  fill(0);

  textFont(createFont("SourceCodePro-Regular.ttf", 24));
  fill(255);
  text("Click to start", 100, 300);
}

void draw() {
  player.move();
  player.display();
  //if (player.isSorting){ //If characters decide to sort 
  //FileSort files = new FileSort();
  //files.displayAllFiles();
  //files.sort();
  //}
  /*  if (player.x > 400){
   FileSort test = new FileSort();
   test.displayAllFiles();
   if (mousePressed)
   test.toDo(); 
   }
   noCursor();
   
   PVector mouse = new PVector(mouseX, mouseY);
   history.add(mouse);
   if (history.size() > 40)
   history.remove(0);
   for (int i = 0; i <history.size(); i++) {
   noStroke();
   fill(153-i*5, 0, 0);//fill(255 - i*5);//fill(255,255,153);
   PVector position = history.get(i);
   ellipse(position.x, position.y, i, i);
   }  */
}
int kk = 0;
void mousePressed() {
  //System.out.printf("%02d-%-8s (%03.0f,%03.0f)\n", kk++%100, p, player.x, player.y);
  if (player.y >=  player.baseY) {
    //System.out.println("DOWN FORCE, bottom reached");
    player.up = false;
    player.y = player.baseY;
  } else {
    player.y -= player.dy;
    player.dy += player.gravity;
  }
  switch(p) {
  case START:
    p = PAGE.HOSPITAL;  // fall through
  case HOSPITAL:
    background(bg = loadImage("helpPage.png"));
    //fill(150, 20, 0);
    if (p.getNum() < p.getArrLen()) {
      fill(0);
      rect(100, 10, 500, 100);
      fill(255);
      text(p.getNextString(), 110, 35);
      if (p.getNum() > 1)
        image(koro, 0, 0);
    } else {
      player.toHide(false);
      image(doorClosed, door1.getXcor(), door1.getYcor(), door1.getWidth(), 
        door1.getLength());
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
    player.toHide(false);
    bipolar.drawMe();
    player.location = "bipolar";

    ocdnpc = new NPC(150.0, 290.0);
    ocdnpc.display();
    FileSort files = new FileSort();
    files.displayAllFiles(); // Maybe this is shown after you click on an item?

    fill(0, 100, 0);
    rect(15, 270, 100, 15);     // left platform
    fill(127, 255, 0);
    rect(130, 200, 100, 15);    // mid platform

    if (player.getXcor() < 65 && player.getYcor() < 280)
      player.baseY = 200;
    else 
    player.baseY = 280;    
    if (player.getXcor()>75 && player.getXcor()<165 && player.getYcor()<170) {
      fill(12, 23, 34);
      rect(290, 20, 340, 120, 0, 18, 0, 18);    // box text
      fill(255);
      text(bipolarText, 295, 45);
      player.baseY = 120;
    }  
    if (bipolarText.equals("...")) {
      decayVar -= 0.015;
      tint(255, 255 - (int) (255 * decayVar));
      image(bg = loadImage("white.png"), 0, 0);
      if (decayVar <= 0) {
        player.setX(0);
        p = PAGE.BIPOLAR_PUZZLE;
        tint(255, 255);
        bipolarBox = new ArrayList<biBox>();
        biSolution = new ArrayList<String>();
        player.toHide(true);
        for (int i = 0; i < 8; i++) {    // max = 8
          String var = randNoRepLetter();
          bipolarBox.add(new biBox(80 * i + 20, var));
          biSolution.add(var);
        }
        java.util.Collections.sort(biSolution);
        player.baseY = 280;
      }
    }

    break;
  case BIPOLAR_PUZZLE:
    background(bg);
    for (biBox b : bipolarBox)
      b.show();
    for (int i = 0; i <bipolarBox.size(); i++)
      if (!biClicked && overRect(bipolarBox.get(i).getPos(), 200, 40, 40)) {
        biPick = i;
        biClicked = true;
        biXOffset = mouseX-bipolarBox.get(i).getPos();
        break;
      } else if (!(mouseY > 200 && mouseY < 240))
        biClicked = false;

    break;
  case BIPOLAR2:
    bg = loadImage("BipolarRoom.png");
    background(bg);
    player.toHide(false);
    fill(12, 23, 34);
    rect(15, 270, 100, 15);     // left platform
    rect(130, 200, 100, 15);    // mid platform

    rect(260, 20, 370, 120, 0, 18, 0, 18);    // box text
    fill(255);
    text(p.getNextString(), 265, 45);
    fill(124, 255, 0);
    rect(270, 230, 70, 150);
    if (player.getXcor() < 65 && player.getYcor() < 280)
      player.baseY = 200;
    else if (player.getXcor()>75 && player.getXcor()<165 && player.getYcor()<170)
      player.baseY = 120;
    else
      player.baseY = 280;
    break;
  }
}

void mouseDragged() {
  if (biClicked)
    bipolarBox.get(biPick).setPos(mouseX - biXOffset);
}

void mouseReleased() {
  biClicked = false;
  if (p == PAGE.BIPOLAR_PUZZLE && isInOrder())
    p = PAGE.BIPOLAR2;
}

String randNoRepLetter() {
  boolean inside = true;
  String var = "A";
  while (inside) {
    var = "" + (char)((int)(Math.random() * 26) + 'A');
    inside = false;
    for (biBox b : bipolarBox)
      if (var.equals(b.getVar()))
        inside = true;
  }
  return var;
}

boolean isInOrder() {
  HashMap mp = new HashMap();
  for (biBox b : bipolarBox)
    mp.put(b.getVar(), b.getPos());
  int min = -1;    // pos can never get below -1
  for (String s : biSolution)
    if (min > (int) mp.get(s))
      return false;
    else 
    min = (int) mp.get(s);
  return true;
}

boolean overRect(int x, int y, int width, int height) {
  return (mouseX>x && mouseX<x+width && mouseY>y && mouseY<y+height);
}

public void keyPressed() { 
  if (key == 'w' && !player.up) { //move up/ jump
    //player.up = true;
    player.dy = 17;          // upward velocity 
    player.gravity = -2;     // gravity unit
    player.y -= player.dy;   // make first change
  }
  if (key == 's') {// interactable
    switch(p) {
    case HELP:    
    case START:
      // EMPTY
      break;
    case HOSPITAL:
      if (player.isOnDoor(door1) && door1.isOpen)
        p = PAGE.HALLWAY;
      break;
    case HALLWAY:
      if (player.isOnDoor(hall1)) {
        fill(0);
        rect(100, 10, 500, 100);
        fill(255);
        text("The door is locked. \n Is my room locked?", 110, 35);
        player.state = 2;
        player.reachx = hall3.xcor;
        if (hall1.isOpen) {
          p = PAGE.HOSPITAL;
        }
      }
      if (player.isOnDoor(hall2)) {
        p = PAGE.BIPOLAR;
        p.resetPage();
        bipolarText = "Greetings. I am L.";
        decayVar = 1;
      }  
      if (player.isOnDoor(hall3))
        p = PAGE.HOSPITAL;
      break;
    case BIPOLAR:  
    case BIPOLAR2:
      //if(player.isNearChar(ocdnpc)) {} //DIALOGUE

      if (player.isOnDoor(bipolar1))
        p = PAGE.HALLWAY;
      if (p.getNum() < p.getArrLen() - 1 && player.getXcor() > 75 && 
        player.getXcor() < 165 && player.getYcor() < 170)
        bipolarText = p.getNextString();
      break;
    case BIPOLAR_PUZZLE:
      // NONE 
      break;

    default:
      System.out.println("unrecongized input");
    }
    //if (player.onItem == true)
  }
  //if (key == 'k') {    // ANSWER KEY FOR BIPOLAR_PUZZLE
  //  for (String b : biSolution)
  //    System.out.print(b + " ");
  //  System.out.println();   
  //}

  player.left   = (key == 'a');   // move left
  player.right  = (key == 'd');   // move right
  player.down   = (key == 's');   // move down
  if (key == 'w')                 // move up
    player.up = true;
}

public void keyReleased() {
  player.left = false;    // move left
  player.right = false;   // move right
  //player.down = false;    
  //if (key == 'w') {
  //  //player.up = false;
  //}
}

enum PAGE {
  START(), 
    HELP("Where am I...", "Who am I...", "What am I...", "Why am I here..."), 
    HOSPITAL("We are now in the hospital"), 
    HALLWAY("Do we want to go in?"), 
    BIPOLAR("This is messy", "This pile is driving me \ncrazy... I feel an urge\n to sort ", 
    "...", "Now that it's sorted, I feel so much better"), 
    BIPOLAR_PUZZLE("Move pieces \n   into order"), 
    BIPOLAR2("Congratulations. \nMission 1 of 999 Complete");

  int pageNum;
  String[] arr;
  private PAGE(String... var) {
    pageNum = 0;
    arr = var;
  }
  String getNextString() {  
    return pageNum < arr.length ? arr[pageNum++] : arr[arr.length -1];
  }
  int getNum() {            
    return pageNum;
  }
  int getArrLen() {         
    return arr.length;
  }
  void resetPage() {       
    pageNum = 0;
  }
}

class biBox implements Comparable<biBox> {  // for BIPOLAR_PUZZLE class
  int pos;
  String var;
  public biBox(int nPos, String nVar) {
    pos = nPos;
    var = nVar;
  }
  int getPos() {
    return pos;
  }
  String getVar() {
    return var;
  }
  void show() {
    fill(20);
    rect(pos, 200, 40, 40);
    fill(220);
    text(var, pos + 12, 230);
  }
  void setPos(int nPos) {
    if (nPos <= 0)
      pos = 0;
    else if (nPos > width - 40)
      pos = width - 40;
    else 
    pos = nPos;
  }
  int compareTo (biBox b2) {
    return var.compareTo(b2.getVar());
  }
}