class PipeFactory{
  
  private GroupOfPipes _groupOfPipes;
  private int _pipeCounter;
  private Collision _collision;
  private Game _game;
  
  public PipeFactory(GroupOfPipes groupOfPipes, Collision collision, Game game){
    _groupOfPipes = groupOfPipes;
    _pipeCounter = 0;
    _collision = collision;
    _game = game;
  }
  
  public void createPipe(){
    // Geeft aan GroupOfPipes aan dat een pipe gecreert moet worden.
    _groupOfPipes.addPipe(new Pipe(width, 0, 30, height, _collision, _game));
  }
  
  public void update(){
    // Als de counter Reset wordt er een pipe aangemaakt.
    if(pipeDrawCounter()){
        createPipe();
    }    
  }
 
  // Houdt bij wanneer er een nieuwe Pipe gespawnt moet worden.
  public boolean pipeDrawCounter(){
    _pipeCounter++;
    
    if(_pipeCounter != 100){
      return false;
    }
      
    _pipeCounter = 0;
    return true;
  }
}