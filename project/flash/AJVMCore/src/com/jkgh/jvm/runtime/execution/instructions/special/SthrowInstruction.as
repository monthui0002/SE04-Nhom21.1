package com.jkgh.jvm.runtime.execution.instructions.special {
	
	import com.jkgh.jvm.parsing.parsers.BytecodeParser;
	import com.jkgh.jvm.runtime.execution.JVMObject;
	import com.jkgh.jvm.runtime.execution.control.ExceptionThrownResult;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	import com.jkgh.jvm.runtime.execution.control.InstructionExecutionResult;
	import com.jkgh.jvm.runtime.execution.instructions.Instruction;
	import flash.utils.ByteArray;
	
	public class SthrowInstruction extends Instruction {
	
		private var exceptionRef:JVMObject;
	
		public function SthrowInstruction(exceptionRef:JVMObject) {
			super(-1);
			this.exceptionRef = exceptionRef;
		}
	
		override public function parseParameterBytecodes(byteCode:ByteArray, i:int, codeParser:BytecodeParser):void {
			// This instruction is never parsed.
		}
	
		override public function execute(frame:FrameExecutionContext):InstructionExecutionResult {
			return new ExceptionThrownResult(exceptionRef);
		}
	
	}
}
