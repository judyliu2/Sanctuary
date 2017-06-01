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
    bg = loadImage("DementiaRoom.png");
  }

  void drawMe() {
    background(bg);
    rect(270, 230, 70, 150);
    diffTasks[0].toDo();
  }
}