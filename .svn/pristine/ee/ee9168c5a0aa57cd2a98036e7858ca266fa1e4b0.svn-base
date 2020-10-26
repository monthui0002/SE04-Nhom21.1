package com.jkgh.jvm.runtime.execution {
	
	import com.jkgh.jvm.runtime.PrimitiveLong;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	
	public class JVMPrimitiveLong extends JVMPrimitive {
	
		public static const INSTANCE:JVMPrimitiveLong = new JVMPrimitiveLong();
		
		override public function getWordSize():int {
			return 2;
		}
	
		override public function getByPush(from:FieldHolder, jvmField:JVMField, frame:FrameExecutionContext):void {
			var fieldValue:PrimitiveLong = (PrimitiveLong)(from.getFieldValue(jvmField));
			frame.pushLong(fieldValue);
		}
	
		override public function getDefaultValue():Object {
			return PrimitiveLong.ZERO;
		}
	
		override public function getDescriptor():String {
			return "J";
		}
	
		override public function performPop(frame:FrameExecutionContext):Object {
			return frame.popLong();
		}
	
		public function toString():String {
			return getJavaName();
		}
		
		override public function getJavaName():String {
			return "long";
		}
	
		override public function performPush(frame:FrameExecutionContext, value:Object):void {
			frame.pushLong((PrimitiveLong)(value));
		}
	}
}
