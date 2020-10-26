package com.jkgh.jvm.runtime.execution {
	import com.jkgh.jvm.runtime.execution.instructions.Instruction;
	
	
	public class JVMCode {
	
		private var maxStack:int;
		private var maxLocals:int;
		private var exceptionHandlers:Vector.<JVMExceptionHandler>;
		private var entryPoint:Instruction;
	
		public function JVMCode(maxStack:int, maxLocals:int, entryPoint:Instruction, exceptionHandlers:Vector.<JVMExceptionHandler>) {
			this.maxStack = maxStack;
			this.maxLocals = maxLocals;
			this.entryPoint = entryPoint;
			this.exceptionHandlers = exceptionHandlers;
		}
	
		public function getEntryPoint():Instruction {
			return entryPoint;
		}
	
		public function getMaxStack():int {
			return maxStack;
		}
	
		public function getMaxLocals():int {
			return maxLocals;
		}
	
		public function getExceptionHandlers():Vector.<JVMExceptionHandler> {
			return exceptionHandlers;
		}
	
	}
}
