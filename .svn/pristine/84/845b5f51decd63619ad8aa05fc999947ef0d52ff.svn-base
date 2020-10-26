package com.jkgh.jvm.runtime.execution.instructions.java {
	
	import com.jkgh.jvm.parsing.parsers.BytecodeParser;
	import com.jkgh.jvm.runtime.execution.control.ExecuteNextInstructionResult;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	import com.jkgh.jvm.runtime.execution.control.InstructionExecutionResult;
	import com.jkgh.jvm.runtime.execution.instructions.HavingNextInstruction;
	import com.jkgh.jvm.tools.JVMTools;
	import flash.utils.ByteArray;
	
	public class JXstoreInstruction extends HavingNextInstruction {
	
		public function JXstoreInstruction(offset:int) {
			super(offset);
		}
	
		private var storeToIndex:int;
	
		override public function parseAndCountParameterBytecodes(byteCode:ByteArray, i:int, codeParser:BytecodeParser):int {
			this.storeToIndex = JVMTools.readUnsignedByte(byteCode, i);
			return 1;
		}
	
		override public function execute(frame:FrameExecutionContext):InstructionExecutionResult {
			frame.popLocal(storeToIndex);
			return new ExecuteNextInstructionResult(getNextInstruction());
		}
	
	}
}
