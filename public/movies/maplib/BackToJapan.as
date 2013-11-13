package maplib{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	public class BackToJapan extends MovieClip{
		public function Prefecture(){
			stop();
			
			addEventListener("mouseDown",onPress);
			addEventListener("mouseOver",onRollOver);
			addEventListener("mouseOut",onRollOut);
		}

		function onRollOver(event:MouseEvent){

		}
		function onRollOut(event:MouseEvent){
		}
		
		function onPress(event:MouseEvent){
			trace("yahoo");
			Top(this.parent).hideGmap();
		}
	}
}