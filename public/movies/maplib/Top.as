package maplib{
import flash.display.MovieClip;
import flash.events.Event;
import flash.geom.Point;
import flash.net.*;
import com.google.maps.LatLng;
import com.google.maps.LatLngBounds;
import com.google.maps.MapEvent;
import com.google.maps.MapMouseEvent;
import com.google.maps.MapType;
import com.google.maps.controls.*;
import com.google.maps.Map3D;
import com.google.maps.MapOptions;
import com.google.maps.View;
import com.google.maps.overlays.Marker;
import com.google.maps.overlays.MarkerOptions;
import com.google.maps.geom.Attitude;
import com.adobe.serialization.json.*;

public class Top extends MovieClip{
	var map:Map3D;
	var myMapOptions:MapOptions;
	var hash:Object = new Object();
	var ready = false;
	public var shops:Array;
	public var markers: Array = new Array();

	private var baseOpts = new MarkerOptions ({
										  strokeStyle:{
												thickness: 2,
												alpha: 1.0,
												color:0xffffff,
												pixelHinting: false
										  },
										  fillStyle: {
											 alpha: 0.4,
											color: 0xFF0000
										  },
											distanceScaling: false,
											draggable:false,
											hasShadow:false,
											radius:6
										})
	public function Top(){
		stop();
		map= new Map3D();
		
		map.key = "ABQIAAAAtxpvTklqZYxeE7thlJGlpBR5S9EJXKmK7-e_GZIBlC5I_zLj8RQdBkjYVA081UPcpSjnHNCMqpLsQg";
		map.setSize(new Point(400,380));
		map.addEventListener(MapEvent.MAP_READY, onMapReady);
		map.addEventListener(MapEvent.MAP_PREINITIALIZE, onPreInitialize);
		myMapOptions = new MapOptions();
		this.addChild(map);
		this.setChildIndex(map,0);
		
	}

public function showGmapb(lb:LatLngBounds):void{
	this.setChildIndex(map,this.numChildren - 1);
	if(ready) map.setCenter(lb.getCenter(),map.getBoundsZoomLevel(lb));
	if(!ready) map.addEventListener(MapEvent.MAP_READY, ssmap);
	function ssmap(event:Event):void {
		map.setCenter(lb.getCenter(),map.getBoundsZoomLevel(lb));
		ready = true;
	}
}


public function showGmap(lat:Number,lng:Number,zoom:Number):void{

if(ready) map.setCenter(new LatLng(lat,lng),zoom);
	if(!ready) map.addEventListener(MapEvent.MAP_READY, ssmap);
	function ssmap(event:Event):void {
		map.setCenter(new LatLng(lat,lng),zoom);
		ready = true;
	}
	this.setChildIndex(map,this.numChildren - 1);
	
}

public function hideGmap():void{
	this.setChildIndex(map,0);
}

function onPreInitialize(event:Event):void{
	myMapOptions.zoom = 9;
	myMapOptions.center = new LatLng(43.057967,141.35621);
	myMapOptions.mapType = MapType.NORMAL_MAP_TYPE;
	myMapOptions.viewMode = View.VIEWMODE_PERSPECTIVE;
	myMapOptions.attitude = new Attitude(0,20,0);
    map.setInitOptions(myMapOptions);

}
function onMapReady(event:Event):void {
	addShops();
	//map.addControl(new NavigationControl());
	map.addControl(new PositionControl());
	map.addControl(new ZoomControl());
	map.addControl(new BackToJapanControl());	
	ready = true;
}

function addShops(): void{
		
		var ul:URLLoader = new URLLoader();
		ul.dataFormat = URLLoaderDataFormat.TEXT;
		ul.addEventListener(Event.COMPLETE,fc);
		var dom:String = new LocalConnection().domain;
		if(hash == null){
			hash = new Object();
		}
		function fc(e:Event):void{

			var json:String = URLLoader(e.currentTarget).data;
			shops = JSON.decode(json);
			for each(var i in shops){
			baseOpts.tooltip = i["name"];
			var mk:Marker = new Marker(new LatLng(i["lat"],i["lng"]),baseOpts);
			hash[mk.getLatLng()] = new URLRequest(dom + "/shop/" + i["id"] + ".html");
			mk.addEventListener(MapMouseEvent.CLICK, 
								function (e:MapMouseEvent):void {
									navigateToURL(hash[e.target.getLatLng()],"_self");
								}	
			);
			//shops["marker"] = mk;
			markers[i.id] = mk;
			map.addOverlay(mk);
			}
			
		}
		ul.load(new URLRequest( dom + "/shop/all_shops"));
}

}
}