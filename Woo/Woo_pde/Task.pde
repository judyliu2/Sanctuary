class Task {
  String task;
  int x;//location of task in room
  int y;//location of task in room
  int differential; //relative location of task in room
  String[] hints;//hints given when Task is initialized
  boolean completed;
  Item ret;

  public Task() {
    completed = false;
  }
  
  public void start(){
    
  }

  public Task( String[] help ) {
    this();
    hints = help;
  }
  

  public void toDo() {
  }

  public Item complete() {
    return null;
  }
}