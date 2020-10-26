package com.jkgh.jvm.parsing.types {
	
	
	import flash.utils.ByteArray;
	import com.jkgh.jvm.parsing.parsers.ConstantEntryParser;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	
	public class StringConstantEntry extends ConstantEntry {
	
		private var index:int;
	
		public function StringConstantEntry(dataInputStream:ByteArray) {
			index = dataInputStream.readShort();
		}
	
		override public function getTag():int {
			return ConstantEntryParser.CONSTANT_STRING;
		}
	
		public function getIndex():int {
			return index;
		}
	
		override public function getByPush(frame:FrameExecutionContext):void {
			throw new Error("String constant pool entry cannot be obtained. Use its UTF8 entry instead.");
		}
	
		override public function getJVMValue():Object {
			throw new Error("String constant pool entry cannot be obtained. Use its UTF8 entry instead.");
		}
	
	}
}
