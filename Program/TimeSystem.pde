class TimeSystem{

	private float _time;

	public TimeSystem(Game game){
		// Setup timer.
    	this._time = millis();
	}

	public int GetGameTime(){
		return  (int)(this._time / 1000.0);
	}
}