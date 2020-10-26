package com.jkgh.jvm.runtime.execution.instructions.java {
	
	import com.jkgh.jvm.parsing.parsers.BytecodeParser;
	import com.jkgh.jvm.runtime.execution.control.ExecuteNextInstructionResult;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	import com.jkgh.jvm.runtime.execution.control.InstructionExecutionResult;
	import com.jkgh.jvm.runtime.execution.instructions.HavingNextInstruction;
	import flash.utils.ByteArray;
	import com.jkgh.jvm.runtime.PrimitiveLong;
	
	public class JlcmpInstruction extends HavingNextInstruction {
	
		public function JlcmpInstruction(offset:int) {
			super(offset);
		}
	
		override public function parseAndCountParameterBytecodes(byteCode:ByteArray, i:int, codeParser:BytecodeParser):int {
			return 0;
		}
	
		override public function execute(frame:FrameExecutionContext):InstructionExecutionResult {
			var b:PrimitiveLong = frame.popLong();
			var a:PrimitiveLong = frame.popLong();
			frame.pushInt(a.compareTo(b));
			return new ExecuteNextInstructionResult(getNextInstruction());
		}
		
	}
}
