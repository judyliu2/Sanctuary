int y;

void setup() {
  size(640, 360); // Sets the screen to be 640 x 360 (L X H)
  textFont(createFont("SourceCodePro-Regular.ttf", 60));
  textAlign(LEFT);
  background(loadImage("startPage.png"));
  frameRate(60);  // 60 fps
  
  fill(170);
  text("Welcome to \n    Our Asylum", 75, 105);
  stroke(255);
  // rect(rectX, rectY, rectXSize, rectYSize);
  rect(150, 225, 90, 50);
  rect(400, 225, 90, 50);
}

void draw() {
  
}
void mousePressed() {
  if( overRect(150, 225, 90, 50) ) {
    background(loadImage("helpPage.png"));
    fill(140);
    text("This is for \n   Game Start", 75, 105);
  } else if ( overRect(400, 225, 90, 50) ) {
    background(loadImage("helpPage.png"));
    fill(220);
    text("This is for \n   Help", 75, 105);
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

boolean overRect(int x, int y, int width, int height)  {
  return (mouseX>x && mouseX<x+width && mouseY>y && mouseY<y+height);
}
