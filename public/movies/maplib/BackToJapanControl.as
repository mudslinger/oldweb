package maplib{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import com.google.maps.MapEvent;
	import com.google.maps.Map;
	import com.google.maps.Map3D;
	import com.google.maps.MapType;
	import com.google.maps.LatLng;
	import com.google.maps.LatLngBounds;
	import com.google.maps.ProjectionBase;
	import com.google.maps.controls.MapTypeControl;
	import com.google.maps.controls.ZoomControl;
	import com.google.maps.controls.PositionControl;
	import com.google.maps.controls.ControlPosition;
	import com.google.maps.controls.ControlBase;
	import com.google.maps.interfaces.IMap;
	public class BackToJapanControl extends  ControlBase{

		
		public function BackToJapanControl(){
			super(new ControlPosition(ControlPosition.ANCHOR_TOP_RIGHT, 7, 7));
		}
		
	  public override function initControlWithMap(map:IMap):void {
		createButton("日本地図に戻る", 0, 0, 
					 function(event:Event):void
					 { maplib.Top(Map3D(map).parent).hideGmap(); });
	  }

	  private function createButton(text:String,
									x:Number, 
									y:Number,
									callback:Function):void {
		var button:Sprite = new Sprite();
		button.x = x;
		button.y = y;
					
		var label:TextField = new TextField();
		label.text = text;
		label.x = 2;
		label.selectable = false;
		label.autoSize = TextFieldAutoSize.CENTER;
		var format:TextFormat = new TextFormat("Verdana");
		label.setTextFormat(format);
			
		var buttonWidth:Number = 100;
		var background:Shape = new Shape();
		background.graphics.beginFill(0xFFFFFF);
		background.graphics.lineStyle(1, 0x000000);
		background.graphics.drawRoundRect(0, 0, buttonWidth, 18, 4);
	
		button.addChild(background);
		button.addChild(label);
		button.addEventListener(MouseEvent.CLICK, callback);
					
		addChild(button);
	  }

	}
}