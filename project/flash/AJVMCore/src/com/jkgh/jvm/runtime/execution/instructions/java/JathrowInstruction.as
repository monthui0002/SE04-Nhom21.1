package com.jkgh.jvm.runtime.execution.instructions.java {
	
	import com.jkgh.jvm.parsing.parsers.BytecodeParser;
	import com.jkgh.jvm.runtime.execution.JVMObject;
	import com.jkgh.jvm.runtime.execution.control.ExceptionThrownResult;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	import com.jkgh.jvm.runtime.execution.control.InstructionExecutionResult;
	import com.jkgh.jvm.runtime.execution.instructions.Instruction;
	import flash.utils.ByteArray;
	
	public class JathrowInstruction extends Instruction {
	
		public function JathrowInstruction(offset:int) {
			super(offset);
		}
	
		override public function parseParameterBytecodes(byteCode:ByteArray, i:int, codeParser:BytecodeParser):void {
		}
	
		override public function execute(frame:FrameExecutionContext):InstructionExecutionResult {
			var exceptionRef:JVMObject = frame.popReference();
			if (exceptionRef == null) {
				exceptionRef = frame.getThread().getRuntime().getNullPointerExceptionClass().instantiate(); // TODO init!
			}
			return new ExceptionThrownResult(exceptionRef);
		}
	
	}
}
