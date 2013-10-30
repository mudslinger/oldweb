class Pager extends MovieClip{
		function onRelease(){
			if(this._parent.down){
				this._parent.slideUp();
			}else{
				this._parent.slideDown();
			}
			
		}
}