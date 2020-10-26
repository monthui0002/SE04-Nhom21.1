package com.jkgh.jvm.parsing.parsers {
	
	
	import com.jkgh.jvm.parsing.types.AttributeInfo;
	import com.jkgh.jvm.parsing.types.ConstantPool;
	import com.jkgh.jvm.parsing.types.MethodInfo;
	import com.jkgh.jvm.parsing.types.UTF8ConstantEntry;
	import flash.utils.ByteArray;
	
	public class MethodInfoParser {
		
		public static function parse(din:ByteArray, constantPool:ConstantPool):Vector.<MethodInfo> {
			
			var methodsCount:int = din.readUnsignedShort();
			var methods:Vector.<MethodInfo> = new Vector.<MethodInfo>();
	
			for (var i:int = 0; i < methodsCount; ++i) {
				var flags:int = din.readUnsignedShort();
	
				var nameIndex:int = din.readUnsignedShort();
				var entry:UTF8ConstantEntry = (UTF8ConstantEntry)(constantPool.getConstantAt(nameIndex));
				var fieldName:String = entry.getValue();
	
				var descriptorIndex:int = din.readUnsignedShort();
				var descriptorEntry:UTF8ConstantEntry = (UTF8ConstantEntry)(constantPool.getConstantAt(descriptorIndex));
				var descriptor:String = descriptorEntry.getValue();
	
				var attributes:Vector.<AttributeInfo> = AttributeInfoParser.parse(din, constantPool);
	
				var method:MethodInfo = new MethodInfo(fieldName, flags, descriptor, attributes, constantPool);
	
				methods.push(method);
			}
	
			return methods;
		}
	}
}