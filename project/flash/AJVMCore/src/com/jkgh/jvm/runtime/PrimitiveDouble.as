package com.jkgh.jvm.runtime {
	
	public class PrimitiveDouble {
		
		public static const ZERO:PrimitiveDouble = new PrimitiveDouble();
		
		private var value:Number;
		
		
		public function PrimitiveDouble(value:Number = 0.0) {
			this.value = value;
		}
		
		public function getValue():Number {
			return value;
		}
		
		public function toString():String {
			return value+"d";
		}
	}
}