package com.jkgh.jvm.runtime.execution.instructions.java {
	
	import com.jkgh.jvm.parsing.parsers.BytecodeParser;
	import com.jkgh.jvm.runtime.execution.control.ExecuteNextInstructionResult;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	import com.jkgh.jvm.runtime.execution.control.InstructionExecutionResult;
	import com.jkgh.jvm.runtime.execution.instructions.HavingNextInstruction;
	import flash.utils.ByteArray;
	import com.jkgh.jvm.runtime.PrimitiveDouble;
	
	public class Jd2iInstruction extends HavingNextInstruction {
	
		public function Jd2iInstruction(offset:int) {
			super(offset);
		}
	
		override public function parseAndCountParameterBytecodes(byteCode:ByteArray, i:int, codeParser:BytecodeParser):int {
			return 0;
		}
		
		override public function execute(frame:FrameExecutionContext):InstructionExecutionResult {
			var d:PrimitiveDouble = frame.popDouble();
			frame.pushInt((int)(d.getValue()));
			return new ExecuteNextInstructionResult(getNextInstruction());
		}
		
	}
}
