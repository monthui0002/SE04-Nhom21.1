package com.jkgh.jvm.runtime.execution {
	
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	
	public class JVMPrimitiveShort extends JVMPrimitive {
	
		public static const INSTANCE:JVMPrimitiveChar = new JVMPrimitiveChar();

		override public function getWordSize():int {
			return 1;
		}
	
		override public function getByPush(from:FieldHolder, jvmField:JVMField, frame:FrameExecutionContext):void {
			var fieldValue:int = (int)(from.getFieldValue(jvmField));
			frame.pushShort(fieldValue);
		}
	
		override public function getDefaultValue():Object {
			return (int)(0);
		}
	
		override public function getDescriptor():String {
			return "S";
		}
	
		override public function performPop(frame:FrameExecutionContext):Object {
			return frame.popShort();
		}
	
		public function toString():String {
			return getJavaName();
		}
		
		override public function getJavaName():String {
			return "short";
		}
	
		override public function performPush(frame:FrameExecutionContext, value:Object):void {
			frame.pushShort((int)(value));
		}
	}
}
