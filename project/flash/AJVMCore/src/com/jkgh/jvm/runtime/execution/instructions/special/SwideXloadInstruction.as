package com.jkgh.jvm.runtime.execution.instructions.special {
	
	import com.jkgh.jvm.parsing.parsers.BytecodeParser;
	import com.jkgh.jvm.runtime.execution.control.ExecuteNextInstructionResult;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	import com.jkgh.jvm.runtime.execution.control.InstructionExecutionResult;
	import com.jkgh.jvm.runtime.execution.instructions.HavingNextInstruction;
	import com.jkgh.jvm.tools.JVMTools;
	import flash.utils.ByteArray;
	
	public class SwideXloadInstruction extends HavingNextInstruction {
	
		private var toPushIndex:int;
		
		public function SwideXloadInstruction(offset:int) {
			super(offset);
		}
	
		override public function parseAndCountParameterBytecodes(byteCode:ByteArray, i:int, codeParser:BytecodeParser):int {
			this.toPushIndex = JVMTools.readUnsignedShort(byteCode, i+1);
			return 2;
		}
	
		override public function execute(frame:FrameExecutionContext):InstructionExecutionResult {
			frame.pushLocal(toPushIndex);
			return new ExecuteNextInstructionResult(getNextInstruction());
		}
	
	}
}
