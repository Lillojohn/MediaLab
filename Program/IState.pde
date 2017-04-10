
interface IState {
  void update();
  void draw();
  void keyPressHandle(char key);
  void keyReleaseHandle(char key);
  void action(String action);
}