package com.jkgh.jvm.parsing.types {
	
	import flash.utils.ByteArray;
	import com.jkgh.jvm.parsing.parsers.ConstantEntryParser;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	
	public class ClassConstantEntry extends ConstantEntry {
	
		private var nameIndex:int;
	
		public function ClassConstantEntry(dataInputStream:ByteArray) {
			this.nameIndex = dataInputStream.readShort();
		}
	
		override public function getTag():int {
			return ConstantEntryParser.CONSTANT_CLASS;
		}
	
		public function getNameIndex():int {
			return nameIndex;
		}
	
		override public function getByPush(frame:FrameExecutionContext):void {
			throw new Error("Class constant pool entry cannot be obtained.");
		}
	
		override public function getJVMValue():Object {
			throw new Error("Class constant pool entry cannot be obtained.");
		}
	
	}
}
