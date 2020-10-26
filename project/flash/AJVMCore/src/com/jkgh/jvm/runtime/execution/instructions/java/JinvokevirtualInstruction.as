package com.jkgh.jvm.runtime.execution.instructions.java {
	
	
	import com.jkgh.jvm.parsing.parsers.BytecodeParser;
	import com.jkgh.jvm.runtime.execution.JVMClass;
	import com.jkgh.jvm.runtime.execution.JVMMethod;
	import com.jkgh.jvm.runtime.execution.JVMObject;
	import com.jkgh.jvm.runtime.execution.JVMType;
	import com.jkgh.jvm.runtime.execution.JVMVirtualInvocator;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	import com.jkgh.jvm.runtime.execution.control.InstructionExecutionResult;
	import com.jkgh.jvm.runtime.execution.control.InvokeMethodResult;
	import com.jkgh.jvm.runtime.execution.instructions.HavingNextInstruction;
	import com.jkgh.jvm.runtime.execution.instructions.special.SthrowInstruction;
	import com.jkgh.jvm.tools.JVMTools;
	
	import flash.utils.ByteArray;
	
	public class JinvokevirtualInstruction extends HavingNextInstruction {
	
		public function JinvokevirtualInstruction(offset:int) {
			super(offset);
		}
	
		private var invocator:JVMVirtualInvocator;
	
		override public function parseAndCountParameterBytecodes(byteCode:ByteArray, i:int, codeParser:BytecodeParser):int {
			var index:int = JVMTools.readUnsignedShort(byteCode, i);
			this.invocator = JVMTools.getInvokatorByIndex(codeParser.getClassLoadingContext(), codeParser.getConstantPool(), index);
			return 2;
		}
	
		override public function execute(frame:FrameExecutionContext):InstructionExecutionResult {
			var refIndex:int = 0;
			for each (var a:JVMType in invocator.getIdentity().getParameterTypes()) {
				refIndex += a.getWordSize();
			}
			var at:JVMObject = frame.peekReference(refIndex);
			if (at == null) {
				var exceptionClass:JVMClass = frame.getThread().getRuntime().getNullPointerExceptionClass();
				var exceptionRef:JVMObject = exceptionClass.instantiate();
				frame.pushReference(exceptionRef);
				var exceptionConstructor:JVMMethod = exceptionClass.resolveSpecialMethod(JVMTools.NULL_POINTER_EXCEPTION_CONSTRUCTOR_IDENTITY);
				return new InvokeMethodResult(exceptionConstructor, new SthrowInstruction(exceptionRef));
			} else {
				var method:JVMMethod = at.getJVMClass().resolveVirtualMethod(invocator.getIdentity());
				return new InvokeMethodResult(method, getNextInstruction());
			}
		}
	
	}
}
