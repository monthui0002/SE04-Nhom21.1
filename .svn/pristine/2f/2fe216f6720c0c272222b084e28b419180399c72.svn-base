package com.jkgh.jvm.runtime.execution.instructions.java {
	
	
	import com.jkgh.jvm.parsing.parsers.BytecodeParser;
	import com.jkgh.jvm.runtime.execution.JVMClass;
	import com.jkgh.jvm.runtime.execution.JVMMethod;
	import com.jkgh.jvm.runtime.execution.JVMObject;
	import com.jkgh.jvm.runtime.execution.control.ExecuteNextInstructionResult;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	import com.jkgh.jvm.runtime.execution.control.InstructionExecutionResult;
	import com.jkgh.jvm.runtime.execution.control.InvokeMethodResult;
	import com.jkgh.jvm.runtime.execution.instructions.HavingNextInstruction;
	import com.jkgh.jvm.tools.JVMTools;
	import flash.utils.ByteArray;
	
	public class JnewInstruction extends HavingNextInstruction {
	
		public function JnewInstruction(offset:int) {
			super(offset);
		}
	
		private var classToInstantiate:JVMClass;
	
		override public function parseAndCountParameterBytecodes(byteCode:ByteArray, i:int, codeParser:BytecodeParser):int {
			var index:int = JVMTools.readUnsignedShort(byteCode, i);
			classToInstantiate = JVMTools.getClassByIndex(codeParser.getClassLoadingContext(), codeParser.getConstantPool(), index);
			return 2;
		}
	
		override public function execute(frame:FrameExecutionContext):InstructionExecutionResult {
			var clinit:JVMMethod = classToInstantiate.getInitializerIfNeeded();
			if (clinit != null) {
				return new InvokeMethodResult(clinit, this);
			} else {
				var objectRef:JVMObject = classToInstantiate.instantiate();
				frame.pushReference(objectRef);
				return new ExecuteNextInstructionResult(getNextInstruction());
			}
		}
	
	}
}
