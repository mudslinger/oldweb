class Background extends MovieClip{
	
	private var enb = false;
	public var buttons : Array;
	public function Background(){
		this._visible = false;
	}
	function toEnabled(name:String,shops:Object){
		this._visible = true;
		this.swapDepths(_root.getNextHighestDepth());
		var posy : Number = 60;
		var posx : Number = 10;
		var bc = 0;
		this.attachMovie(name,"title",bc++);
		this["title"].toTitled(3);
				buttons = new Array();
		for(var s in shops){
			this.attachMovie("button",shops[s]["id"],bc);
			buttons.push(this[shops[s]["id"]]);
			this[shops[s]["id"]]._x = posx;
			this[shops[s]["id"]]._y = posy;
			this[shops[s]["id"]].setText(shops[s]["name"]);
			this[shops[s]["id"]].link = shops[s]["id"];
			bc++;
			posx += 100;
			if(posx >= 410){
				posy += 25;
				posx = 10;
			}
			
		}

		this.enb = true;
		
	}
	
	function toDisabled(){
		this.enb = false;
		if(buttons != null){
			for(var s in buttons){
				buttons[s].removeMovieClip();
			}
		}
		this["title"].removeMovieClip();
		this._visible = false;
	}
	
	public function isEnabled() :Boolean{
		return enb;
	}
	
}