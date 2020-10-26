package com.jkgh.jvm.parsing.types {
	
	
	import com.jkgh.jvm.runtime.PrimitiveFloat;
	import flash.utils.ByteArray;
	import com.jkgh.jvm.parsing.parsers.ConstantEntryParser;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	
	public class FloatConstantEntry extends ConstantEntry {
	
		private var value:PrimitiveFloat;
	
		public function FloatConstantEntry(dataInputStream:ByteArray) {
			value = new PrimitiveFloat(dataInputStream.readFloat());
		}
	
		override public function getTag():int {
			return ConstantEntryParser.CONSTANT_FLOAT;
		}
	
		public function getValue():PrimitiveFloat {
			return value;
		}
	
		override public function getByPush(frame:FrameExecutionContext):void {
			frame.pushFloat(value);
		}
	
		override public function getJVMValue():Object {
			return value;
		}
	
	}
}
