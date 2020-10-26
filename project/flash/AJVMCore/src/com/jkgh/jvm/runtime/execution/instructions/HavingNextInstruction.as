package com.jkgh.jvm.runtime.execution.instructions {
	
	
	import flash.utils.ByteArray;
	import com.jkgh.jvm.parsing.parsers.BytecodeParser;
	import com.jkgh.jvm.parsing.parsers.InstructionWaiter;
	
	public class HavingNextInstruction extends Instruction {
	
		public function HavingNextInstruction(offset:int) {
			super(offset);
		}
	
		private var nextInstruction:Instruction;
	
		override public function parseParameterBytecodes(byteCode:ByteArray, i:int, codeParser:BytecodeParser):void {
			var read:int = parseAndCountParameterBytecodes(byteCode, i, codeParser);
			codeParser.request(new InstructionWaiter(i+read, function(instruction:Instruction):void {
				nextInstruction = instruction;
			}));
		}
	
		public function parseAndCountParameterBytecodes(byteCode:ByteArray, i:int, codeParser:BytecodeParser):int {
			throw new Error();
		}
		
		public function getNextInstruction():Instruction {
			return nextInstruction;
		}
	
		public function setNextInstruction(nextInstruction:Instruction):void {
			this.nextInstruction = nextInstruction;
		}
	}
}
