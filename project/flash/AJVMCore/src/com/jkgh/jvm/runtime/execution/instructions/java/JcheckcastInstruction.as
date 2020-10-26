package com.jkgh.jvm.runtime.execution.instructions.java {
	
	
	import com.jkgh.jvm.parsing.parsers.BytecodeParser;
	import com.jkgh.jvm.runtime.execution.JVMClass;
	import com.jkgh.jvm.runtime.execution.JVMObject;
	import com.jkgh.jvm.runtime.execution.control.ExceptionThrownResult;
	import com.jkgh.jvm.runtime.execution.control.ExecuteNextInstructionResult;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	import com.jkgh.jvm.runtime.execution.control.InstructionExecutionResult;
	import com.jkgh.jvm.runtime.execution.instructions.HavingNextInstruction;
	import com.jkgh.jvm.tools.JVMTools;
	import flash.utils.ByteArray;
	
	public class JcheckcastInstruction extends HavingNextInstruction {
	
		public function JcheckcastInstruction(offset:int) {
			super(offset);
		}
	
		private var castingTo:JVMClass;
	
		override public function parseAndCountParameterBytecodes(byteCode:ByteArray, i:int, codeParser:BytecodeParser):int {
			var index:int = JVMTools.readUnsignedShort(byteCode, i);
			this.castingTo = JVMTools.getClassByIndex(codeParser.getClassLoadingContext(), codeParser.getConstantPool(), index);
			return 2;
		}
	
		override public function execute(frame:FrameExecutionContext):InstructionExecutionResult {
			var jvmObject:JVMObject = frame.popReference();
			if (jvmObject == null || jvmObject.getJVMClass().isCastableTo(castingTo)) {
				frame.pushReference(jvmObject);
				return new ExecuteNextInstructionResult(getNextInstruction());
			} else {
				var newClassCastException:JVMObject = frame.getThread().getRuntime().getClassCastExceptionClass().instantiate(); // TODO init
				return new ExceptionThrownResult(newClassCastException);
			}
		}
	
	}
}
