package com.jkgh.jvm.runtime.execution.instructions.java {
	
	import com.jkgh.jvm.parsing.parsers.BytecodeParser;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	import com.jkgh.jvm.runtime.execution.control.InstructionExecutionResult;
	import com.jkgh.jvm.runtime.execution.control.ReturnResult;
	import com.jkgh.jvm.runtime.execution.instructions.Instruction;
	import flash.utils.ByteArray;
	
	public class JreturnInstruction extends Instruction {
	
		public function JreturnInstruction(offset:int) {
			super(offset);
		}
	
		override public function parseParameterBytecodes(byteCode:ByteArray, i:int, codeParser:BytecodeParser):void {
		}
	
		override public function execute(frame:FrameExecutionContext):InstructionExecutionResult {
			return new ReturnResult();
		}
	
	}
}
