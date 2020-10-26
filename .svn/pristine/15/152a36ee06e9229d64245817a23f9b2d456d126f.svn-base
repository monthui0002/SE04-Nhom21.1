package com.jkgh.jvm.runtime.execution.instructions.java {
	
	
	import com.jkgh.jvm.parsing.parsers.BytecodeParser;
	import com.jkgh.jvm.runtime.execution.JVMMethod;
	import com.jkgh.jvm.runtime.execution.JVMSpecialInvocator;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	import com.jkgh.jvm.runtime.execution.control.InstructionExecutionResult;
	import com.jkgh.jvm.runtime.execution.control.InvokeMethodResult;
	import com.jkgh.jvm.runtime.execution.instructions.HavingNextInstruction;
	import com.jkgh.jvm.tools.JVMTools;
	import flash.utils.ByteArray;
	
	public class JinvokestaticInstruction extends HavingNextInstruction {
	
		public function JinvokestaticInstruction(offset:int) {
			super(offset);
		}
	
		private var invocator:JVMSpecialInvocator;
	
		override public function parseAndCountParameterBytecodes(byteCode:ByteArray, i:int, codeParser:BytecodeParser):int {
			var index:int = JVMTools.readUnsignedShort(byteCode, i);
			this.invocator = JVMTools.getSpecialInvokatorByIndex(codeParser.getClassLoadingContext(), codeParser.getConstantPool(), index);
			return 2;
		}
	
		override public function execute(frame:FrameExecutionContext):InstructionExecutionResult {
			var methodToInvoke:JVMMethod = invocator.getOwnerClass().resolveStaticMethod(invocator.getIdentity());
			var clinit:JVMMethod = methodToInvoke.getOwnerClass().getInitializerIfNeeded();
			if (clinit != null) {
				return new InvokeMethodResult(clinit, this);
			} else {
				return new InvokeMethodResult(methodToInvoke, getNextInstruction());
			}
		}
	
	}
}
