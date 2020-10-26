package com.jkgh.jvm.runtime.execution.instructions.special {
	
	import com.jkgh.jvm.parsing.parsers.BytecodeParser;
	import com.jkgh.jvm.runtime.execution.control.ExecuteNextInstructionResult;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	import com.jkgh.jvm.runtime.execution.control.InstructionExecutionResult;
	import com.jkgh.jvm.runtime.execution.instructions.HavingNextInstruction;
	import com.jkgh.jvm.tools.JVMTools;
	import flash.utils.ByteArray;
	
	public class SwideiincInstruction extends HavingNextInstruction {
		
		private var varNum:int;
		private var delta:int;
			
		public function SwideiincInstruction(offset:int) {
			super(offset);
		}
	
		override public function parseAndCountParameterBytecodes(byteCode:ByteArray, i:int, codeParser:BytecodeParser):int {
			this.varNum = JVMTools.readUnsignedShort(byteCode, i+1);
			this.delta = JVMTools.readSignedShort(byteCode, i+3);
			return 4;
		}
	
		override public function execute(frame:FrameExecutionContext):InstructionExecutionResult {
			var a:int = frame.getLocalInt(varNum);
			frame.setLocalInt(varNum, a+delta);
			return new ExecuteNextInstructionResult(getNextInstruction());
		}
		
	}
}
