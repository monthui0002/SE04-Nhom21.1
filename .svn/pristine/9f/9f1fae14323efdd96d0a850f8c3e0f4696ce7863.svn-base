package com.jkgh.jvm.parsing.types {
	
	
	import com.jkgh.jvm.runtime.PrimitiveLong;
	import flash.utils.ByteArray;
	import com.jkgh.jvm.parsing.parsers.ConstantEntryParser;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	
	public class LongConstantEntry extends ConstantEntry {
	
		private var value:PrimitiveLong;
	
		public function LongConstantEntry(dataInputStream : ByteArray) {
			var u1:uint = dataInputStream.readUnsignedInt();
			var u0:uint = dataInputStream.readUnsignedInt();
			value = PrimitiveLong.newFromUints(u1, u0);
		}
	
		override public function getTag():int {
			return ConstantEntryParser.CONSTANT_LONG;
		}
	
		public function getValue():PrimitiveLong {
			return value;
		}
	
		override public function getByPush(frame:FrameExecutionContext):void {
			frame.pushLong(value);
		}
	
		override public function getJVMValue():Object {
			return value;
		}
	
	}
}
