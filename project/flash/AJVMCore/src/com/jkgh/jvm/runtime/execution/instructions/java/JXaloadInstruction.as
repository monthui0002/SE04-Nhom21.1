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
	
	public class JXaloadInstruction extends HavingNextInstruction {
	
		public function JXaloadInstruction(offset:int) {
			super(offset);
		}
	
		override public function parseAndCountParameterBytecodes(byteCode:ByteArray, i:int, codeParser:BytecodeParser):int {
			return 0;
		}
	
		override public function execute(frame:FrameExecutionContext):InstructionExecutionResult {
			var index:int = frame.popInt();
			var arrayRef:JVMArrayObject = (JVMArrayObject)(frame.popReference()); // TODO throw null, init, astore as well...
			try {
				var element:Object = arrayRef.getElement(index);
				frame.pushAnything(element);
				return new ExecuteNextInstructionResult(getNextInstruction());
			} catch (e:RangeError) {
				var exceptionRef:JVMObject = frame.getThread().getRuntime().getArrayIndexOutOfBoundsExceptionClass().instantiate(); // TODO init
				return new ExceptionThrownResult(exceptionRef);
			}
			return null;
		}
	
	}
}
