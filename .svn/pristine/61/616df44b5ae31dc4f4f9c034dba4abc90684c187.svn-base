package com.jkgh.jvm.runtime.execution.instructions.java {
	
	import com.jkgh.jvm.parsing.parsers.BytecodeParser;
	import com.jkgh.jvm.runtime.execution.JVMArrayObject;
	import com.jkgh.jvm.runtime.execution.JVMObject;
	import com.jkgh.jvm.runtime.execution.control.ExceptionThrownResult;
	import com.jkgh.jvm.runtime.execution.control.ExecuteNextInstructionResult;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	import com.jkgh.jvm.runtime.execution.control.InstructionExecutionResult;
	import com.jkgh.jvm.runtime.execution.instructions.HavingNextInstruction;
	import flash.utils.ByteArray;
	
	public class JarraylengthInstruction extends HavingNextInstruction {
	
		public function JarraylengthInstruction(offset:int) {
			super(offset);
		}
	
		override public function parseAndCountParameterBytecodes(byteCode:ByteArray, i:int, codeParser:BytecodeParser):int {
			return 0;
		}
	
		override public function execute(frame:FrameExecutionContext):InstructionExecutionResult {
			var arrayRef:JVMArrayObject = (JVMArrayObject)(frame.popReference());
			if (arrayRef == null) {
				var exceptionRef:JVMObject = frame.getThread().getRuntime().getNullPointerExceptionClass().instantiate(); // TODO init
				return new ExceptionThrownResult(exceptionRef);
			} else {
				frame.pushInt(arrayRef.getCount());
				return new ExecuteNextInstructionResult(getNextInstruction());
			}
		}
	
	}
}
