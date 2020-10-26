package com.jkgh.jvm.runtime.execution {
	
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	
	public class JVMPrimitiveByte extends JVMPrimitive {
	
		public static const INSTANCE:JVMPrimitiveByte = new JVMPrimitiveByte();

		override public function getWordSize():int {
			return 1;
		}
	
		override public function getByPush(from:FieldHolder, jvmField:JVMField, frame:FrameExecutionContext):void {
			var fieldValue:int = (int)(from.getFieldValue(jvmField));
			frame.pushByte(fieldValue);
		}
	
		override public function getDefaultValue():Object {
			return (int)(0);
		}
	
		override public function getDescriptor():String {
			return "B";
		}
	
		override public function performPop(frame:FrameExecutionContext):Object {
			return frame.popByte();
		}
	
		public function toString():String {
			return getJavaName();
		}
		
		override public function getJavaName():String {
			return "byte";
		}
	
		override public function performPush(frame:FrameExecutionContext, value:Object):void {
			frame.pushByte((int)(value));
		}
	}
}
