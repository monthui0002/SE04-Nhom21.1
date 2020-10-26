package com.jkgh.jvm.tools {
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	public class Logger {
		
		public static var DEBUG:int = 1;
		public static var INFO:int = 2;
		public static var WARNING:int = 3;
		public static var SEVERE:int = 4;
		
		private static const LOGGERS:Dictionary = new Dictionary();
		
		private var name:String;
		private var indentString:String;
		private var level:int;
		private var appender:Function;
		
		public static function getLogger(name:String):Logger {
			var ret:Logger = LOGGERS[name];
			if (ret == null) {
				ret = new Logger(name);
				LOGGERS[name] = ret;
			}
			return ret;
		}
		
		public function Logger(name:String) {
			this.name = name;
			this.level = SEVERE;
			this.indentString = "   ";
			this.appender = trace;
		}

		private function log(objects:Array, at:int, indent:int = 0):void {
			if (level <= at) {
				var string:String = "";
				for (var i:int = 0; i<indent; ++i) {
					string += indentString;
				}
				for each (var object:Object in objects) {
					string += new String(object);
				}
				var t:int = getTimer();
				var ts:String = "          "+t+" ms";
				ts = ts.substring(ts.length-10, ts.length);
				appender("["+ts+" - "+name+"] "+string);
			}
		}

		public function debug(objects:Array, indent:int = 0):void {
			log(objects, DEBUG, indent);
		}
		
		public function info(objects:Array, indent:int = 0):void {
			log(objects, INFO, indent);
		}
		
		public function warning(objects:Array, indent:int = 0):void {
			log(objects, WARNING, indent);
		}
		
		public function severe(objects:Array, indent:int = 0):void {
			log(objects, SEVERE, indent);
		}
		
		public function setLevel(level:int):void {
			this.level = level;
		}
		
		public function setAppender(appender:Function):void {
			this.appender = appender;
		}
		
		public function setIndentString(s:String):void {
			this.indentString = s;
		}
	}
}
