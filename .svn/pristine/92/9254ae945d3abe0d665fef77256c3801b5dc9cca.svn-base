package com.jkgh.jvm.runtime.execution.instructions.java {
	
	import com.jkgh.jvm.parsing.parsers.BytecodeParser;
	import com.jkgh.jvm.runtime.execution.control.ExecuteNextInstructionResult;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	import com.jkgh.jvm.runtime.execution.control.InstructionExecutionResult;
	import com.jkgh.jvm.runtime.execution.instructions.HavingNextInstruction;
	
	import flash.utils.ByteArray;
	
	public class JXload_YInstruction extends HavingNextInstruction {
	
		private var varNum:int;
	
		public function JXload_YInstruction(offset:int, varNum:int) {
			super(offset);
			this.varNum = varNum;
		}
	
		override public function parseAndCountParameterBytecodes(byteCode:ByteArray, i:int, codeParser:BytecodeParser):int {
			return 0;
		}
	
		override public function execute(frame:FrameExecutionContext):InstructionExecutionResult {
			frame.pushLocal(varNum);
			return new ExecuteNextInstructionResult(getNextInstruction());
		}
	
		public function toString():String {
			return "JXload_"+varNum+"Instruction";
		}
	}
}
