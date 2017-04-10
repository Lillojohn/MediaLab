interface ICollidable {
  float getPositionX();
  float getPositionY();
  int getWidth();
  int getHeight();
  void subscribeToCollidableObjects();
}