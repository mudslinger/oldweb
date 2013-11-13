package maplib{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.google.maps.overlays.Marker;
	import com.google.maps.LatLng;
	import com.google.maps.LatLngBounds;
	import com.google.maps.overlays.MarkerOptions;
	public class Prefecture extends MovieClip{
		public var cmode = true;
		protected var lat:Number = 30;
		protected var lng:Number = 135;
		protected var zoom:Number = 9;
		protected var myMarkers:Array;
		protected var pref_codes:Array = [0];
		
	private var  activeOpts = new MarkerOptions (
		{
		  fillStyle: {
			color: 0xFF0000,
			alpha: 0.9
		  },
		  radius:9
		}
		);
	private var  inactiveOpts = new MarkerOptions (
		{
		  fillStyle: {
			color: 0xFF5500,
			alpha: 0.4
		  },
		  radius:6
		}
		);
		
		
		public function Prefecture(){
			stop();
			var pref:Prefecture = this;
			addEventListener("mouseDown",onPress);
			addEventListener("mouseOver",onRollOver);
			addEventListener("mouseOut",onRollOut);
		}
		function onRollOver(event:MouseEvent){
				this.parent.setChildIndex(this,this.parent.numChildren - 1);
				gotoAndStop(2);
			
		}
		function onRollOut(event:MouseEvent){
				gotoAndStop(1);
		}
		
		function onPress(event:MouseEvent){
				Top(this.parent).shops.filter(findMyShop).forEach(addMarkers);
				Top(this.parent).markers.forEach(inactiveStyle);
				if(myMarkers != null) myMarkers.forEach(activeStyle);
				var b:LatLngBounds = getViewArea();
				Top(this.parent).showGmapb(b);
		}
		function inactiveStyle(item:*, index:int, array:Array):void {
			if(item != null) item.setOptions(inactiveOpts);
			
		}
		function activeStyle(item:*, index:int, array:Array):void {
			item.setOptions(activeOpts);

		}
		function addMarkers(item:*, index:int, array:Array):void {
			if(this.myMarkers == null) myMarkers = new Array();
			myMarkers.push(Top(this.parent).markers[item["id"]]);
		}
		
		function getViewArea():LatLngBounds{
			//緯度
			var minLat:Number = 90;
			var maxLat:Number = 0;
			//経度
			var minLng:Number = 180;
			var maxLng:Number = 0;
			if(myMarkers == null){
				return new LatLngBounds(
									new LatLng(34,134),
									new LatLng(35,135)
				);
			}
			for each(var item:Marker in myMarkers){
				var ll:LatLng = item.getLatLng();
				if(minLat > ll.lat()){ minLat = ll.lat();}
				if(minLng > ll.lng()){ minLng = ll.lng();}
				if(maxLat < ll.lat()){ maxLat = ll.lat();}
				if(maxLng < ll.lng()){ maxLng = ll.lng();}
			}
			return new LatLngBounds(
									new LatLng(minLat,minLng),
									new LatLng(maxLat,maxLng)
			);
			
		}
		
		function findMyShop(item:*, index:int, array:Array):Boolean {
		  	for each(var p in pref_codes){
				if(item.pref_code == p) return true; 
			}
			return false;
		} 
	}
}