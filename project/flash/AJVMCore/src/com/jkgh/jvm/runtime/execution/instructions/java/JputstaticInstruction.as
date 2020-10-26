package com.jkgh.jvm.runtime.execution.instructions.java {
	
	
	import com.jkgh.jvm.parsing.parsers.BytecodeParser;
	import com.jkgh.jvm.runtime.execution.JVMField;
	import com.jkgh.jvm.runtime.execution.control.ExecuteNextInstructionResult;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	import com.jkgh.jvm.runtime.execution.control.InstructionExecutionResult;
	import com.jkgh.jvm.runtime.execution.instructions.HavingNextInstruction;
	import com.jkgh.jvm.tools.JVMTools;
	import flash.utils.ByteArray;
	
	public class JputstaticInstruction extends HavingNextInstruction {
	
		public function JputstaticInstruction(offset:int) {
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
			field.getOwnerClass().setFieldValue(field, fieldValue);
			return new ExecuteNextInstructionResult(getNextInstruction());
		}
	
	}
}
