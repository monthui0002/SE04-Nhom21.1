package com.jkgh.jvm.parsing.types {
	
	
	import com.jkgh.jvm.parsing.parsers.ClassFlagParser;
	
	public class ClassInfo {
		private var fullyQualifiedClassName:String;
		private var fullyQualifiedSuperClassName:String;
		private var interfaceNames:Vector.<String>;
		private var flags:int;
	
		public function ClassInfo(fullyQualifiedClassName:String, fullyQualifiedSuperClassName:String, interfaceNames:Vector.<String>, flags:int) {
			this.fullyQualifiedClassName = fullyQualifiedClassName;
			this.fullyQualifiedSuperClassName = fullyQualifiedSuperClassName;
			this.interfaceNames = interfaceNames;
			this.flags = flags;
		}
	
		public function isAbstract():Boolean {
			return ClassFlagParser.hasAbstract(flags);
		}
	
		public function isInterface():Boolean {
			return ClassFlagParser.hasInterface(flags);
		}
	
		public function isPublic():Boolean {
			return ClassFlagParser.hasPublic(flags);
		}
	
		public function isSuper():Boolean {
			return ClassFlagParser.hasSuper(flags);
		}
	
		public function isFinal():Boolean {
			return ClassFlagParser.hasFinal(flags);
		}
	
		public function getClassName():String {
			return fullyQualifiedClassName;
		}
	
		public function getSuperClassName():String {
			return fullyQualifiedSuperClassName;
		}
	
		public function getInterfaces():Vector.<String> {
			return interfaceNames;
		}
	
	}
}
