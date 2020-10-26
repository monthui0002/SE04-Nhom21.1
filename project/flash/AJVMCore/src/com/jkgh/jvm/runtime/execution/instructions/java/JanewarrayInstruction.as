package com.jkgh.jvm.runtime.execution.instructions.java {
	
	
	import flash.utils.ByteArray;
	import com.jkgh.jvm.parsing.parsers.BytecodeParser;
	import com.jkgh.jvm.runtime.execution.JVMArrayClass;
	import com.jkgh.jvm.runtime.execution.JVMObject;
	import com.jkgh.jvm.runtime.execution.control.ExceptionThrownResult;
	import com.jkgh.jvm.runtime.execution.control.ExecuteNextInstructionResult;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	import com.jkgh.jvm.runtime.execution.control.InstructionExecutionResult;
	import com.jkgh.jvm.runtime.execution.instructions.HavingNextInstruction;
	import com.jkgh.jvm.tools.JVMTools;
	
	public class JanewarrayInstruction extends HavingNextInstruction {
	
		public function JanewarrayInstruction(offset:int) {
			super(offset);
		}
	
		private var arrayClass:JVMArrayClass;
	
		override public function parseAndCountParameterBytecodes(byteCode:ByteArray, i:int, codeParser:BytecodeParser):int {
			var index:int = JVMTools.readUnsignedShort(byteCode, i);
			var componentClassName:String = JVMTools.getClassNameByIndex(codeParser.getConstantPool(), index);
			this.arrayClass = (JVMArrayClass)(codeParser.getClassLoadingContext().resolveType("[L"+componentClassName+";"));
			return 2;
		}
	
		override public function execute(frame:FrameExecutionContext):InstructionExecutionResult {
			var count:int = frame.popInt();
			if (count < 0) {
				var exceptionRef:JVMObject = frame.getThread().getRuntime().getNegativeArraySizeExceptionClass().instantiate(); // TODO init!
				return new ExceptionThrownResult(exceptionRef);
			} else {
				var arrayRef:JVMObject = arrayClass.instantiateArray(count);
				frame.pushReference(arrayRef);
				return new ExecuteNextInstructionResult(getNextInstruction());
			}
		}
	
	}
}
