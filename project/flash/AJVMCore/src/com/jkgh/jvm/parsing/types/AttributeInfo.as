package com.jkgh.jvm.parsing.types {
	
	import flash.utils.ByteArray;
	
	public class AttributeInfo {
		
		private var name:String;
		private var value:ByteArray;
	
		public function AttributeInfo(name:String, value:ByteArray) {
			this.name = name;
			this.value = value;
		}
	
		public function getName():String {
			return name;
		}
	
		public function getValue():ByteArray {
			return value;
		}
	
	}
}
