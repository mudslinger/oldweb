class Slider extends MovieClip{
	
	public var imageName : String = null;
	public var nextSlider : Slider;
	public var previousSlider : Slider;
	private var moving : Boolean = false;
	public var down : Boolean;
	
	function Slider(){
		this["loader"].loadMovie(_root._url.substring(0,_root._url.indexOf("/movies")) + "/images/"+imageName);
		this._x = 0 - this._width;
	}

	public function slideDown(){
		if(moving){
			return;
		}
		moving = true;
		if(!previousSlider.down){
			previousSlider.slideDown();
		}
		var obj = this;
		var org_x = this._x;
		var wt2 = setInterval(
			function(){
				obj._x += 10;
				if(obj._x >= 0){
					obj.down = true;
					obj.moving = false;
					clearInterval(wt2);
				}
			},1
		);	}
	
	public function slideUp(){
		if(moving){
			return;
		}
		moving = true;
		if(nextSlider.down){
			nextSlider.slideUp();
		}
		var obj = this;
		var org_x = this._x;
		var wt2 = setInterval(
			function(){
				obj._x -= 10;
				if(obj._x <= org_x - 630){
					obj.down = false;
					obj.moving = false;
					clearInterval(wt2);
				}
			},1
		);	}
	
	public function slideInit(){
		var obj = this;
 
		//ムービー
		var moved : Number = 0;
		var wt2 = setInterval(
			function(){
				obj._x +=10;
				if(obj._x >= 0){
					if(obj.nextSlider!= null){
						obj.nextSlider.slideInit();
					}
					clearInterval(wt2);
					obj.down = true;
				}
			},1
		);
	}
}