package com.jkgh.jvm.runtime.execution.instructions.java {
	
	import com.jkgh.jvm.parsing.parsers.BytecodeParser;
	import com.jkgh.jvm.runtime.execution.control.ExecuteNextInstructionResult;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	import com.jkgh.jvm.runtime.execution.control.InstructionExecutionResult;
	import com.jkgh.jvm.runtime.execution.instructions.HavingNextInstruction;
	import flash.utils.ByteArray;
	
	public class JidivInstruction extends HavingNextInstruction {
	
		public function JidivInstruction(offset:int) {
			super(offset);
		}
	
		override public function parseAndCountParameterBytecodes(byteCode:ByteArray, i:int, codeParser:BytecodeParser):int {
			return 0;
		}
	
		override public function execute(frame:FrameExecutionContext):InstructionExecutionResult {
			var b:int = frame.popInt();
			var a:int = frame.popInt();
			frame.pushInt(a/b);
			return new ExecuteNextInstructionResult(getNextInstruction());
		}
		
	}
}
