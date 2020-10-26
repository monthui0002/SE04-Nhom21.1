package com.jkgh.jvm.runtime {
	
	public class PrimitiveFloat {
		
		public static const ZERO:PrimitiveFloat = new PrimitiveFloat(0);
		
		private var value:Number;
		
		public function PrimitiveFloat(v:Number = 0.0) {
			this.value = v;
		}
		
		public function getValue():Number {
			return value;
		}
		
		public function toString():String {
			return value+"f";
		}
	}
}
