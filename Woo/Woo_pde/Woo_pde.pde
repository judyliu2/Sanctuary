//~~~~~~~~~Tracking Vars~~~~~~~~~~~~~~~
PAGE p = PAGE.START;    //DEMENTIA2
User player;
NPC witch;
NPC haku;

//~~~~~~~~~~~~~~doors~~~~~~~~~~~~~~~~~~
Door door1 = new Door(true); //p = HOSPITAL to HALLWAY
Door hall1 = new Door(35, 230, 70, 150, false); //p = HALLWAY to SCHIZOPHRENIA
Door hall2 = new Door(270, 230, 70, 150, true); //p = HALLWAY to DEMENTIA
Door hall3 = new Door(520, 230, 70, 150, true); //p = HALLWAY to HOSPITAL (OCD)
Door dementia1 = new Door(270, 210, 70, 150, true); //p = DEMENTIA to HALLWAY

//~~~~~~~~~~~~~~images~~~~~~~~~~~~~~~~~
PImage testchar;
PImage witchchar;
PImage hakuchar;
PImage doorClosed;
PImage doorOpen;
PImage bg;    // use this for universal background image
PImage explainBG;
PImage present;
NPC[] sczNPC;
NPC sczCurr;    // current NPC selection in scz room
ArrayList<Item> objectsToClean;

//~~~~~~~~~Rooms~~~~~~~~~~~
Room dementia;

String dementiaText = "";
String dementia2Text = "";
String hakuText = "";
String lockedRoomText = "";
String hospitalText = "Well hello there";
float decayVar = 1;
boolean bx;
boolean by;

//Germophobia
boolean puzzle2Solved = p == PAGE.DEMENTIA2;

//for Help button
boolean overBox = false;
boolean locked = false;
boolean overExit = false;

ArrayList<biBox> dementiaBox;  // p = DEMENTIA_PUZZLE;
ArrayList<String> biSolution;  // p = DEMENTIA_PUZZLE;
int biPick = 0;               // p = DEMENTIA_PUZZLE;
boolean biClicked = false;    // p = DEMENTIA_PUZZLE;
int biXOffset;        // p = DEMENTIA_PUZZLE;
boolean lockedRoomDisplay = false;
boolean dementiaPuzzleComplete = false;
boolean loadOCD = (p == PAGE.DEMENTIA2 || p == PAGE.OCD);
boolean disableControls = false;
boolean presentAppear = p == PAGE.DEMENTIA2;
boolean isHaku = p == PAGE.DEMENTIA2;
int sczVar = 0;        // number of correct answers in scz  0=none  4=all
int counter = 2; //counts beats for Dementia2 dialogue

void setup() {
  size(640, 360); // Sets the screen to be 640 x 360 (L X H)
  textAlign(LEFT);
  bg = loadImage("startPage.jpg");
  background(bg);
  sczNPC = new NPC[] {
    new NPC(loadImage("DNchibi.png"), 20, 260, "Which one is the real me?", 
      new String[] {"Is it me?", "Is it me??", "How about me?", "then it is you"}, 1), 
    new NPC(loadImage("DNchibi.png"), 170, 260, "What is my name?", 
      new String[] {"Haku", "Pandora", "Yubaba", "Light"}, 3), 
    new NPC(loadImage("DNchibi.png"), 320, 260, "What is Reddit's mascot", 
      new String[] {"Snoo", "Reddit Blue", "Supreme Godess", "Trick Question: None"}, 0), 
    new NPC(loadImage("DNchibi.png"), 470, 260, "QQ", 
      new String[] {"AA", "BB", "CC", "DD"}, 1)
  };
  objectsToClean = new ArrayList<Item>();
  objectsToClean.add(new Item(loadImage("roach.gif"), 30, 200, 160, 160));
  objectsToClean.add(new Item(loadImage("garbage1.png"), 80, 200, 100, 140 ));
  objectsToClean.add(new Item(loadImage("poop.png"), 100, 310, 120, 70));
  objectsToClean.add(new Item(loadImage("roach.gif"), 140, 200, 160, 160));
  objectsToClean.add(new Item(loadImage("roach.gif"), 200, 200, 160, 160));
  objectsToClean.add(new Item(loadImage("garbage1.png"), 240, 200, 100, 140 ));
  objectsToClean.add(new Item(loadImage("poop.png"), 280, 310, 120, 70));
  objectsToClean.add(new Item(loadImage("roach.gif"), 300, 200, 160, 160));
  objectsToClean.add(new Item(loadImage("poop.png"), 400, 310, 120, 60));
  objectsToClean.add(new Item(loadImage("poop.png"), 440, 310, 120, 60));
  objectsToClean.add(new Item(loadImage("garbage1.png"), 500, 200, 100, 140 ));
  objectsToClean.add(new Item(loadImage("garbage1.png"), 550, 200, 100, 140 ));

  witch = new NPC(loadImage("yubaba.png"), 350, 260);
  haku = new NPC(loadImage("haku.png"), 175, 115);
  doorClosed = loadImage("doorClosed.gif");
  doorOpen = loadImage("doorOpen.gif");
  door1.setLocation("HALLWAY");
  testchar = loadImage("yubaba.png");
  explainBG = loadImage("DementiaRoom.png");
  player = new User(true);
  player.location = "START";
  present = loadImage("present.png");
  //fill(153, 102, 255);
  //text("Welcome to \n    Our Asylum", 75, 105);
  stroke(255);
  // rect(rectX, rectY, rectXSize, rectYSize);
  // rect(150, 225, 90, 50, 18, 18, 18, 18);
  // rect(400, 225, 90, 50, 18, 18, 18, 18);
  fill(0);

  textFont(createFont("SourceCodePro-Regular.ttf", 24));
  fill(0);
  text("Click to start", 80, 320);
  dementia = new DementiaRoom();
}

void draw() {
  update();
  player.move();
  player.display();
  if (player.location != "START") {
    fill(255);
    rect(550, 20, 75, 40, 18, 18, 18, 18); //Help button
    fill(0);    // wordColor
    text("Help", 558, 45);
    overBox = overRect(550, 20, 75, 40); //if help is clicked
    // if exit is clicked player is moved back to previous map
    overExit = overRect(570, 300, 40, 40);
  }
}

void update() {
  if ( overRect(550, 20, 75, 40)) {
    overBox = false;
    overExit = false;
  } else
    overBox = overExit = false;    // so overBox and overExit are always false???
}
int kk = 0;
void mousePressed() {
  // HELP BUTTON
  if (overExit)  //return to previous page
    p = (p == PAGE.DEMENTIA_PUZZLE) ? PAGE.DEMENTIA : PAGE.HALLWAY;
  if (overBox) {
    if (player.location != "START")
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
    p = PAGE.EXPLAIN;
    break;
  case EXPLAIN:
    if (decayVar > .5) {
      background(bg = loadImage("white.png"));
      decayVar -= 0.01; 
      tint(255, (int) (255 * decayVar));
      image(loadImage("startPage.jpg"), 0, 0);
    } else if (decayVar <= .5 && decayVar > 0) {
      background(bg = loadImage("white.png"));
      decayVar -= 0.01; 
      tint(255, 255 - (int) (255 * decayVar));
      image(loadImage("DementiaRoom.png"), 0, 0);
    } else {
      background(bg = explainBG);
      fill(255);
      text("The following RPG game is based on a 2001 Japanese\n" +
      "animated fantasy movie written and directed by Hayao Miyazaki.\n" +
      "The creators of this game highly recommends you to watch/ rewatch\n" +
      "this movie. So without furture ado...\n\nEnjoy!", 0, 40); 
    }
  break;
  case HOSPITAL:
    background(bg = loadImage("helpPage.png"));
    player.location = "HOSPITAL";
    //fill(150, 20, 0);
    //if (p.getNum() < p.getArrLen()) {

    fill(0);
    rect(100, 10, 500, 100);
    
    fill(255);
    text(hospitalText, 110, 35);
    player.toHide(false);
    door1.displayDoor();
    break;
  case HOSPITAL2:
    background(bg = loadImage("helpPage.png"));
    player.location = "HOSPITAL2";
    witch.x = 340;
    witch.y = 220;
    witch.lengthh = 150;
    witch.widthh = 150;
    witch.display2();

    fill(0);
    rect(100, 10, 500, 100);
    fill(255);
    if (!puzzle2Solved) 
      text("Disgusting! Somebody sacked my \nroom! Hurry and clean it!", 110, 35);
    else
      text("Hmph, you may now proceed.", 110, 35);

    for (Item trash : objectsToClean)
      trash.display();
    
    for (int i = 0; i < objectsToClean.size(); i++)
      if (mouseX> objectsToClean.get(i).x && mouseX< objectsToClean.get(i).x+ objectsToClean.get(i).wdth && mouseY> objectsToClean.get(i).y && mouseY<objectsToClean.get(i).y+objectsToClean.get(i).hght)
        objectsToClean.remove(i);
    
    if (objectsToClean.isEmpty())
      puzzle2Solved = presentAppear = true;

    if (puzzle2Solved)
      door1.displayDoor();
    break;
  case HALLWAY:
    player.location = "HALLWAY";
    player.baseY = 280; //Keeps the user on the ground
    background(bg = loadImage("Golden hallway.png"));
    if (lockedRoomDisplay) {
      fill(0);
      rect(100, 10, 500, 100);
      if (isHaku)
        fill(175, 238, 238);
      else
        fill(255);
      text(lockedRoomText, 110, 35);
      if (player.getXcor() > 300)
        lockedRoomDisplay = false;
    }
    if (dementiaPuzzleComplete) {
      fill(255, 0, 0);
      textFont(createFont("SourceCodePro-Regular.ttf", 12));
      text("Obsessive\n Compulsive\nDisorder", 525, 280);
      textFont(createFont("SourceCodePro-Regular.ttf", 24));
    }
    if (puzzle2Solved) {
      fill(255, 0, 0);
      textFont(createFont("SourceCodePro-Regular.ttf", 12));
      text("Dementia", hall2.xcor + 5, 280);
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
    if (player.location == "DEMENTIA_PUZZLE") {
      dementia.startTask();
      dementia.drawMe();
      String text = "Organize the cards in alphabetical order"; // maybe put instructions of how the user can move the character
      fill(255);
      text(text, 40, 80);
      //sorting animation
    } else {
      background(bg = loadImage("helpPage.png"));
      fill(250);
      text("Keys: \n W - Jump \n S - Walk through doors or \n" + 
          "interact with others \n A - Move left \n D - Move right", 40, 80);
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

    haku.display();
    //ocdnpc.display(100,100);

    fill(0, 100, 0);
    rect(15, 270, 100, 15);     // left platform
    fill(127, 255, 0);
    rect(130, 200, 100, 15);    // mid platform

    if (player.getXcor() < 65 && player.getYcor() < 280)
      player.baseY = 200;
    else 
      player.baseY = 280;    
    if (player.getXcor()>75 && player.getXcor()<165 && player.getYcor()<170 && !isHaku) {
      fill(12, 23, 34);
      rect(290, 20, 340, 120, 0, 18, 0, 18);    // box text
      if (dementiaText.equals("Greetings, Yubaba-sama.\nHow can I help you?"))
        fill(175, 238, 238);  //turquoise
      else
        fill(255);            //white
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
      if (decayVar == 1)
        try {
          Thread.sleep(50);
        } catch(Exception ignored) { }
        decayVar -= 0.001;
      
      disableControls = true;
      player.state = 2;
      player.reachx = dementia1.xcor ;
      if (player.getXcor() == dementia1.xcor)
        p = PAGE.HALLWAY;
      decayVar = 1;
    }
    fill(12, 23, 34);
    rect(15, 270, 100, 15);     // left platform
    rect(130, 200, 100, 15);    // mid platform

    rect(260, 20, 370, 120, 0, 18, 0, 18);    // box text
    fill(255);
    if (++counter == 3){
      dementia2Text = p.getNextString();
      counter = 0;
    }
    text(dementia2Text, 265, 45);
    try{
      Thread.sleep(500);
    } catch(InterruptedException ignored){}
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
      player.toHide(true);
      decayVar -= 0.01;
      player.setThickness(120);
      if (decayVar > 0) {
        //player.toHide(true);
        tint(255, 255 - (int) (255 * decayVar));
        image(loadImage("black.png"), 0, 0);
      } else {
        player.toHide(false);
        tint(255, 255);
        background(bg = loadImage("spirited_away.jpg"));
        disableControls = false;
        testchar = loadImage("haku.png");
        loadOCD = false;
      }
    } else {
      dementia.drawMe();
      fill(0, 100, 0);
      rect(65, 270, 100, 15);     // left platform
      fill(127, 255, 0);
      rect(180, 200, 120, 15);    // mid platform
      if (player.getXcor() < 115 && player.getYcor() < 280)
        player.baseY = 200;
      else 
      player.baseY = 280;    
      if (player.getXcor()>25 && player.getXcor()<165&& player.getYcor()<170)
        player.baseY = 120;
      
      hall2.displayDoor();
      fill(0);
      if (presentAppear || !puzzle2Solved) {
        rect(100, 10, 500, 100);
        fill(175, 238, 238);
      }
      if (presentAppear) {
        image(present, 20, 160, 100, 100);
        text("I need to see Chihiro. \n I should give her something. \n That present should do.", 110, 35);
      } else if (!presentAppear && !puzzle2Solved)
        text(hakuText, 110, 35);
    }
    break;
  case SCHIZOPHRENIA:
    if (decayVar > 0) {
      decayVar -= 0.01;
      tint(255, 255 - (int) (255 * decayVar));
      image(loadImage("black.png"), 0, 0);
    } else {
      background(bg);
      player.toHide(false);
      if (sczVar < 4)
        for (NPC npp : sczNPC)
          npp.display();
      for (NPC n : sczNPC)
        if (player.isNearChar(n)) { 
          sczCurr = n;
          rect(200, 20, 450, 80);
          fill(250, 128, 114);
          if (n.hasQuestion) {
            text(n.getQuestion(), 210, 45);
            fill(0, 0, 220);
            rect (n.getXcor() - 2, n.getYcor() - 145 + n.curr * 35, 154, 36, 16, 16, 16, 16);
  
            fill(0);
            rect (n.getXcor(), n.getYcor() - 145, 150, 30, 18, 18, 18, 18);
            rect (n.getXcor(), n.getYcor() - 110, 150, 30, 18, 18, 18, 18);
            rect (n.getXcor(), n.getYcor() -  75, 150, 30, 18, 18, 18, 18);
            rect (n.getXcor(), n.getYcor() -  40, 150, 30, 18, 18, 18, 18);
            fill(255);
            text(n.getChoices(0), n.getXcor() + 15, n.getYcor() - 123);
            text(n.getChoices(1), n.getXcor() + 15, n.getYcor() - 88);
            text(n.getChoices(2), n.getXcor() + 15, n.getYcor() - 53);
            text(n.getChoices(3), n.getXcor() + 15, n.getYcor() - 18);
            fill(0);
          } else {
            text("Question Solved", 210, 45);
            continue;
          }
        }
        if (sczVar >= 4)
          hall3.displayDoor();
      }
      break;
      case END_PRE:
        background(bg = loadImage("black.png"));
        player.toHide(true);
        fill(255);
        text("It is not our differences that divide us.\n" +
        "It is our inability to recognize, accept,\n" +
        "and celebrate those differences.\n- Audre Lorde", 50, 50);
      break;
      case END:
        background(bg = loadImage("end.jpg"));
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
    isHaku = true;
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
      p = PAGE.EXPLAIN;
    break;
    case EXPLAIN:
      p = PAGE.HOSPITAL;
    break;
    case HOSPITAL:
      hospitalText = p.getNextString();
      if (player.isOnDoor(door1) && door1.isOpen && p.getNum() == p.getArrLen())
        p = PAGE.HALLWAY;
      break;

    case HOSPITAL2:
      if (player.isOnDoor(door1) && door1.isOpen && puzzle2Solved )
        p = PAGE.HALLWAY;
      break;

    case HALLWAY:
      if (player.isOnDoor(hall1)) {
        if (!isHaku) {
          lockedRoomText = "The door is locked. \nIs my room locked?";
          lockedRoomDisplay = true;
          player.state = 2;
          player.reachx = hall3.xcor;
        } else if (!puzzle2Solved) {
          fill(175, 238, 238);
          lockedRoomText = "The door is locked. \nWhat am I here for?";
          lockedRoomDisplay = true;
        } else if (!presentAppear && puzzle2Solved) {
          player.toHide(true);
          decayVar = 1;
          testchar = loadImage("Boss.png");
          p = PAGE.SCHIZOPHRENIA;
          background(bg = loadImage("white.png"));
        } else {
          fill(175, 238, 238);
          lockedRoomText = "Not yet";
          lockedRoomDisplay = true;
        }
      }

      if (player.isOnDoor(hall2)) {
        if (!dementiaPuzzleComplete)
          p = PAGE.DEMENTIA;
        else if (dementiaPuzzleComplete && isHaku) 
          p = PAGE.OCD;
        else 
        p = PAGE.DEMENTIA;
        //p = dementiaPuzzleComplete ? PAGE.DEMENTIA2 : PAGE.DEMENTIA;
        p.resetPage();
        dementiaText = "Greetings, Yubaba-sama.\nHow can I help you?";
        hakuText = "How long have I been here";
        decayVar = 1;
      }  
      if (player.isOnDoor(hall3)) 
        p = dementiaPuzzleComplete ? PAGE.HOSPITAL2 : PAGE.HOSPITAL;
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
      hakuText = p.getNextString();
      if (presentAppear && player.getXcor() < 41 && player.getYcor() < 269) {
        presentAppear = false;
        hall1.isOpen = true;
      }
      if (player.isOnDoor(hall2) && !presentAppear
        && (hakuText.equals("I should see if Yubaba needs\nanything.") || puzzle2Solved)) {

        player.setX((int)hall2.xcor);
        p = PAGE.HALLWAY;
      }
      break;
    case SCHIZOPHRENIA:

      break;
    case END_PRE:    
      p = PAGE.END;
    break;
    case END:

      break;
    default:
      System.out.println("WARNING: unrecongized input (p:" + p + ")");
    }
  }
  if (p == PAGE.SCHIZOPHRENIA)
    switch(key) {
      case 'z':
        sczCurr.dec(sczCurr);
      break;
      case 'x':
        sczCurr.inc(sczCurr);
      break;
      case '\n':
        sczCurr.isCorrect();
      break;
    }
  if (sczVar >= 4 && p != PAGE.END)
    p = PAGE.END_PRE;

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
}

enum PAGE {
  START(), EXPLAIN(),
    HELP("Where am I...", "Who am I...", "What am I...", "Why am I here..."), 
    HOSPITAL("What might your name be?", "I'm a collector of them. \nNames, I mean.", 
    "I like to keep everyone close. \nI feel more secure.", "You see, no one makes a mess \nwhen I know their names", 
    "And, once you've met someone, \nyou never really forget them.", "That being said, I should \ncheck on my name list", 
    "That being said, I should \ncheck on my name list", "Wouldn't want any of them \n*cough to go missing, would we?"), 
    HOSPITAL2(), 
    HALLWAY("Do we want to go in?"), 
    DEMENTIA("How distasteful", "This pile is a \nmess... I need to clean \nthis up", 
    "I'd hate to lose\nmy names", "Ko- nevermind,", "Wouldn't want him\ntouching my names anyway", "...", 
    "Now that it's sorted, I feel so much better"), 
    DEMENTIA_PUZZLE("Move pieces \n   into order"), 
    DEMENTIA2("So it's sorted. Hmph. \nCan't trust anyone these days", "That reminds me, I got\na new girl the other day", 
    "Ch- Sen was it", "I really do love names", "It's getting late, I need\nto get my beauty sleep", 
    "Wouldn't want to look \nlike my sister after all"), 
    OCD("I don't know how long \nI've been without a name.", "I still want one.", "Not 'Haku' but who I used \nto be", 
    "I feel weighted, drowned even", "My memory flees me", "My past...", "I can't remember", 
    "But no matter, my life is here", "I should see if Yubaba needs\nanything."), 
    SCHIZOPHRENIA(), END_PRE(),
    END("SYSTEM END");

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
  //void stallIfDialogue() {
  //  if (pageNum == 0 || delay)
  //    return;
  //  try {
  //    delay = true;
  //    if (pageNum < arr.length)
  //      Thread.sleep(2000);
  //    delay = false;
  //  }  
  //  catch (Exception ignored) {
  //  }
  //}
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
