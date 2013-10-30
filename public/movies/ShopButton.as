class ShopButton extends MovieClip{
	
	private var txtorg : String;
	private var base : MovieClip;
	public var link : String;
	function ShopButton(){

		base = this["btbase"];
		this.stop();
	}
	function setText(txt) : Void{
		this.txtorg = txt;
		this["buttonText"] .text = txt;
	}
	function onRollOver() {

		gotoAndStop(2);
		this["buttonText"] .text = txtorg;

	}
	function onRollOut() {
		gotoAndStop(1);
		this["buttonText"] .text = txtorg;
	}
	function onRelease(){
		
		getURL(_root._url.substring(0,_root._url.indexOf("/movies")) +  "/shop/"+link+".html");
	}
	
}