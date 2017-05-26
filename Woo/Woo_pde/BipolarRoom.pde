class BipolarRoom implements Room{
  int state;// state changes depending on which character is user
  Task[] diffTasks;
  NPC assignedChar;// char may show up
  int x;//of npc
  int y;//of npc
  PImage pic;
  
  public BipolarRoom(){
   state = 1;
   assignedChar = new NPC();//should be Manic Depressive char, will work on that
   diffTasks = new Task[4];
   diffTasks[0] = new FileSort();
  }
  
  void drawDoor(){
    
  }
  void drawMe(){
    
  }
  
  
}