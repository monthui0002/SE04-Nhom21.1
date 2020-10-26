package com.jkgh.jvm.runtime.execution.control {
	
	import com.jkgh.jvm.runtime.execution.instructions.Instruction;
	
	
	public class ExecuteNextInstructionResult extends InstructionExecutionResult {
	
		private var nextInstruction:Instruction;
	
		public function ExecuteNextInstructionResult(nextInstruction:Instruction) {
			if (nextInstruction == null) {
				trace("???");
			}
			this.nextInstruction = nextInstruction;
		}
	
		public function getNextInstruction():Instruction {
			return nextInstruction;
		}
	
	}
}
