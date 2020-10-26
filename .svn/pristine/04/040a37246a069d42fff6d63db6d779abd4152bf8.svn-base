package com.jkgh.jvm.runtime.execution.instructions.java {
	
	
	import com.jkgh.jvm.parsing.parsers.BytecodeParser;
	import com.jkgh.jvm.parsing.parsers.InstructionWaiter;
	import com.jkgh.jvm.runtime.execution.control.ExecuteNextInstructionResult;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	import com.jkgh.jvm.runtime.execution.control.InstructionExecutionResult;
	import com.jkgh.jvm.runtime.execution.instructions.Instruction;
	import com.jkgh.jvm.tools.JVMTools;
	
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	public class JlookupswitchInstruction extends Instruction {
	
		public function JlookupswitchInstruction(offset:int) {
			super(offset);
		}
	
		private var defaultInstruction:Instruction;
		private var matchInstructions:Dictionary/*Integer, Instruction*/;
	
		override public function parseParameterBytecodes(byteCode:ByteArray, originalI:int, codeParser:BytecodeParser):void {
			var i:int = originalI;
			if (i % 4 != 0) {
				i = ((int)(i/4) + 1)*4;
			}
			var defaultOffset:int = JVMTools.readSignedInt(byteCode, i);
			
			codeParser.request(new InstructionWaiter(originalI-1+defaultOffset, function(instruction:Instruction):void {
				defaultInstruction = instruction;
			}));
			i += 4;
			var nPairs:int = JVMTools.readSignedInt(byteCode, i);
			i += 4;
			this.matchInstructions = new Dictionary();
			for (var j:int = 0; j<nPairs; ++j) {
				var match:int = JVMTools.readSignedInt(byteCode, i);
				i += 4;
				var offset:int = JVMTools.readSignedInt(byteCode, i);
				
				var iwg:Function = function(lmatch:int, loffset:int):InstructionWaiter {
					return new InstructionWaiter(originalI-1+loffset, function(instruction:Instruction):void {
						matchInstructions[lmatch] = instruction;
					});
				};
				
				codeParser.request(iwg(match, offset));
				i += 4;
			}
		}
	
		override public function execute(frame:FrameExecutionContext):InstructionExecutionResult {
			var key:int = frame.popInt();
			var instruction:Instruction = matchInstructions[key];
			if (instruction != null) {
				return new ExecuteNextInstructionResult(instruction);
			} else {
				return new ExecuteNextInstructionResult(defaultInstruction);
			}
		}
	
	}
}
