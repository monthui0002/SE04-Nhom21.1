package com.jkgh.jvm.runtime.execution.instructions.java {
	
	
	import com.jkgh.jvm.parsing.parsers.BytecodeParser;
	import com.jkgh.jvm.runtime.execution.JVMClass;
	import com.jkgh.jvm.runtime.execution.JVMField;
	import com.jkgh.jvm.runtime.execution.JVMMethod;
	import com.jkgh.jvm.runtime.execution.JVMObject;
	import com.jkgh.jvm.runtime.execution.control.ExecuteNextInstructionResult;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	import com.jkgh.jvm.runtime.execution.control.InstructionExecutionResult;
	import com.jkgh.jvm.runtime.execution.control.InvokeMethodResult;
	import com.jkgh.jvm.runtime.execution.instructions.HavingNextInstruction;
	import com.jkgh.jvm.runtime.execution.instructions.special.SthrowInstruction;
	import com.jkgh.jvm.tools.JVMTools;
	import flash.utils.ByteArray;
	
	public class JputfieldInstruction extends HavingNextInstruction {
	
		public function JputfieldInstruction(offset:int) {
			super(offset);
		}
	
		private var field:JVMField;
	
		override public function parseAndCountParameterBytecodes(byteCode:ByteArray, i:int, codeParser:BytecodeParser):int {
			var index:int = JVMTools.readUnsignedShort(byteCode, i);
			this.field = JVMTools.getFieldByIndex(codeParser.getClassLoadingContext(), codeParser.getConstantPool(), index);
			return 2;
		}
	
		override public function execute(frame:FrameExecutionContext):InstructionExecutionResult {
			var fieldValue:Object = field.getType().performPop(frame);
			var objectRef:JVMObject = frame.popReference();
			if (objectRef == null) {
				var exceptionClass:JVMClass = frame.getThread().getRuntime().getNullPointerExceptionClass();
				var exceptionRef:JVMObject = exceptionClass.instantiate();
				frame.pushReference(exceptionRef);
				var exceptionConstructor:JVMMethod = exceptionClass.resolveSpecialMethod(JVMTools.NULL_POINTER_EXCEPTION_CONSTRUCTOR_IDENTITY);
				return new InvokeMethodResult(exceptionConstructor, new SthrowInstruction(exceptionRef));
			} else {
				objectRef.setFieldValue(field, fieldValue);
				return new ExecuteNextInstructionResult(getNextInstruction());
			}
		}
	
	}
}
