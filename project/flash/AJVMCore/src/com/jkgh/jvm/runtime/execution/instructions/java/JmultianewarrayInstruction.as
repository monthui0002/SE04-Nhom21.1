package com.jkgh.jvm.runtime.execution.instructions.java {
	
	
	import com.jkgh.jvm.parsing.parsers.BytecodeParser;
	import com.jkgh.jvm.runtime.execution.JVMArrayClass;
	import com.jkgh.jvm.runtime.execution.JVMArrayObject;
	import com.jkgh.jvm.runtime.execution.JVMType;
	import com.jkgh.jvm.runtime.execution.control.ExecuteNextInstructionResult;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	import com.jkgh.jvm.runtime.execution.control.InstructionExecutionResult;
	import com.jkgh.jvm.runtime.execution.instructions.HavingNextInstruction;
	import com.jkgh.jvm.tools.JVMTools;
	
	import flash.utils.ByteArray;
	
	public class JmultianewarrayInstruction extends HavingNextInstruction {
	
		public function JmultianewarrayInstruction(offset:int) {
			super(offset);
		}
	
		private var dimensions:int;
		private var arrayClass:JVMArrayClass;
	
		override public function parseAndCountParameterBytecodes(byteCode:ByteArray, i:int, codeParser:BytecodeParser):int {
			var index:int = JVMTools.readUnsignedShort(byteCode, i);
			this.arrayClass = (JVMArrayClass)(JVMTools.getClassByIndex(codeParser.getClassLoadingContext(), codeParser.getConstantPool(), index));
			this.dimensions = JVMTools.readUnsignedByte(byteCode, i+2);
			return 3;
		}
	
		override public function execute(frame:FrameExecutionContext):InstructionExecutionResult {
			var counts:Vector.<int> = new Vector.<int>();
			for (var j:int = 0; j<dimensions; ++j) {
				counts.push(null);
			}
			for (var i:int = dimensions-1; i>=0; --i) {
				counts[i] = frame.popInt();
			}
			var arrayRef:JVMArrayObject = (JVMArrayObject)(contruct(counts, 0, arrayClass));
			frame.pushReference(arrayRef);
			return new ExecuteNextInstructionResult(getNextInstruction());
		}
	
		private function contruct(counts:Vector.<int>, i:int, arrayClass:JVMArrayClass):Object {
			if (i < dimensions) {
				var currentCount:int = counts[i];
				var ret:JVMArrayObject = new JVMArrayObject(arrayClass, currentCount);
				for (var j:int = 0; j<currentCount; ++j) {
					var e:Object = contruct(counts, i+1, (JVMArrayClass)(arrayClass.getComponentType()));
					ret.setElement(j, e);
				}
				return ret;
			} else {
				var elementType:JVMType = arrayClass.getComponentType();
				return elementType.getDefaultValue();
			}
		}
	
	}
}
