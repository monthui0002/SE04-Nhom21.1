package com.jkgh.jvm.runtime.execution {
	
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	import com.jkgh.jvm.runtime.PrimitiveDouble;
	
	public class JVMPrimitiveDouble extends JVMPrimitive {
	
		public static const INSTANCE:JVMPrimitiveDouble = new JVMPrimitiveDouble();
		
		override public function getWordSize():int {
			return 2;
		}
	
		override public function getByPush(from:FieldHolder, jvmField:JVMField, frame:FrameExecutionContext):void {
			var fieldValue:PrimitiveDouble = (PrimitiveDouble)(from.getFieldValue(jvmField));
			frame.pushDouble(fieldValue);
		}
	
		override public function getDefaultValue():Object {
			return PrimitiveDouble.ZERO;
		}
	
		override public function getDescriptor():String {
			return "D";
		}
	
		override public function performPop(frame:FrameExecutionContext):Object {
			return frame.popDouble();
		}
	
		public function toString():String {
			return getJavaName();
		}
		
		override public function getJavaName():String {
			return "double";
		}
	
		override public function performPush(frame:FrameExecutionContext, value:Object):void {
			frame.pushDouble((PrimitiveDouble)(value));
		}
	}
}
