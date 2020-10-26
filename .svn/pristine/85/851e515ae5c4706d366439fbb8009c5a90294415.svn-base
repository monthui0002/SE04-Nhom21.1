package com.jkgh.jvm.parsing.types {
	
	
	import flash.utils.ByteArray;
	import com.jkgh.jvm.parsing.parsers.ConstantEntryParser;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	
	public class IntegerConstantEntry extends ConstantEntry {
	
		private var value:int;
	
		public function IntegerConstantEntry(dataInputStream:ByteArray) {
			value = dataInputStream.readInt();
		}
	
		override public function getTag():int {
			return ConstantEntryParser.CONSTANT_INTEGER;
		}
	
		public function getValue():int {
			return value;
		}
	
		override public function getByPush(frame:FrameExecutionContext):void {
			frame.pushInt(value);
		}
	
		override public function getJVMValue():Object {
			return value;
		}
	
	}
}
