package com.jkgh.jvm.parsing.parsers {
	
	
	import flash.utils.ByteArray;
	import com.jkgh.jvm.parsing.types.ClassInfo;
	import com.jkgh.jvm.parsing.types.ConstantPool;
	import com.jkgh.jvm.parsing.types.UTF8ConstantEntry;
	import com.jkgh.jvm.tools.JVMTools;
	
	public class ClassInfoParser {
	
		public static function parse(din:ByteArray, constantPool:ConstantPool):ClassInfo {
			var accessFlags:int = din.readUnsignedShort();
	
			var classNameIndex:int = din.readUnsignedShort();
			var className:String = JVMTools.getClassNameByIndex(constantPool, classNameIndex);
	
			var superClassNameIndex:int = din.readUnsignedShort();
			var superClassName:String;
			if (superClassNameIndex != 0) {
				superClassName = JVMTools.getClassNameByIndex(constantPool, superClassNameIndex);
			} else {
				superClassName = null;
			}
	
			var interfaceCount:int = din.readUnsignedShort();
	
			var interfaceNames:Vector.<String> = new Vector.<String>();
	
			for (var i:int = 0; i < interfaceCount; i++) {
				var entryIndex:int = din.readUnsignedShort();
				var interfaceEntry:UTF8ConstantEntry = (UTF8ConstantEntry)(constantPool.getConstantAt(entryIndex));
				interfaceNames.push(interfaceEntry.getValue());
			}
	
			return new ClassInfo(className, superClassName, interfaceNames, accessFlags);
		}
	
	}
}
