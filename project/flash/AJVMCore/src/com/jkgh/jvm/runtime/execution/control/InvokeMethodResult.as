package com.jkgh.jvm.runtime.execution.control {
	
	import com.jkgh.jvm.runtime.execution.JVMMethod;
	import com.jkgh.jvm.runtime.execution.instructions.Instruction;
	
	public class InvokeMethodResult extends InstructionExecutionResult {
	
		private var method:JVMMethod;
		private var nextInstruction:Instruction;
	
		public function InvokeMethodResult(method:JVMMethod, nextInstruction:Instruction) {
			this.method = method;
			this.nextInstruction = nextInstruction;
		}
	
		public function getMethod():JVMMethod {
			return method;
		}
	
		public function getNextInstruction():Instruction {
			return nextInstruction;
		}
	
	}
}
