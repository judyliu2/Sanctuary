class FileSort extends Task {
  PFont f;
  final String alpha = "ABCDEFGHIJKLM";
  final int[] betical = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13};
  File[] files;
  //final int cTime = millis();
  //final float eTime = 1e-3*(cTime - ltime);
  public FileSort() {
    super();
    task = "Sort those files!";
    hints = new String[3];
    hints[0] = "Heavier bubbles move to the right";
    hints[1] = "Compare two objects";
    hints[2] = "Swap if necessary";
    files = new File[4];
    files[0] = new File ("c", 100);
    files[1] = new File ("A", 200);
    files[2] = new File ("D", 300);
    files[3] = new File ("b", 400);
  }

  
  public int valueOf(String s) {
    s = s.toUpperCase();
    return betical[alpha.indexOf(s)];
  }
  
  public int fileLength(){
    return files.length;
  }
  
  public File getFile(int i){
    return files[i];
  }
  public File[] getFiles(){
    return files;
  }

  public void swap (File[] docs, int a, int b) { //closer to animating sorting
    //simply swap their x coordinates
    float tempaX = docs[a].xcor;
    float tempbX = docs[b].xcor;
    
    float xchange = 0.2;
    float ychange = 0.2;
    

    float min = min(tempaX,tempbX);
    float max = max(tempaX, tempbX);
    float middle = abs(tempaX - tempbX)/2;
    //background(0);
    displayAllFiles();
    

      
      while (docs[b].xcor < max ){ //when b has the minimum x cor
        
        if (docs[b].xcor < min + middle){
          docs[b].ycor += ychange;// speed * eTime;//ychange
          docs[a].ycor -= ychange;//speed * eTime; //ychange
        }
        else{
          docs[b].ycor -= ychange;//speed * eTime;// ychange
          docs[a].ycor += ychange;//speed * eTime;    //ychange
        }
        
        docs[b].xcor +=  xchange;//speed * eTime; //xchange
        docs[a].xcor -= xchange;// speed * eTime; //xchange

        displayAllFiles();
       
      }
      
       
      
      while(docs[a].xcor < max){ //when a hasthe minimum x cor
        
        if (docs[a].xcor < min + middle){
          docs[a].ycor += ychange;//speed * eTime;
          docs[b].ycor -= ychange;//speed * eTime;
        }
        else{
          docs[a].ycor -= ychange;//speed * eTime;
          docs[b].ycor += ychange;//speed * eTime;
        }
        docs[a].xcor += xchange;//speed * eTime;
        docs[b].xcor -= xchange;//speed * eTime;
      
        displayAllFiles();
      }

        File temp2 = docs[a];
  
    docs[a] = docs[b];
    docs[b] = temp2;
    //background(0);
    
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
/*
  public void toDo() {
    if (player.x > 40){
      sort();
    }
  }
  */
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
  float xcor;
  float ycor;
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