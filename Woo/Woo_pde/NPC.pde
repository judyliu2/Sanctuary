class NPC extends Character {
  boolean hasQuestion;
  String question;    // question of choice
  String[] choices;   // possible answer choices
  int ans;            // choices[ans] = desired answer
  int curr = 0;
  NPC(){
    super();
  }
  NPC(float a, float b){
    super();
    x = a;
    y = b;
  }
  NPC(PImage p, int a, int b){
    super(p, a, b);
    hasQuestion = false;
  }
  NPC(PImage p, int a, int b, String q, String[] cc, int a2){
    super(p, a, b);
    hasQuestion = true;
    question = q;
    choices = cc;
    ans = a2;
  }
  void display() {
    image(character, x, y, 80, 100);
    //image(character, x, y, 120, 100);
  }
  String getQuestion() {
    return hasQuestion ? question : "";
  }
  String getChoices(int i) {
    return hasQuestion && i < 5 && i >= 0 ? choices[i] : "";
  }
  
  void inc(NPC n) {
    if (!hasQuestion)
      return;
    fill(0);
    rect (n.getXcor() - 2, n.getYcor() - 145 + n.curr * 35, 154, 36, 16, 16, 16, 16);
    curr += (curr < 3) ? 1 : 0;
  }
  void dec(NPC n) {
    if (!hasQuestion)
      return;
    fill(0);
    rect (n.getXcor() - 2, n.getYcor() - 145 + n.curr * 35, 154, 36, 16, 16, 16, 16);
    curr -= (curr > 0) ? 1 : 0;
  }
  boolean isCorrect() {
    return isCorrect(curr);
  }
  boolean isCorrect(int sel) {
    return (hasQuestion && sel < 5 && sel >= 0) ? isCorrect(choices[sel]) : false;
  }
  boolean isCorrect(String selection) {
    if (!hasQuestion || !selection.equals(choices[ans]))
      return false;
    hasQuestion = false;
    sczVar++;      // answered another question correctly
    return true;
  }
}
