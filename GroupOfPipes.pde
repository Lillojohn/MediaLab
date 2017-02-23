class GroupOfPipes{
  private ArrayList<Pipe> listOfPipes;
  private PipeFactory pipeFactory;
  
  public GroupOfPipes(Collision collision, Game game){
    listOfPipes = new ArrayList<Pipe>();
    pipeFactory = new PipeFactory(this, collision, game);
  }
  
  // Voegt een Pipe toe aan de arrayList 'listOfPipes'.
  public void addPipe(Pipe pipe){
    listOfPipes.add(pipe);
  }
  
  // Kijkt naar alle pipes als er iets vernietigd moet worden.
  public void clearPipes(){
    for(int i = 0; i < listOfPipes.size(); i++) {
       if(listOfPipes.get(i).getDestroy() == true){
         destroyPipe(i);
       }
    }
  }
  
  // Vernietigd 'Pipe'.
  public void destroyPipe(int index){
    listOfPipes.remove(index);
  }
  
  public void update(){
    // Update alle Pipes in de Arraylist 'listOfPipes'. 
    for(Pipe pipe : listOfPipes) {
      pipe.update();
    }
    
    // Zorgt ervoor dat pipes die niet in beeld zijn verwijdert wordt.
    clearPipes();
    
    // Update de 'pipeFactory'.
    pipeFactory.update();
  }
  
  public void drawObject(){
    // Drawt alle Pipes in de Arraylist 'listOfPipes'. 
    for(Pipe pipe : listOfPipes) {
      pipe.drawObject();
    }
  }
}