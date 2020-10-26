package com.jkgh.jvm.runtime.execution.instructions.java {
	
	
	import com.jkgh.jvm.parsing.parsers.BytecodeParser;
	import com.jkgh.jvm.runtime.execution.JVMClass;
	import com.jkgh.jvm.runtime.execution.JVMObject;
	import com.jkgh.jvm.runtime.execution.control.ExecuteNextInstructionResult;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	import com.jkgh.jvm.runtime.execution.control.InstructionExecutionResult;
	import com.jkgh.jvm.runtime.execution.instructions.HavingNextInstruction;
	import com.jkgh.jvm.tools.JVMTools;
	import flash.utils.ByteArray;
	
	public class JinstanceofInstruction extends HavingNextInstruction {
	
		public function JinstanceofInstruction(offset:int) {
			super(offset);
		}
	
		private var checkingAgainst:JVMClass;
	
		override public function parseAndCountParameterBytecodes(byteCode:ByteArray, i:int, codeParser:BytecodeParser):int {
			var index:int = JVMTools.readUnsignedShort(byteCode, i);
			this.checkingAgainst = JVMTools.getClassByIndex(codeParser.getClassLoadingContext(), codeParser.getConstantPool(), index);
			return 2;
		}
	
		override public function execute(frame:FrameExecutionContext):InstructionExecutionResult {
			var jvmObject:JVMObject = frame.popReference();
			if (jvmObject != null && jvmObject.getJVMClass().isCastableTo(checkingAgainst)) {
				frame.pushInt(1);
			} else {
				frame.pushInt(0);
			}
			return new ExecuteNextInstructionResult(getNextInstruction());
		}
	
	}
}
