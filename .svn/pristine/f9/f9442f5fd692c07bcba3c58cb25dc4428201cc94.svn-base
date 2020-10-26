package com.jkgh.jvm.parsing.parsers {
	
	import flash.utils.ByteArray;
	import com.jkgh.jvm.parsing.types.ConstantPool;
	import com.jkgh.jvm.parsing.types.EnclosingMethodAttributeInfo;
	import com.jkgh.jvm.parsing.types.NameAndTypeConstantEntry;
	import com.jkgh.jvm.parsing.types.UTF8ConstantEntry;
	import com.jkgh.jvm.tools.JVMTools;
	
	public class EnclosingMethodAttributeParser {
	
		public static function parse(value:ByteArray, constantPool:ConstantPool):EnclosingMethodAttributeInfo {
			var classIndex:int = JVMTools.readUnsignedShort(value, 0);
			var classEntry:UTF8ConstantEntry = (UTF8ConstantEntry)(constantPool.getConstantAt(classIndex));
			var className:String = classEntry.getValue();
	
			var methodIndex:int = JVMTools.readUnsignedShort(value, 2);
			if (methodIndex == 0) {
				return new EnclosingMethodAttributeInfo(className, null, null);
			} else {
				var methodEntry:NameAndTypeConstantEntry = (NameAndTypeConstantEntry)(constantPool.getConstantAt(methodIndex));
				var methodName:String = ((UTF8ConstantEntry)(constantPool.getConstantAt(methodEntry.getNameIndex()))).getValue();
				var methodDescriptor:String = ((UTF8ConstantEntry)(constantPool.getConstantAt(methodEntry.getDescriptorIndex()))).getValue();
			
				return new EnclosingMethodAttributeInfo(className, methodName, methodDescriptor);
			}
		}
	
	}
}
