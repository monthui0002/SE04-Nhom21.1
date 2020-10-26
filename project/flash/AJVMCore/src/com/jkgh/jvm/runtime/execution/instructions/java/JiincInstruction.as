package com.jkgh.jvm.runtime.execution.instructions.java {
	
	import com.jkgh.jvm.parsing.parsers.BytecodeParser;
	import com.jkgh.jvm.runtime.execution.control.ExecuteNextInstructionResult;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	import com.jkgh.jvm.runtime.execution.control.InstructionExecutionResult;
	import com.jkgh.jvm.runtime.execution.instructions.HavingNextInstruction;
	import com.jkgh.jvm.tools.JVMTools;
	import flash.utils.ByteArray;
	
	public class JiincInstruction extends HavingNextInstruction {
		
		public function JiincInstruction(offset:int) {
			super(offset);
		}
	
		private var varNum:int;
		private var delta:int;
	
		override public function parseAndCountParameterBytecodes(byteCode:ByteArray, i:int, codeParser:BytecodeParser):int {
			this.varNum = JVMTools.readUnsignedByte(byteCode, i);
			this.delta = JVMTools.readSignedByte(byteCode, i+1);
			return 2;
		}
	
		override public function execute(frame:FrameExecutionContext):InstructionExecutionResult {
			var a:int = frame.getLocalInt(varNum);
			frame.setLocalInt(varNum, a+delta);
			return new ExecuteNextInstructionResult(getNextInstruction());
		}
		
	}
}
