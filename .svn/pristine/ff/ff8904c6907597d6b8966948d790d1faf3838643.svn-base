package com.jkgh.jvm.runtime.execution.instructions.java {
	
	import com.jkgh.jvm.parsing.parsers.BytecodeParser;
	import com.jkgh.jvm.runtime.PrimitiveLong;
	import com.jkgh.jvm.runtime.execution.control.ExecuteNextInstructionResult;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	import com.jkgh.jvm.runtime.execution.control.InstructionExecutionResult;
	import com.jkgh.jvm.runtime.execution.instructions.HavingNextInstruction;
	
	import flash.utils.ByteArray;
	
	public class Jlconst_XInstruction extends HavingNextInstruction {
	
		private var x:PrimitiveLong;
	
		public function Jlconst_XInstruction(offset:int, x:PrimitiveLong) {
			super(offset);
			this.x = x;
		}
		
		override public function parseAndCountParameterBytecodes(byteCode:ByteArray, i:int, codeParser:BytecodeParser):int {
			return 0;
		}
	
		override public function execute(frame:FrameExecutionContext):InstructionExecutionResult {
			frame.pushLong(x);
			return new ExecuteNextInstructionResult(getNextInstruction());
		}
	}
}
