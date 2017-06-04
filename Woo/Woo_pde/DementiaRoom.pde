class DementiaRoom implements Room {
  int state;// state changes depending on which character is user
  Task[] diffTasks;
  NPC assignedChar;// char may show up
  int x;//of npc
  int y;//of npc
  PImage bg;

  public DementiaRoom() {
    state = 1;
    assignedChar = new NPC();//should be Manic Depressive char, will work on that
    diffTasks = new Task[4];
    diffTasks[0] = new FileSort();
    bg = loadImage("spirited_away.jpg");
  }

  void startTask() {
    diffTasks[0].start();
  }
  void drawMe() {
    //set a background
    background(bg);
    //draw a door
    rect(270, 230, 70, 150);
    diffTasks[0].toDo();
  }
}