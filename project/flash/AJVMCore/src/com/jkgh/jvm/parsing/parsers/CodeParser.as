package com.jkgh.jvm.parsing.parsers {
	
	
	import com.jkgh.jvm.parsing.types.MethodInfo;
	import com.jkgh.jvm.runtime.classloading.JVMClassLoadingContext;
	import com.jkgh.jvm.runtime.execution.JVMClass;
	import com.jkgh.jvm.runtime.execution.JVMCode;
	import com.jkgh.jvm.runtime.execution.JVMExceptionHandler;
	import com.jkgh.jvm.runtime.execution.instructions.Instruction;
	import com.jkgh.jvm.tools.JVMTools;
	import com.jkgh.jvm.tools.Logger;
	
	import flash.utils.ByteArray;
	
	public class CodeParser {
	
		private static const LOG:Logger = Logger.getLogger("AJVMInternal");
		
		public static function parse(classLoadingContext:JVMClassLoadingContext, value:ByteArray, m:MethodInfo):JVMCode {
			var maxStack:int = JVMTools.readUnsignedShort(value, 0);
			var maxLocals:int = JVMTools.readUnsignedShort(value, 2);
			var codeLength:int = JVMTools.readSignedInt(value, 4);
			var code:ByteArray = new ByteArray();
			for (var j:int = 0; j<codeLength; ++j) {
				code.writeByte(value[8+j]);
			}
			LOG.info(["Parsing ", m]);
			var parser:BytecodeParser = new BytecodeParser(classLoadingContext, code, m.getConstantPool());
			var entryPoint:Instruction = parser.getEntryPoint();
			var exceptionsCount:int = JVMTools.readUnsignedShort(value, 8+codeLength);
			var exceptionHandlers:Vector.<JVMExceptionHandler> = new Vector.<JVMExceptionHandler>();
			for (var i:int = 0; i<exceptionsCount; ++i) {
				var start:int = JVMTools.readUnsignedShort(value, 10+codeLength+i*8);
				var end:int = JVMTools.readUnsignedShort(value, 10+codeLength+i*8+2);
				var handle:int = JVMTools.readUnsignedShort(value, 10+codeLength+i*8+4);
				var type:int = JVMTools.readUnsignedShort(value, 10+codeLength+i*8+6);
				var handlerEntryInstruction:Instruction = parser.parseInstructionAt(handle);
				
				var catchingType:JVMClass;
				if (type != 0) {
					var typeName:String = JVMTools.getClassNameByIndex(m.getConstantPool(), type);
					catchingType = classLoadingContext.getJVMClass(typeName);
				} else {
					catchingType = classLoadingContext.getRuntime().getObjectClass();
				}
				var handler:JVMExceptionHandler = new JVMExceptionHandler(start, end, handlerEntryInstruction, catchingType);
				exceptionHandlers.push(handler);
			}
			return new JVMCode(maxStack, maxLocals, entryPoint, exceptionHandlers);
		}
	
	}
}
