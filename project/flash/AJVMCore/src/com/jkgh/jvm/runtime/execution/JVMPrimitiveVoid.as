package com.jkgh.jvm.runtime.execution {
	
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	
	public class JVMPrimitiveVoid extends JVMPrimitive {
	
		public static const INSTANCE:JVMPrimitiveVoid = new JVMPrimitiveVoid();
		
		override public function getWordSize():int {
			return 0;
		}
	
		override public function getByPush(from:FieldHolder, jvmField:JVMField, frame:FrameExecutionContext):void {
		}
	
		override public function getDefaultValue():Object {
			return null;
		}
	
		override public function getDescriptor():String {
			return "V";
		}
	
		override public function performPop(frame:FrameExecutionContext):Object {
			return null;
		}
	
		public function toString():String {
			return getJavaName();
		}
		
		override public function getJavaName():String {
			return "void";
		}
	
		override public function performPush(frame:FrameExecutionContext, value:Object):void {
		}
	}
}
