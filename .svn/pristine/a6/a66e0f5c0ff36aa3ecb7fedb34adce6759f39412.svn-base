package com.jkgh.jvm.runtime.execution {
	
	import com.jkgh.jvm.runtime.PrimitiveFloat;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	
	public class JVMPrimitiveFloat extends JVMPrimitive {
	
		public static const INSTANCE:JVMPrimitiveFloat = new JVMPrimitiveFloat();

		override public function getWordSize():int {
			return 1;
		}
	
		override public function getByPush(from:FieldHolder, jvmField:JVMField, frame:FrameExecutionContext):void {
			var fieldValue:PrimitiveFloat = (PrimitiveFloat)(from.getFieldValue(jvmField));
			frame.pushFloat(fieldValue);
		}
	
		override public function getDefaultValue():Object {
			return PrimitiveFloat.ZERO;
		}
	
		override public function getDescriptor():String {
			return "F";
		}
	
		override public function performPop(frame:FrameExecutionContext):Object {
			return frame.popFloat();
		}
	
		public function toString():String {
			return getJavaName();
		}
		
		override public function getJavaName():String {
			return "float";
		}
	
		override public function performPush(frame:FrameExecutionContext, value:Object):void {
			frame.pushFloat((PrimitiveFloat)(value));
		}
	}
}
