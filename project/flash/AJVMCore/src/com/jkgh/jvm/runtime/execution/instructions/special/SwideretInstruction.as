package com.jkgh.jvm.runtime.execution.instructions.special {
	
	import com.jkgh.jvm.parsing.parsers.BytecodeParser;
	import com.jkgh.jvm.runtime.execution.JVMReturnAddress;
	import com.jkgh.jvm.runtime.execution.control.ExecuteNextInstructionResult;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	import com.jkgh.jvm.runtime.execution.control.InstructionExecutionResult;
	import com.jkgh.jvm.runtime.execution.instructions.Instruction;
	import com.jkgh.jvm.tools.JVMTools;
	import flash.utils.ByteArray;
	
	public class SwideretInstruction extends Instruction {
	
		public function SwideretInstruction(offset:int) {
			super(offset);
		}
	
		private var varNum:int;
	
		override public function parseParameterBytecodes(byteCode:ByteArray, i:int, codeParser:BytecodeParser):void {
			this.varNum = JVMTools.readUnsignedShort(byteCode, i+1);
		}
	
		override public function execute(frame:FrameExecutionContext):InstructionExecutionResult {
			var address:JVMReturnAddress = frame.getLocalReturnAddress(varNum);
			return new ExecuteNextInstructionResult(address.getInstruction());
		}
	
	}
}
