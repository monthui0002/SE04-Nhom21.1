package com.jkgh.jvm.runtime.execution.instructions.java {
	
	import com.jkgh.jvm.parsing.parsers.BytecodeParser;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	import com.jkgh.jvm.runtime.execution.control.InstructionExecutionResult;
	import com.jkgh.jvm.runtime.execution.instructions.HavingNextInstruction;
	import flash.utils.ByteArray;
	
	public class JinvokedynamicInstruction extends HavingNextInstruction {
	
		public function JinvokedynamicInstruction(offset:int) {
			super(offset);
		}
	
		override public function parseAndCountParameterBytecodes(byteCode:ByteArray, i:int, codeParser:BytecodeParser):int {
			throw new Error("No dynamic invocation.");
			//var index:int = JVMTools.readUnsignedShort(byteCode, i);
			//return 4;
		}
	
		override public function execute(frame:FrameExecutionContext):InstructionExecutionResult {
			throw new Error("No dynamic invocation.");
		}
	
	}
}
