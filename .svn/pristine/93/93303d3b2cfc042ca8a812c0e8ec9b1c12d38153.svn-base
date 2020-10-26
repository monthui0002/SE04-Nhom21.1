package com.jkgh.jvm.parsing.types {
	
	
	import com.jkgh.jvm.parsing.parsers.ConstantEntryParser;
	import com.jkgh.jvm.runtime.PrimitiveDouble;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	
	import flash.utils.ByteArray;
	
	public class DoubleConstantEntry extends ConstantEntry {
	
		private var value:PrimitiveDouble;
	
		public function DoubleConstantEntry(dataInputStream:ByteArray) {
			value = new PrimitiveDouble(dataInputStream.readDouble());
		}
	
		override public function getTag():int {
			return ConstantEntryParser.CONSTANT_DOUBLE;
		}
	
		public function getValue():PrimitiveDouble {
			return value;
		}
	
		override public function getByPush(frame:FrameExecutionContext):void {
			frame.pushDouble(value);
		}
	
		override public function getJVMValue():Object {
			return value;
		}
	
	}
}
