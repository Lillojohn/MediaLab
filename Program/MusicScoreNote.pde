class MusicScoreNote extends GameObject{
  public MusicScoreNote(int xPosition, int yPosition, int widthImage, int heightImage, Game game) {
    super(xPosition, yPosition, widthImage, heightImage, game);
    _img = loadImage("Assets/NoteSmall.png");
    _img.resize(width, height);
  }
}