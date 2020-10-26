package com.jkgh.jvm.runtime.execution {
	
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	
	public class JVMPrimitiveBoolean extends JVMPrimitive {
	
		public static const INSTANCE:JVMPrimitiveBoolean = new JVMPrimitiveBoolean();

		override public function getWordSize():int {
			return 1;
		}
	
		override public function getByPush(from:FieldHolder, jvmField:JVMField, frame:FrameExecutionContext):void {
			var fieldValue:Boolean = (int)(from.getFieldValue(jvmField)) != 0;
			frame.pushBoolean(fieldValue);
		}
	
		override public function getDefaultValue():Object {
			return (int)(0);
		}
	
		override public function getDescriptor():String {
			return "Z";
		}
	
		override public function performPop(frame:FrameExecutionContext):Object {
			return frame.popBoolean();
		}
	
		public function toString():String {
			return getJavaName();
		}
		
		override public function getJavaName():String {
			return "boolean";
		}
	
		override public function performPush(frame:FrameExecutionContext, value:Object):void {
			frame.pushBoolean((int)(value) == 1);
		}
	}
}
