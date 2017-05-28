class FileSort extends Task {
  PFont f;
  final String alpha = "ABCDEFGHIJKLM";
  final int[] betical = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13};
  File[] files;

  public FileSort() {
    super();
    task = "Sort those files!";
    hints = new String[3];
    hints[0] = "Heavier bubbles move to the right";
    hints[1] = "Compare two objects";
    hints[2] = "Swap if necessary";
    files = new File[4];
    files[0] = new File ("c", 120);
    files[1] = new File ("A", 160);
    files[2] = new File ("D", 200);
    files[3] = new File ("b", 240);
  }

  public int valueOf(String s) {
    s = s.toUpperCase();
    return betical[alpha.indexOf(s)];
  }

  public void swap (File[] docs, int a, int b) { //closer to animating sorting
    //simply swap their x coordinates
    int tempaX = docs[a].xcor;
    int tempbX = docs[b].xcor;
    
    int xchange = 1;
    int ychange = 1;
    

    int min = min(tempaX,tempbX);
    int max = max(tempaX, tempbX);
    int middle = abs(tempaX - tempbX)/2;
    displayAllFiles();
    

      
      while (docs[b].xcor < max ){ //when b has the minimum x cor
        
        if (docs[b].xcor < min + middle){
          docs[b].ycor += ychange;
          docs[a].ycor -= ychange;
        }
        else{
          docs[b].ycor -= ychange;
          docs[a].ycor += ychange;
        }
        
        docs[b].xcor += xchange;
        docs[a].xcor -= xchange;

        displayAllFiles();
       
      }
      
       
      
      while(docs[a].xcor < max){ //when a hasthe minimum x cor
        
        if (docs[a].xcor < min + middle){
          docs[a].ycor += ychange;
          docs[b].ycor -= ychange;
        }
        else{
          docs[a].ycor -= ychange;
          docs[b].ycor += ychange;
        }
        docs[a].xcor += xchange;
        docs[b].xcor -= xchange;
      
        displayAllFiles();
      }

        File temp2 = docs[a];
  
    docs[a] = docs[b];
    docs[b] = temp2;
  
    
   /* 
    File temp2 = docs[b];
    docs[b].xcor = docs[a].xcor;
    docs[a].xcor = tempbX;
    docs[b] = docs[a];
    docs[a] = temp2;
   */
  }

  public void displayAllFiles() {
    for (int i = 0; i < files.length; i ++) {
      files[i].drawFile();
    }
  }

  public void toDo() {
    if (player.x > 40){
      sort();
    }
  }
  public void sort(){
    for (int p = 0; p < files.length - 1; p++) {//num of passes
      displayAllFiles();
      for (int i = 0; i < files.length - 1; i++) {
        displayAllFiles();
        if (valueOf(files[i].firstChar) > valueOf(files[i + 1].firstChar)) {
          swap (files, i, i+ 1);
        }
      }
    }
    
    completed = true;
  }

  public Item complete() {
    return null;
  }
}

private class File {
  String title;
  String firstChar;
  int xcor;
  int ycor;
  int l; //for length
  int w; //for width

  public File(String str, int x) {
    title = str; 
    firstChar = title.substring(0, 1);
    xcor = x;
    ycor = 90;
    l = 40;
    w = 20;
  }

  public void drawFile() {
    //ycor += 10;
    fill(255);
    rect (xcor, ycor, w, l);
    fill(50);
    text( title, xcor, ycor, w, l);
  }
}