package com.jkgh.jvm.runtime.execution.instructions.java {
	
	import com.jkgh.jvm.parsing.parsers.BytecodeParser;
	import com.jkgh.jvm.runtime.execution.control.ExecuteNextInstructionResult;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	import com.jkgh.jvm.runtime.execution.control.InstructionExecutionResult;
	import com.jkgh.jvm.runtime.execution.instructions.HavingNextInstruction;
	import flash.utils.ByteArray;
	import com.jkgh.jvm.runtime.PrimitiveLong;
	
	public class JlmulInstruction extends HavingNextInstruction {
	
		public function JlmulInstruction(offset:int) {
			super(offset);
		}
	
		override public function parseAndCountParameterBytecodes(byteCode:ByteArray, i:int, codeParser:BytecodeParser):int {
			return 0;
		}
	
		override public function execute(frame:FrameExecutionContext):InstructionExecutionResult {
			var b:PrimitiveLong = frame.popLong();
			var a:PrimitiveLong = frame.popLong();
			frame.pushLong(a.multiply(b));
			return new ExecuteNextInstructionResult(getNextInstruction());
		}
		
	}
}
