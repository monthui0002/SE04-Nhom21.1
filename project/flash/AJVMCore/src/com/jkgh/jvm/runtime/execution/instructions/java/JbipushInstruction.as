package com.jkgh.jvm.runtime.execution.instructions.java {
	
	import com.jkgh.jvm.parsing.parsers.BytecodeParser;
	import com.jkgh.jvm.runtime.execution.control.ExecuteNextInstructionResult;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	import com.jkgh.jvm.runtime.execution.control.InstructionExecutionResult;
	import com.jkgh.jvm.runtime.execution.instructions.HavingNextInstruction;
	import com.jkgh.jvm.tools.JVMTools;
	
	import flash.utils.ByteArray;
	
	public class JbipushInstruction extends HavingNextInstruction {
	
		public function JbipushInstruction(offset:int) {
			super(offset);
		}
	
		private var toPush:int;
	
		override public function parseAndCountParameterBytecodes(byteCode:ByteArray, i:int, codeParser:BytecodeParser):int {
			this.toPush = JVMTools.readSignedByte(byteCode, i);
			return 1;
		}
	
		override public function execute(frame:FrameExecutionContext):InstructionExecutionResult {
			frame.pushInt(toPush);
			return new ExecuteNextInstructionResult(getNextInstruction());
		}
	
	}
}
