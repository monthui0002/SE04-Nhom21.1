package com.jkgh.jvm.runtime.execution.instructions.java {
	
	
	import com.jkgh.jvm.parsing.parsers.BytecodeParser;
	import com.jkgh.jvm.runtime.execution.JVMObject;
	import com.jkgh.jvm.runtime.execution.control.ExecuteNextInstructionResult;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	import com.jkgh.jvm.runtime.execution.control.InstructionExecutionResult;
	import com.jkgh.jvm.runtime.execution.instructions.HavingNextInstruction;
	import com.jkgh.jvm.runtime.execution.instructions.Instruction;
	import com.jkgh.jvm.tools.JVMTools;
	import flash.utils.ByteArray;
	import com.jkgh.jvm.parsing.parsers.InstructionWaiter;
	
	public class JifnullInstruction extends HavingNextInstruction {
	
		public function JifnullInstruction(offset:int) {
			super(offset);
		}
	
		private var alternativeInstruction:Instruction;
	
		override public function parseAndCountParameterBytecodes(byteCode:ByteArray, i:int, codeParser:BytecodeParser):int {
			var goTo:int = JVMTools.readSignedShort(byteCode, i);
			codeParser.request(new InstructionWaiter(i-1+goTo, function(instruction:Instruction):void {
				alternativeInstruction = instruction;
			}));
			return 2;
		}
	
		override public function execute(frame:FrameExecutionContext):InstructionExecutionResult {
			var o:JVMObject = frame.popReference();
			if (o == null) {
				return new ExecuteNextInstructionResult(alternativeInstruction);
			} else {
				return new ExecuteNextInstructionResult(getNextInstruction());
			}
		}
	
	}
}