package com.jkgh.jvm.runtime.execution.instructions.special {
	
	import com.jkgh.jvm.parsing.parsers.BytecodeParser;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	import com.jkgh.jvm.runtime.execution.control.InstructionExecutionResult;
	import com.jkgh.jvm.runtime.execution.control.KillThreadResult;
	import com.jkgh.jvm.runtime.execution.instructions.Instruction;
	import flash.utils.ByteArray;
	
	public class SthreadkillInstruction extends Instruction {
	
		public function SthreadkillInstruction() {
			super(-1);
		}
	
		override public function parseParameterBytecodes(byteCode:ByteArray, i:int, codeParser:BytecodeParser):void {
			// This instruction is never parsed.
		}
	
		override public function execute(frame:FrameExecutionContext):InstructionExecutionResult {
			return new KillThreadResult();
		}
	
	}
}
