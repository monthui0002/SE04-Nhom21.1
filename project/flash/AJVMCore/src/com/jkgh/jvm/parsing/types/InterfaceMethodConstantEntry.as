package com.jkgh.jvm.parsing.types {
	
	
	import flash.utils.ByteArray;
	import com.jkgh.jvm.parsing.parsers.ConstantEntryParser;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	
	public class InterfaceMethodConstantEntry extends ReferenceConstantEntry {
	
		public function InterfaceMethodConstantEntry(dataInputStream:ByteArray) {
			super(dataInputStream);
		}
	
		override public function getTag():int {
			return ConstantEntryParser.CONSTANT_INTERFACEMETHOD;
		}
	
		override public function getByPush(frame:FrameExecutionContext):void {
			throw new Error("Interface method constant pool entry cannot be obtained.");
		}
	
		override public function getJVMValue():Object {
			throw new Error("Interface method constant pool entry cannot be obtained.");
		}
	
	}
}
