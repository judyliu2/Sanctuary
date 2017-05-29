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
//PImage dnChibi;
PImage doorClosed;
PImage doorOpen;
PImage bg;    // use this for universal background image

String bipolarText;
int decayVar;

void setup() {
  size(640, 360); // Sets the screen to be 640 x 360 (L X H)
  textAlign(LEFT);
  bg = loadImage("startPage.png");
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
int i = 0;
void mousePressed() {
  System.out.printf("%02d-%-8s (%03.0f,%03.0f)\n", i++%100, p, player.x, player.y);
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
      image(doorClosed, door1.getXcor(), door1.getYcor(), door1.getWidth(), 
                    door1.getLength());
      if (player.isOnDoor(door1)) 
        image(doorOpen, 460, 240, 140, 120);
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
    fill(12,23,34);
    rect(15, 270, 100, 15);     // left platform
    rect(130, 200, 100, 15);    // mid platform
    
    if (player.getXcor() < 65 && player.getYcor() < 280)
      player.baseY = 200;
    else 
      player.baseY = 280;    
    if (player.getXcor()>75 && player.getXcor()<165 && player.getYcor()<170) {
      rect(290, 20, 340, 120, 0, 18, 0, 18);    // box text
      fill(255);
      text(bipolarText, 295, 45);
      player.baseY = 120;
      
      if (bipolarText.equals("...")) {
        PImage img = loadImage("white.png");
        img.loadPixels();
        decayVar -= 0.1;
        for (int x = 0; x < img.width; x++) 
          for (int y = 0; y < img.height; y++ ) {
            int loc = x + y*img.width;
            // Calculate amount to change+constaint for brightness based on time
            float delta = 255 * decayVar;
            
            img.pixels[loc] = color(delta * red(img.pixels[loc]),
                delta * green(img.pixels[loc]), delta * blue(img.pixels[loc]));
          }
        if (decayVar == 0)
          p = PAGE.BIPOLAR_PUZZLE;
      }
    }
    break;
    case BIPOLAR_PUZZLE:
      bg = loadImage("raichu.gif");
      player.baseY = 280;
    break;
  }
}

boolean overRect(int x, int y, int width, int height) {
  return (mouseX>x && mouseX<x+width && mouseY>y && mouseY<y+height);
}

public void keyPressed() { 
  if (key == 'w' && !player.up) { //move up/ jump
    player.up = true;
    player.dy = 17;          // upward velocity 
    player.gravity = -2;     // gravity unit
    player.y -= player.dy;   // make first change
  }
  if (key == 's') {// interactable
    switch(p) {
      case HELP:    case START:
      // EMPTY
      break;
      case HOSPITAL:
        if (player.isOnDoor(door1))
          //bg = loadImage(door1.nextLocation);
          p = PAGE.HALLWAY;
      break;
      case HALLWAY:
        if (player.isOnDoor(hall1))
          p = PAGE.HOSPITAL;
        if (player.isOnDoor(hall2)) {
          p = PAGE.BIPOLAR;
          p.resetPage();
          bipolarText = "(click 's' to start)";
          decayVar = 1;
        }  
        if (player.isOnDoor(hall3))
          p = PAGE.HOSPITAL;
      break;
      case BIPOLAR:
        if (player.isOnDoor(bipolar1))
          p = PAGE.HALLWAY;
        if (p.getNum() < p.getArrLen() - 1 && player.getXcor() > 75 && 
                        player.getXcor() < 165 && player.getYcor() < 170)
          bipolarText = p.getNextString();
        if (player.isOnDoor(door1)) {
            image(doorOpen, 460, 240, 140, 120);
            // TODO: Upon mission accomplish, leads a trophy room
        }
      break;
      case BIPOLAR_PUZZLE:
        // TODO add in movable puzzle
      break;
      default:
        System.out.println("unrecongized input");
    }
    //if (player.onItem == true)
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
    HOSPITAL("We are now in the hospital"), 
    HALLWAY("Do we want to go in?"), 
    BIPOLAR("Greetings. I am L.", "This is messy", "I feel an urge to sort ",
      "...", "Now that it's sorted, I feel so much better"),
    BIPOLAR_PUZZLE("Move pieces \n   into order");

  int pageNum;
  String[] arr;
  private PAGE(String... var) {
    pageNum = 0;
    arr = var;
  }
  String getNextString() {  
    return pageNum < arr.length ? arr[pageNum++] : "";  
  }
  int getNum() {            
    return pageNum;     
  }
  int getArrLen() {         
    return arr.length;  
  }
  void resetPage()  {       
    pageNum = 0;        
  }
}
