PFont f;
int y;

void setup() {
  size(640, 360); // Sets the screen to be 640 x 360 (L X H)
  f = createFont("SourceCodePro-Regular.ttf", 60);
  textFont(f);
  textAlign(LEFT);
  background(loadImage("startPage.png"));
  frameRate(60);
  
  
  fill(170);
  text("Welcome to \n    Our Asylum", 75, 105);
  stroke(255);
  // rect(rectX, rectY, rectXSize, rectYSize);
  rect(150, 225, 90, 50);
  rect(400, 225, 90, 50);
}

void draw() {
  
  if( mouseX < 50) {
    background(loadImage("helpPage.png"));
  } else if ( mouseY < 50 ) {
    background(loadImage("helpPage.png"));
  } else {
    background(loadImage("startPage.png"));
    fill(170);
    text("Welcome to \n    Our Asylum", 75, 105);
    stroke(255);
    // rect(rectX, rectY, rectXSize, rectYSize);
    rect(150, 225, 90, 50);
    rect(400, 225, 90, 50);
  }
}
