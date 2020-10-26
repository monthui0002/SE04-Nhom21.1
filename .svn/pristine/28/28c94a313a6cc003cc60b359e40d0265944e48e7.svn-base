package com.jkgh.jvm.runtime.classloading {
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	public class ByteArrayLoader {

		public static function load(url:String, onLoad:Function):void {
			var loader:URLLoader = new URLLoader();
			
			var onComplete:Function = function(e:Event):void {
				onLoad(loader.data);
			};
			
			var onError:Function = function(e:Event):void {
				onLoad(null);
			};
			
			loader.dataFormat = URLLoaderDataFormat.BINARY;
			loader.addEventListener(Event.COMPLETE, onComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onError);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
			loader.load(new URLRequest(url));
		}
	}
}