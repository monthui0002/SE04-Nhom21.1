package com.jkgh.jvm.runtime.execution.instructions.special {
	
	
	import com.jkgh.jvm.parsing.parsers.BytecodeParser;
	import com.jkgh.jvm.runtime.execution.JVMMethod;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	import com.jkgh.jvm.runtime.execution.control.InstructionExecutionResult;
	import com.jkgh.jvm.runtime.execution.control.InvokeMethodResult;
	import com.jkgh.jvm.runtime.execution.instructions.Instruction;
	import flash.utils.ByteArray;
	
	public class SbootstrapInstruction extends Instruction {
	
		private var method:JVMMethod;
	
		public function SbootstrapInstruction(method:JVMMethod) {
			super(-1);
			this.method = method;
		}
	
		override public function parseParameterBytecodes(byteCode:ByteArray, i:int, codeParser:BytecodeParser):void {
			// This instruction is never parsed.
		}
	
		override public function execute(frame:FrameExecutionContext):InstructionExecutionResult {
			var clinit:JVMMethod = method.getOwnerClass().getInitializerIfNeeded();
			if (clinit != null) {
				return new InvokeMethodResult(clinit, this);
			} else {
				return new InvokeMethodResult(method, new SthreadkillInstruction());
			}
		}
	
	}
}
