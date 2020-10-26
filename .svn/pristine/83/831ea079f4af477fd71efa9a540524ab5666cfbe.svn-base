package com.jkgh.jvm.runtime.execution.instructions.java {
	
	
	import com.jkgh.jvm.parsing.parsers.BytecodeParser;
	import com.jkgh.jvm.runtime.execution.JVMArrayClass;
	import com.jkgh.jvm.runtime.execution.JVMArrayObject;
	import com.jkgh.jvm.runtime.execution.control.ExceptionThrownResult;
	import com.jkgh.jvm.runtime.execution.control.ExecuteNextInstructionResult;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	import com.jkgh.jvm.runtime.execution.control.InstructionExecutionResult;
	import com.jkgh.jvm.runtime.execution.instructions.HavingNextInstruction;
	import com.jkgh.jvm.tools.JVMTools;
	import flash.utils.ByteArray;
	import com.jkgh.jvm.runtime.execution.JVMPrimitive;
	
	public class JnewarrayInstruction extends HavingNextInstruction {
		
		public function JnewarrayInstruction(offset:int) {
			super(offset);
		}
	
		private var arrayClass:JVMArrayClass;
	
		override public function parseAndCountParameterBytecodes(byteCode:ByteArray, i:int, codeParser:BytecodeParser):int {
			var primitiveType:JVMPrimitive = JVMTools.getPrimitiveTypeByCode(byteCode[i]);
			var descriptor:String = primitiveType.getDescriptor();
			this.arrayClass = (JVMArrayClass)(codeParser.getClassLoadingContext().getJVMArrayClass(descriptor));
			return 1;
		}
	
		override public function execute(frame:FrameExecutionContext):InstructionExecutionResult {
			var count:int = frame.popInt();
			if (count < 0) {
				return new ExceptionThrownResult(frame.getThread().getRuntime().getNegativeArraySizeExceptionClass().instantiate()); // TODO init
			}
			var arrayRef:JVMArrayObject = new JVMArrayObject(arrayClass, count);
			frame.pushReference(arrayRef);
			return new ExecuteNextInstructionResult(getNextInstruction());
		}
	
	}
}
