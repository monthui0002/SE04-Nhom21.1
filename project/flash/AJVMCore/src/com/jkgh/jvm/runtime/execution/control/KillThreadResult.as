package com.jkgh.jvm.runtime.execution.control {
	
	import com.jkgh.jvm.runtime.execution.JVMObject;
	
	public class KillThreadResult extends InstructionExecutionResult {
	
		private var abruptionCause:JVMObject;
		
		public function KillThreadResult(abruptionCause:JVMObject = null) {
			this.abruptionCause = abruptionCause;
		}
	
		public function getAbruptionCause():JVMObject {
			return abruptionCause;
		}
	
	}
}
