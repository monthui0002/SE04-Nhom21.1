package com.jkgh.jvm.runtime.execution {
	
	import com.jkgh.jvm.runtime.execution.instructions.Instruction;
	
	public class JVMExceptionHandler {
	
		private var start:int;
		private var end:int;
		private var entryInstruction:Instruction;
		private var catchingType:JVMClass;
	
		public function JVMExceptionHandler(start:int, end:int, entryInstruction:Instruction, catchingType:JVMClass) {
			this.start = start;
			this.end = end;
			this.entryInstruction = entryInstruction;
			this.catchingType = catchingType;
		}
	
		public function getStart():int {
			return start;
		}
	
		public function getEnd():int {
			return end;
		}
	
		public function getCatchableClass():JVMClass {
			return catchingType;
		}
	
		public function getEntryInstruction():Instruction {
			return entryInstruction;
		}
	
	}
}
