package com.jkgh.jvm.runtime.execution.instructions.java {
	
	
	import com.jkgh.jvm.parsing.parsers.BytecodeParser;
	import com.jkgh.jvm.runtime.execution.control.ExecuteNextInstructionResult;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	import com.jkgh.jvm.runtime.execution.control.InstructionExecutionResult;
	import com.jkgh.jvm.runtime.execution.instructions.Instruction;
	import com.jkgh.jvm.tools.JVMTools;
	import flash.utils.ByteArray;
	import com.jkgh.jvm.parsing.parsers.InstructionWaiter;
	
	public class JgotoInstruction extends Instruction {
	
		private var goToInstruction:Instruction;
	
		public function JgotoInstruction(offset:int) {
			super(offset);
		}
		
		override public function parseParameterBytecodes(byteCode:ByteArray, i:int, codeParser:BytecodeParser):void {
			var goTo:int = JVMTools.readSignedShort(byteCode, i);
			codeParser.request(new InstructionWaiter(i-1+goTo, function(instruction:Instruction):void {
				goToInstruction = instruction;
			}));
		}
	
		override public function execute(frame:FrameExecutionContext):InstructionExecutionResult {
			return new ExecuteNextInstructionResult(goToInstruction);
		}
	
	}
}
