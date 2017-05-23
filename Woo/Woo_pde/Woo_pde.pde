int y;
User player;
PImage testchar;

void setup() {
  size(640, 360); // Sets the screen to be 640 x 360 (L X H)
  textFont(createFont("SourceCodePro-Regular.ttf", 60));
  textAlign(LEFT);
  //background(loadImage("startPage.png"));
  background(0);
  frameRate(60);  // 60 fps

  fill(153, 102, 255);
  text("Welcome to \n    Our Asylum", 75, 105);
  stroke(255);
  // rect(rectX, rectY, rectXSize, rectYSize);
  //rect(150, 225, 90, 50, 18, 18, 18, 18);
  //rect(400, 225, 90, 50, 18, 18, 18, 18);
  fill(0);
  textFont(createFont("SourceCodePro-Regular.ttf", 24));    
  text("Click to start", 370, 300);
}

void draw() {
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
  background(loadImage("helpPage.png"));
  rect(100,10,500,100);
  fill(255);
  text("Where am I...", 110, 35);
}

boolean overRect(int x, int y, int width, int height) {
  return (mouseX>x && mouseX<x+width && mouseY>y && mouseY<y+height);
}

public void keyPressed(){ 
  if (key == CODED){
    if (keyCode == 'w'){ //move up
    }
    if (keyCode == 's'){ //move down
    }
    if (keyCode == 'a' && player.getXcor() > 0){ //move left
    }
    if (keyCode == 'd' && player.getXcor() < width){ //move right
    }
  }
}