package com.jkgh.jvm.runtime.execution.instructions.special {
	
	
	import com.jkgh.jvm.parsing.parsers.BytecodeParser;
	import com.jkgh.jvm.runtime.execution.control.ExecuteNextInstructionResult;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	import com.jkgh.jvm.runtime.execution.control.InstructionExecutionResult;
	import com.jkgh.jvm.runtime.execution.instructions.Instruction;
	import flash.utils.ByteArray;
	
	public class Snative_bypassInstruction extends Instruction {
	
		private var nextInstruction:Instruction;
		
		public function Snative_bypassInstruction(nextInstruction:Instruction) {
			super(-1);
			this.nextInstruction = nextInstruction;
		}
	
		override public function parseParameterBytecodes(byteCode:ByteArray, i:int, codeParser:BytecodeParser):void {
			// This instruction is never parsed.
		}
	
		override public function execute(frame:FrameExecutionContext):InstructionExecutionResult {
			runNatively();
			return new ExecuteNextInstructionResult(nextInstruction);
		}
	
		protected function runNatively():void {
			throw new Error();
		}
	
	}
}
