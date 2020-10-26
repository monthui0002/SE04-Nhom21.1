package com.jkgh.jvm.runtime.execution.control {
	
	import com.jkgh.jvm.runtime.execution.JVMObject;
	
	
	public class ExceptionThrownResult extends InstructionExecutionResult {
	
		private var exceptionRef:JVMObject;
	
		public function ExceptionThrownResult(exceptionRef:JVMObject) {
			this.exceptionRef = exceptionRef;
		}
	
		public function getExceptionReference():JVMObject {
			return exceptionRef;
		}
	
	}
}
