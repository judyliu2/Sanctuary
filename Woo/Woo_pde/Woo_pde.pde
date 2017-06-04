//~~~~~~~~~Tracking Vars~~~~~~~~~~~~~~~
PAGE p = PAGE.START;
User player;
NPC ocdnpc;

//~~~~~~~~~~~~~~doors~~~~~~~~~~~~~~~~~~
Door door1 = new Door(true); //p = HOSPITAL to HALLWAY
Door hall1 = new Door(35, 230, 70, 150, false); //p = HALLWAY to SCHIZOPHRENIA
Door hall2 = new Door(270, 230, 70, 150, true); //p = HALLWAY to DEMENTIA
Door hall3 = new Door(520, 230, 70, 150, true); //p = HALLWAY to HOSPITAL (OCD)
Door dementia1 = new Door(480, 210, 70, 150, true); //p = DEMENTIA to HALLWAY


//ArrayList<PVector> history = new ArrayList();

//~~~~~~~~~~~~~~images~~~~~~~~~~~~~~~~~
PImage testchar;
PImage npcchar;
PImage koro;
PImage doorClosed;
PImage doorOpen;
PImage bg;    // use this for universal background image
PImage present;
NPC[] sczNPC;

//~~~~~~~~~Rooms~~~~~~~~~~~
Room dementia;


String dementiaText = "";
float decayVar = 0;
boolean bx;
boolean by;

//for Help button
boolean overBox = false;
boolean locked = false;
boolean overExit = false;

ArrayList<biBox> dementiaBox;  // p = DEMENTIA_PUZZLE;
ArrayList<String> biSolution;  // p = DEMENTIA_PUZZLE;
int biPick = 0;               // p = DEMENTIA_PUZZLE;
boolean biClicked = false;    // p = DEMENTIA_PUZZLE;
int biXOffset;        // p = DEMENTIA_PUZZLE;
int biYOffset;
boolean lockedRoomDisplay = false;
boolean dementiaPuzzleComplete = false;
boolean loadOCD = (p == PAGE.DEMENTIA2 || p == PAGE.OCD);
boolean disableControls = false;
boolean presentAppear = true;

//String place = "HOSPITAL";
//int ltime;
//static final short speed = 0200; // pixels per second

void setup() {
  size(640, 360); // Sets the screen to be 640 x 360 (L X H)
  textAlign(LEFT);
  bg = loadImage("startPage.jpg");
  npcchar = loadImage("testchar.png");
  background(bg);
  koro = loadImage("koro_sensei.png");
  sczNPC = new NPC[] {
      new NPC(loadImage("DNchibi.png"), 20, 260), 
      new NPC(loadImage("DNchibi.png"), 170, 260),
      new NPC(loadImage("DNchibi.png"), 320, 260),
      new NPC(loadImage("DNchibi.png"), 470, 260)
  };
  doorClosed = loadImage("doorClosed.gif");
  doorOpen = loadImage("doorOpen.gif");
  door1.setLocation("HALLWAY");
  testchar = loadImage("koro_sensei.png");
  player = new User(true);
  koro = loadImage("koro_sensei.png");
  present = loadImage("present.png");
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
  dementia = new DementiaRoom();
}

void draw() {
  update();
  player.move();
  player.display();
  int color1 = 255;
  int wordColor = 0;
  fill(color1);
  rect(550, 20, 75, 40, 18, 18, 18, 18); //Help button
  fill(wordColor);
  text("Help", 558, 45);
  overBox = overRect(550, 20, 75, 40); //if help is clicked
  // if exit is clicked player is moved back to previous map
 overExit = overRect(570, 300, 40, 40);
}


/*
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
void update(){
  if( overRect(550,20, 75, 40)){
    overBox = false;
    overExit = false;
  } else{
    overBox = overExit = false;
  }
}
int kk = 0;
void mousePressed() {
  // HELP BUTTON
  if (overExit) {
    //return to previous page
    p = PAGE.HALLWAY;
  }
  if (overBox) {
    p = PAGE.HELP;
    //locked = true; 
    //rect(30,30,580,320);
    //fill(255, 255, 255);
  } else
    locked = false;
  //System.out.printf("%02d-%-8s (%03.0f,%03.0f)\n", kk++%100, p, player.x, player.y);
  if (player.y >=  player.baseY) {
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
    player.location = "HOSPITAL";
    //fill(150, 20, 0);
    //if (p.getNum() < p.getArrLen()) {
    fill(0);
    rect(100, 10, 500, 100);
    fill(255);
    text(p.getNextString(), 110, 35);
    p.stallIfDialogue();
    player.toHide(false);
    door1.displayDoor();
    //}
    break;
  case HALLWAY:
    bg = loadImage("Golden hallway.png");
    player.location = "HALLWAY";
    background(bg);
    ////shows all the doors
    //hall1.displayDoor();
    //hall2.displayDoor();
    //hall3.displayDoor();
    //rect(45, 230, 70, 150);
    //rect(270, 230, 70, 150);
    if (lockedRoomDisplay) {
      fill(0);
      rect(100, 10, 500, 100);
      fill(255);
      text("The door is locked. \n Is my room locked?", 110, 35);
      //if (player.getXcor() > 350)
      //  lockedRoomDisplay = false;
    }
    if (dementiaPuzzleComplete) {
      fill(255, 0, 0);
      textFont(createFont("SourceCodePro-Regular.ttf", 12));
      text("Obsessive\n Compulsive\nDisorder", 525, 280);
      textFont(createFont("SourceCodePro-Regular.ttf", 24));
    }
    if (loadOCD) {
      player.state = 2;
      player.reachx = hall3.xcor;
      if (player.getXcor() >= hall3.xcor - 11)
        p = PAGE.OCD;
    }
    break;

  case HELP:

    bg = loadImage("helpPage.png");

    fill(250);
    background(bg);
    if (player.location == "DEMENTIA"){
      
    String text = "Organize the cards in alphabetical order"; // maybe put instructions of how the user can move the character
    text(text, 40, 80);
    
    //sorting animation
    FileSort files = new FileSort();
    files.sort();
    
    }
    else{
      String text = "Keys: \n W - Jump \n S - Walk through doors or \n interact with others \n A - Move left \n D - Move right";
      text(text, 40, 80);
    }
    
    fill(255);
    rect( 570, 300, 40, 40, 18, 18, 18, 18);
    fill(0);
    text("X", 582, 328);
    
    break;

  case DEMENTIA:
    player.toHide(false);
    dementia.drawMe();
    dementia1.displayDoor();
    player.location = "DEMENTIA";

    ocdnpc = new NPC(150.0, 290.0);
    //ocdnpc.display(100,100);

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
      text(dementiaText, 295, 45);
      player.baseY = 120;
    }  
    if (dementiaText.equals("...")) {
      player.toHide(true);
      decayVar -= 0.015;
      tint(255, 255 - (int) (255 * decayVar));
      image(bg = loadImage("white.png"), 0, 0);
      if (decayVar <= 0) {
        player.setX((int)hall3.xcor);
        p = PAGE.DEMENTIA_PUZZLE;
        tint(255, 255);
        dementiaBox = new ArrayList<biBox>();
        biSolution = new ArrayList<String>();
        player.toHide(true);
        for (int i = 0; i < 8; i++) {    // max = 8
          String var = randNoRepLetter();
          dementiaBox.add(new biBox(80 * i + 20, var));
          biSolution.add(var);
        }
        java.util.Collections.sort(biSolution);
        player.baseY = 280;
      }
    }

    break;
  case DEMENTIA_PUZZLE:
    player.location = "DEMENTIA_PUZZLE";
    background(bg);
    for (biBox b : dementiaBox)
      b.show();
    for (int i = 0; i <dementiaBox.size(); i++)
      if (!biClicked && overRect(dementiaBox.get(i).getPos(), 200, 40, 40)) {
        biPick = i;
        biClicked = true;
        biXOffset = mouseX-dementiaBox.get(i).getPos();
        break;
      } else if (mouseY < 200 || mouseY > 240)
        biClicked = false;

    break;
  case DEMENTIA2:
    //player.location = "DEMENTIA2";
    background(bg = loadImage("spirited_away.jpg"));
    player.toHide(false);
    if (loadOCD) {
      if (decayVar == 1) {
        try {
          Thread.sleep(50);
        }        
        catch(Exception e) { }
        decayVar -= 0.001;
      }
      disableControls = true;
      player.state = 2;
      player.reachx = dementia1.xcor ;
      if (player.getXcor() == dementia1.xcor) //===================================
        p = PAGE.HALLWAY;
      decayVar = 1;
      
    }
    fill(12, 23, 34);
    rect(15, 270, 100, 15);     // left platform
    rect(130, 200, 100, 15);    // mid platform

    rect(260, 20, 370, 120, 0, 18, 0, 18);    // box text
    fill(255);
    text(p.getNextString(), 265, 45);
    dementia1.displayDoor();
    //fill(124, 255, 0); //door
    //rect(290, 230, 70, 150);
    if (player.getXcor() < 65 && player.getYcor() < 280)
      player.baseY = 200;
    else if (player.getXcor()>75 && player.getXcor()<165 && player.getYcor()<170)
      player.baseY = 120;
    else
      player.baseY = 280;
    break;
  case OCD:
    if (loadOCD) {
      decayVar -= 0.01;
      player.setThickness(120);
      if (decayVar > 0) {
        //player.toHide(true);
        tint(255, 255 - (int) (255 * decayVar));
        image(loadImage("black.png"), 0, 0);
        
      } else {
        tint(255, 255);
        background(bg = loadImage("spirited_away.jpg"));
        disableControls = false;
        testchar = loadImage("haku.png");
        loadOCD = false;
      }
    } else {
      fill(0, 100, 0);
      rect(65, 270, 100, 15);     // left platform
      fill(127, 255, 0);
      rect(180, 200, 120, 15);    // mid platform
      if (player.getXcor() < 115 && player.getYcor() < 280)
        player.baseY = 200;
      else 
      player.baseY = 280;    
      if (player.getXcor()>25 && player.getXcor()<165 && player.getYcor()<170) {
        fill(12, 23, 34);
        rect(290, 20, 340, 120, 0, 18, 0, 18);    // box text
        fill(255);
        text(dementiaText, 295, 45);
        player.baseY = 120;
      }
      //System.out.println("PRESENT " + presentAppear);
      if (presentAppear)
        image(present, 20, 160, 100, 100);
       hall3.displayDoor();
    }  


    break;
    case SCHIZOPHRENIA:
      //background(bg);
      for (NPC npp : sczNPC)
        npp.display();
      rect(200, 20, 450, 80);
      fill(255);
      text("Which is the real me??", 210, 45);
      fill(0);
      for (NPC n : sczNPC)
        if (player.isNearChar(n)) {
          rect (n.getXcor(), n.getYcor() - 145, 150, 30, 18, 18, 18, 18);
          fill(255);
          text("Choice 1", n.getXcor() + 15, n.getYcor() - 123);
          fill(0);
          rect (n.getXcor(), n.getYcor() - 110, 150, 30, 18, 18, 18, 18);
          fill(255);
          text("Choice 2", n.getXcor() + 15, n.getYcor() - 88);
          fill(0);
          rect (n.getXcor(), n.getYcor() -  75, 150, 30, 18, 18, 18, 18);
          fill(255);
          text("Choice 3", n.getXcor() + 15, n.getYcor() - 53);
          fill(0);
          rect (n.getXcor(), n.getYcor() -  40, 150, 30, 18, 18, 18, 18);
          fill(255);
          text("Choice 4", n.getXcor() + 15, n.getYcor() - 18);
          fill(0);
        }
        
      
    break;
  }
}

void mouseDragged() {
  if (biClicked)
    dementiaBox.get(biPick).setPos(mouseX - biXOffset);
}

void mouseReleased() {
  biClicked = false;
  if (p == PAGE.DEMENTIA_PUZZLE && isInOrder()) {
    p = PAGE.DEMENTIA2;
    dementiaPuzzleComplete = true;
    loadOCD = true;
  }
}

String randNoRepLetter() {
  boolean inside = true;
  String var = "A";
  while (inside) {
    var = "" + (char)((int)(Math.random() * 26) + 'A');
    inside = false;
    for (biBox b : dementiaBox)
      if (var.equals(b.getVar()))
        inside = true;
  }
  return var;
}

boolean isInOrder() {
  HashMap mp = new HashMap();
  for (biBox b : dementiaBox)
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
  if (key == 'w' && !player.up && !disableControls) { //move up/ jump
    player.up = true;
    player.dy = 17;          // upward velocity 
    player.gravity = -2;     // gravity unit
    player.y -= player.dy;   // make first change
  }
  if (key == 's') {// interactable
    switch(p) {
    case HELP:    
    case START:
      p = PAGE.HOSPITAL;
      break;
    case HOSPITAL:
      if (player.isOnDoor(door1) && door1.isOpen)
        p = PAGE.HALLWAY;
      break;
    case HALLWAY:
      if (player.isOnDoor(hall1)) {
        if (!presentAppear) {
          testchar = loadImage("Boss.gif");
          p = PAGE.SCHIZOPHRENIA;
          background(bg = loadImage("white.png"));
        } else {
          fill(0);
          rect(100, 10, 500, 100);
          fill(255);
          text("The door is locked. \nIs my room locked?", 110, 35);
          //lockedRoomDisplay = true;
          player.state = 2;
          player.reachx = hall3.xcor;
        }
    }
      
      if (player.isOnDoor(hall2)) {
        if (dementiaPuzzleComplete)
          p = PAGE.DEMENTIA2;
        else 
        p = PAGE.DEMENTIA;
        //p = dementiaPuzzleComplete ? PAGE.DEMENTIA2 : PAGE.DEMENTIA;
        p.resetPage();
        dementiaText = "Greetings. I am L.";
        decayVar = 1;
      }  
      if (player.isOnDoor(hall3))
        p = PAGE.HOSPITAL;
      break;
    case DEMENTIA2:
      dementiaPuzzleComplete = true;
    case DEMENTIA:
      //if(player.isNearChar(ocdnpc)) {} //DIALOGUE
      if (player.isOnDoor(dementia1))
        p = PAGE.HALLWAY;
      if (p.getNum() < p.getArrLen() - 1 && player.getXcor() > 75 && 
        player.getXcor() < 165 && player.getYcor() < 170)
        dementiaText = p.getNextString();
      break;
    case DEMENTIA_PUZZLE:
      // NONE 
      break;
    case OCD:
      player.toHide(false);
      if (presentAppear && player.getXcor() < 41 && player.getYcor() < 269)
        presentAppear = false;
      
      if (player.isOnDoor(hall3)) {
        player.setX((int)hall2.xcor);
        p = PAGE.HALLWAY;
      }
      break;
    case SCHIZOPHRENIA:
      //sczDisplay = true;
      for (NPC n : sczNPC)
        if (player.isNearChar(n)) {
          rect (n.getXcor(), n.getYcor() - 145, 150, 30, 18, 18, 18, 18);
          rect (n.getXcor(), n.getYcor() - 110, 150, 30, 18, 18, 18, 18);
          rect (n.getXcor(), n.getYcor() -  75, 150, 30, 18, 18, 18, 18);
          rect (n.getXcor(), n.getYcor() -  40, 150, 30, 18, 18, 18, 18);
        }
          
    
    break;
    default:
      System.out.println("unrecongized input (p:" + p + ")");
    }
    //if (player.onItem == true)
  }
  if (key == 'k' && biSolution != null) {    // ANSWER KEY FOR DEMENTIA_PUZZLE
    for (String b : biSolution)
      System.out.print(b + " ");
    System.out.println();
  }

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
    HOSPITAL("Greetings", "The tentacles spoke to me, ask what I wanted to be. \nTo be weak I said, to be flawed, \nvulnerable.", 
      "To perceive weakness in others \nnot to exploit but to protect.", 
      "To be a guide, \nto be a teacher.", "", "Welcome to LET ME OUT\nand enjoy the learning experience!"), 
    HALLWAY("Do we want to go in?"), 
    DEMENTIA("This is messy", "This pile is driving me \ncrazy... I feel an urge\n to sort ", 
      "...", "Now that it's sorted, I feel so much better"), 
    DEMENTIA_PUZZLE("Move pieces \n   into order"), 
    DEMENTIA2("CONGRATULATIONS. Mission Complete"), 
    OCD(),
    SCHIZOPHRENIA();

  int pageNum;
  String[] arr;
  boolean delay;
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
  void stallIfDialogue() {
    if (pageNum == 0 || delay)
      return;
    try {
      delay = true;
      if (pageNum < arr.length)
        Thread.sleep(2000);
      delay = false;
     }  catch (Exception ignored) {} 
  }
}

class biBox implements Comparable<biBox> {  // for DEMENTIA_PUZZLE class
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
