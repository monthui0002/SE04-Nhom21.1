package com.jkgh.jvm.runtime.execution.instructions.java {
	
	import com.jkgh.jvm.parsing.parsers.BytecodeParser;
	import com.jkgh.jvm.runtime.PrimitiveFloat;
	import com.jkgh.jvm.runtime.execution.control.ExecuteNextInstructionResult;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	import com.jkgh.jvm.runtime.execution.control.InstructionExecutionResult;
	import com.jkgh.jvm.runtime.execution.instructions.HavingNextInstruction;
	
	import flash.utils.ByteArray;
	
	public class JfcmplInstruction extends HavingNextInstruction {
	
		public function JfcmplInstruction(offset:int) {
			super(offset);
		}
	
		override public function parseAndCountParameterBytecodes(byteCode:ByteArray, i:int, codeParser:BytecodeParser):int {
			return 0;
		}
	
		override public function execute(frame:FrameExecutionContext):InstructionExecutionResult {
			var b:PrimitiveFloat = frame.popFloat();
			var a:PrimitiveFloat = frame.popFloat();
			if (isNaN(a.getValue()) || isNaN(b.getValue())) {
				frame.pushInt(-1);
			} else {
				if (a.getValue() > b.getValue()) {
					frame.pushInt(1);
				} else if (a.getValue() == b.getValue()) {
					frame.pushInt(0);
				} else {
					frame.pushInt(-1);
				}
			}
			return new ExecuteNextInstructionResult(getNextInstruction());
		}
		
	}
}
