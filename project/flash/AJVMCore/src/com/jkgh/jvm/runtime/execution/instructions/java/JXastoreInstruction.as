package com.jkgh.jvm.runtime.execution.instructions.java {
	
	import com.jkgh.jvm.parsing.parsers.BytecodeParser;
	import com.jkgh.jvm.runtime.execution.JVMArrayObject;
	import com.jkgh.jvm.runtime.execution.control.ExecuteNextInstructionResult;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	import com.jkgh.jvm.runtime.execution.control.InstructionExecutionResult;
	import com.jkgh.jvm.runtime.execution.instructions.HavingNextInstruction;
	
	import flash.utils.ByteArray;
	import com.jkgh.jvm.runtime.execution.JVMObject;
	import com.jkgh.jvm.runtime.execution.control.ExceptionThrownResult;
	
	public class JXastoreInstruction extends HavingNextInstruction {
	
		public function JXastoreInstruction(offset:int) {
			super(offset);
		}
	
		override public function parseAndCountParameterBytecodes(byteCode:ByteArray, i:int, codeParser:BytecodeParser):int {
			return 0;
		}
	
		override public function execute(frame:FrameExecutionContext):InstructionExecutionResult {
			var value:Object = frame.popAnything();
			var index:int = frame.popInt();
			var arrayRef:JVMArrayObject = (JVMArrayObject)(frame.popReference());
			try {
				arrayRef.setElement(index, value);
				return new ExecuteNextInstructionResult(getNextInstruction());
			} catch (e:RangeError) {
				var exceptionRef:JVMObject = frame.getThread().getRuntime().getArrayIndexOutOfBoundsExceptionClass().instantiate(); // TODO init
				return new ExceptionThrownResult(exceptionRef);	
			}
			return null;
		}
	
	}
}
