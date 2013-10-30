class Prefecture extends MovieClip{
	private var org_x : Number;
	private var org_y : Number;
	private var bg : Background;
	private var lv :LoadVars;
	private var org_z: Number;
	public var cmode = true;
	public function Prefecture(){
		stop();
		var pref:Prefecture = this;
		org_x = this._x;
		org_y = this._y;
		org_z = this.getDepth();
		this.bg = _root["bg"];
		lv = new LoadVars();
		lv.onLoad = function(ok:Boolean){
			if(ok){
				var shops:Object = JSON.parse(this.shops);
				pref.bg.toEnabled(pref._name,shops);
			}
		}
	}
	public function toTitled(){
		this.cmode = false;
		gotoAndStop(3);
		_x = 20;
		_y = 10;
	}
	function onRollOver(){
		
		if(!bg.isEnabled()){
			this.swapDepths(_root.getNextHighestDepth());
			gotoAndStop(2);
		}

	}
	function onRollOut(){
			this.swapDepths(org_z);
			gotoAndStop(1);
	}
	
	function onPress(){
		if(!bg.isEnabled()){
			lv.load(_root._url.substring(0,_root._url.indexOf("/movies")) + "/shop/pref?code=" + this._name);
		}
	}
}