class FileSort extends Task {
  PFont f;
  final String alpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  File[] files;
  //track pass and position
  int pass = 0;
  int pos = 0;
  //final int cTime = millis();
  //final float eTime = 1e-3*(cTime - ltime);
  public FileSort() {
    super();
    task = "Sort those files!";
    hints = new String[3];
    hints[0] = "Heavier bubbles move to the right";
    hints[1] = "Compare two objects";
    hints[2] = "Swap if necessary";
    //list of files
    files = new File[10];
    files[0] = new File ("B", 80);
    files[1] = new File ("u", 120);
    files[2] = new File ("b", 160);
    files[3] = new File ("b", 200);
    files[4] = new File ("l", 240);
    files[5] = new File ("e", 280);
    files[6] = new File ("S", 320);
    files[7] = new File ("o", 360);
    files[8] = new File ("r", 400);
    files[9] = new File ("t", 440);
  }


  public int valueOf(String s) {
    s = s.toUpperCase();
    return alpha.indexOf(s) + 1;
  }

  public int fileLength() {
    return files.length;
  }

  public File getFile(int i) {
    return files[i];
  }
  public File[] getFiles() {
    return files;
  }

  public void swap (File[] docs, int a, int b) { //closer to animating sorting
    //simply swap their x coordinates
    docs[b].reachx = docs[a].xcor;
    docs[b].dx = -1;
    docs[a].reachx = docs[b].xcor;
    docs[a].dx = 1;
    docs[b].state = 1;
    docs[a].state = 1;

    File temp2 = docs[a];

    docs[a] = docs[b];
    docs[b] = temp2;
  }

  public void displayAllFiles() {
    for (int i = 0; i < files.length; i ++) {
      files[i].drawFile();
    }
  }

  public void toDo() {
    sort();
  }

  public void sort() {
    if (pass == -1){
     return; 
    }
    displayAllFiles();
    if (pass < files.length) {//while still in reasonable num of passes
      if (files[pos].state == 0) {//if we're not moving
        //figure out next move in sorting
        if (pos >= files.length - 1) {
          pos = 0;
          pass += 1;
        } else {
          if (valueOf(files[pos].firstChar) > valueOf(files[pos + 1].firstChar)) {
            swap (files, pos, pos+ 1);
          }
          pos += 1;
        }
      }
    } else {
      completed = true;
    }
  }

  public Item complete() {
    return null;
  }
}

private class File {
  String title;
  String firstChar;
  float xcor;
  float ycor;
  int l; //for length
  int w; //for width
  float reachx;
  int dx;
  int state;

  public File(String str, int x) {
    title = str; 
    firstChar = title.substring(0, 1);
    xcor = x;
    ycor = 90;
    l = 40;
    w = 20;
    state = 0;
    reachx = 0;
    dx = 0;
  }

  public void drawFile() {
    if (state == 0) {
    }
    if (state == 1) {
      xcor += dx;
      if ((dx > 0) && (xcor > reachx)) {
        xcor = reachx;
        state = 0;
      } else if ((dx < 0) && (xcor < reachx)) {
        xcor = reachx;
        state = 0;
      }
    }
    fill(255);
    rect (xcor, ycor, w, l);
    fill(50);
    text( title, xcor, ycor, w, l);
  }
}