package com.jkgh.jvm.runtime.execution.instructions.java {
	
	import com.jkgh.jvm.parsing.parsers.BytecodeParser;
	import com.jkgh.jvm.runtime.PrimitiveFloat;
	import com.jkgh.jvm.runtime.PrimitiveLong;
	import com.jkgh.jvm.runtime.execution.control.ExecuteNextInstructionResult;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	import com.jkgh.jvm.runtime.execution.control.InstructionExecutionResult;
	import com.jkgh.jvm.runtime.execution.instructions.HavingNextInstruction;
	import flash.utils.ByteArray;
	
	public class Jl2fInstruction extends HavingNextInstruction {
	
		public function Jl2fInstruction(offset:int) {
			super(offset);
		}
	
		override public function parseAndCountParameterBytecodes(byteCode:ByteArray, i:int, codeParser:BytecodeParser):int {
			return 0;
		}
	
		override public function execute(frame:FrameExecutionContext):InstructionExecutionResult {
			var l:PrimitiveLong = frame.popLong();
			frame.pushFloat(new PrimitiveFloat(l.toNumber()));
			return new ExecuteNextInstructionResult(getNextInstruction());
		}
		
	}
}
