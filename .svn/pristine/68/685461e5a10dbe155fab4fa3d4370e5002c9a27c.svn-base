package com.jkgh.jvm.runtime.execution.instructions {
	import com.jkgh.jvm.runtime.execution.JVMExceptionHandler;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	import com.jkgh.jvm.runtime.execution.control.InstructionExecutionResult;

	import flash.utils.ByteArray;
	import com.jkgh.jvm.parsing.parsers.BytecodeParser;
	
	
	
	public class Instruction {
	
		private var offset:int;
	
		public function Instruction(offset:int) {
			this.offset = offset;
		}
		
		public function parseParameterBytecodes(byteCode:ByteArray, i:int, codeParser:BytecodeParser):void {
			throw new Error();
		}

		
		public function execute(frame:FrameExecutionContext):InstructionExecutionResult {
			throw new Error();
		}

	
		public function isInRangeOf(h:JVMExceptionHandler):Boolean {
			return h.getStart() <= offset && offset < h.getEnd();
		}

	}
}
