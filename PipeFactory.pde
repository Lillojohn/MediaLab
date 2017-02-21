class PipeFactory{
  
  private GroupOfPipes _groupOfPipes;
  private int _pipeCounter;
  
  public PipeFactory(GroupOfPipes groupOfPipes){
    _groupOfPipes = groupOfPipes;
    _pipeCounter = 0;
  }
  
  public void createPipe(){
    // Geeft aan GroupOfPipes aan dat een pipe gecreert moet worden.
    _groupOfPipes.addPipe(new Pipe(width, 0, 30, height));
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