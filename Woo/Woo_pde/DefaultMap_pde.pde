PFont f;
int y;
int c1 = 226;
int c2 = 204;

void setup() {
  size(640, 360); // Sets the screen to be 640 x 360 (L X H)
  f = createFont("SourceCodePro-Regular.ttf", 60);
  textFont(f);
  textAlign(LEFT);
  background(loadImage("startPage.png"));
  
  // background(0);  // Black background
  // noFill();       // no fill for background
  frameRate(60);  // 30 fps
    
  stroke(0, 153, 255);
  // line(startX, startY, endX, endY) 
  // line(0, height*0.33, width, height*0.33);
  
  stroke(255, 153, 0);
  for (int j = 0; j < 6; j+=2)
    for (int i = 10* j; i < 10 * j + 10; i++) {
      // background(0);  // Black background
      // rect(topLeftX, topLeftY, bottomRightX, bottomRightY)
      rect(i, i, width -2 * i, height -2* i);
    }
  fill(0);
  text("Welcome to \n    Our Asylum", 75, 105);
}

void draw() {
  
  
   stroke(c1, c2, 0);
   line(0, y, width, y);
  
   y++;
   if (y > height) {
     y = 0; 
     c1 = (c1 + 10) % 255;
     c2 = (c2 - 10) % 255;
   }
}