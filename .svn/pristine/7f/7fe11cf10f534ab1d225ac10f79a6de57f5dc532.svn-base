package com.jkgh.jvm.runtime.execution.instructions.java {
	
	import com.jkgh.jvm.parsing.parsers.BytecodeParser;
	import com.jkgh.jvm.parsing.types.ConstantEntry;
	import com.jkgh.jvm.parsing.types.UTF8ConstantEntry;
	import com.jkgh.jvm.runtime.execution.control.ExecuteNextInstructionResult;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	import com.jkgh.jvm.runtime.execution.control.InstructionExecutionResult;
	import com.jkgh.jvm.runtime.execution.instructions.HavingNextInstruction;
	import com.jkgh.jvm.tools.JVMTools;
	import flash.utils.ByteArray;
	
	public class Jldc_wInstruction extends HavingNextInstruction {
	
		public function Jldc_wInstruction(offset:int) {
			super(offset);
		}
	
		private var constant:ConstantEntry;
	
		override public function parseAndCountParameterBytecodes(byteCode:ByteArray, i:int, codeParser:BytecodeParser):int {
			var index:int = JVMTools.readUnsignedShort(byteCode, i);
			this.constant = codeParser.getConstantPool().getConstantAt(index);
			if (constant is UTF8ConstantEntry) {
				((UTF8ConstantEntry)(constant)).initialize(codeParser.getClassLoadingContext());
			}
			return 2;
		}
	
		override public function execute(frame:FrameExecutionContext):InstructionExecutionResult {
			constant.getByPush(frame);
			return new ExecuteNextInstructionResult(getNextInstruction());
		}
	
	}
}
