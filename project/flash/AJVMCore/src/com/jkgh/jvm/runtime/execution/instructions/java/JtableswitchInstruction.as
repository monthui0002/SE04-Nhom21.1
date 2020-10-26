package com.jkgh.jvm.runtime.execution.instructions.java {
	
	
	import com.jkgh.jvm.parsing.parsers.BytecodeParser;
	import com.jkgh.jvm.parsing.parsers.InstructionWaiter;
	import com.jkgh.jvm.runtime.execution.control.ExecuteNextInstructionResult;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	import com.jkgh.jvm.runtime.execution.control.InstructionExecutionResult;
	import com.jkgh.jvm.runtime.execution.instructions.Instruction;
	import com.jkgh.jvm.tools.JVMTools;
	
	import flash.utils.ByteArray;
	
	public class JtableswitchInstruction extends Instruction {
	
		public function JtableswitchInstruction(offset:int) {
			super(offset);
		}
	
		private var defaultInstruction:Instruction;
		private var low:int;
		private var tableInstructions:Vector.<Instruction>;
	
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
			this.low = JVMTools.readSignedInt(byteCode, i);
			i += 4;
			var high:int = JVMTools.readSignedInt(byteCode, i);
			i += 4;
			
			this.tableInstructions = new Vector.<Instruction>();
			for (var p:int = 0; p<high-low+1; ++p) {
				tableInstructions.push(null);
			}
			
			for (var j:int = 0; j<high-low+1; ++j) {
				var offset:int = JVMTools.readSignedInt(byteCode, i);
				
				var iwg:Function = function(lj:int, loffset:int):InstructionWaiter {
					return new InstructionWaiter(originalI-1+loffset, function(instruction:Instruction):void {
						tableInstructions[lj] = instruction;
					});
				};
				
				codeParser.request(iwg(j, offset));
				i += 4;
			}
		}
	
		override public function execute(frame:FrameExecutionContext):InstructionExecutionResult {
			var index:int = frame.popInt()-low;
			if (index < 0 || index >= tableInstructions.length) {
				return new ExecuteNextInstructionResult(defaultInstruction);
			} else {
				return new ExecuteNextInstructionResult(tableInstructions[index]);
			}
		}
	
	}
}
