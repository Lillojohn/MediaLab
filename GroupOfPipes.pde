class GroupOfPipes{
  private ArrayList<Pipe> listOfPipes;
  private PipeFactory pipeFactory;
  
  public GroupOfPipes(){
    listOfPipes = new ArrayList<Pipe>();
    pipeFactory = new PipeFactory(this);
  }
  
  // Voegt een Pipe toe aan de arrayList 'listOfPipes'.
  public void addPipe(Pipe pipe){
    listOfPipes.add(pipe);
  }
  
  public void update(){
    // Update alle Pipes in de Arraylist 'listOfPipes'. 
    for(Pipe pipe : listOfPipes) {
      pipe.update();
    }
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