package com.jkgh.jvm.runtime.execution {
	
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	
	public class JVMPrimitiveInteger extends JVMPrimitive {
	
		public static const INSTANCE:JVMPrimitiveInteger = new JVMPrimitiveInteger();

		override public function getWordSize():int {
			return 1;
		}
	
		override public function getByPush(from:FieldHolder, jvmField:JVMField, frame:FrameExecutionContext):void {
			var fieldValue:int = (int)(from.getFieldValue(jvmField));
			frame.pushInt(fieldValue);
		}
	
		override public function getDefaultValue():Object {
			return (int)(0);
		}
		
		override public function getDescriptor():String {
			return "I";
		}
	
		override public function performPop(frame:FrameExecutionContext):Object {
			return frame.popInt();
		}
	
		public function toString():String {
			return getJavaName();
		}
		
		override public function getJavaName():String {
			return "int";
		}
	
		override public function performPush(frame:FrameExecutionContext, value:Object):void {
			frame.pushInt((int)(value));
		}
	}
}
