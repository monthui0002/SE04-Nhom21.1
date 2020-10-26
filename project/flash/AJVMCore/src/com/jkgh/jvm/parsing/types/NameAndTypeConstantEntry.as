package com.jkgh.jvm.parsing.types {
	
	
	import flash.utils.ByteArray;
	import com.jkgh.jvm.parsing.parsers.ConstantEntryParser;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	
	public class NameAndTypeConstantEntry extends ConstantEntry {
	
		private var nameIndex:int;
		private var descriptorIndex:int;
	
		public function NameAndTypeConstantEntry(dataInputStream:ByteArray) {
			nameIndex = dataInputStream.readShort();
			descriptorIndex = dataInputStream.readShort();
		}
	
		public function getNameIndex():int {
			return nameIndex;
		}
	
		public function getDescriptorIndex():int {
			return descriptorIndex;
		}
	
		override public function getTag():int {
			return ConstantEntryParser.CONSTANT_NAMEANDTYPE;
		}
	
		override public function getByPush(frame:FrameExecutionContext):void {
			throw new Error("NameAndType constant pool entry cannot be obtained.");
		}
		
		override public function getJVMValue():Object {
			throw new Error("NameAndType constant pool entry cannot be obtained.");
		}
	}
}
