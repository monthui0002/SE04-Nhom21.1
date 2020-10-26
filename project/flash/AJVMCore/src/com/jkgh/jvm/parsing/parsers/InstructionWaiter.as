package com.jkgh.jvm.parsing.parsers {
	import com.jkgh.jvm.runtime.execution.instructions.Instruction;
	
	public class InstructionWaiter {
		
		private var offset:int;
		private var onWaited:Function;
		
		public function InstructionWaiter(offset:int, onWaited:Function) {
			this.offset = offset;
			this.onWaited = onWaited;
		}
		
		public function getOffset():int {
			return offset;
		}
		
		public function waited(instruction:Instruction):void {
			onWaited(instruction);
		}
	}
}