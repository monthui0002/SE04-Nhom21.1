package com.jkgh.jvm.parsing.parsers {
	
	import flash.utils.ByteArray;
	import com.jkgh.jvm.parsing.types.AttributeInfo;
	import com.jkgh.jvm.parsing.types.ConstantPool;
	import com.jkgh.jvm.parsing.types.FieldInfo;
	import com.jkgh.jvm.parsing.types.UTF8ConstantEntry;
	
	public class FieldInfoParser {
		
		public static function parse(din:ByteArray, constantPool:ConstantPool):Vector.<FieldInfo> {
			
			var fieldsCount:int = din.readUnsignedShort();
			var fields:Vector.<FieldInfo> = new Vector.<FieldInfo>();
	
			for (var i:int = 0; i < fieldsCount; i++) {
				var flags:int = din.readUnsignedShort();
	
				var nameIndex:int = din.readUnsignedShort();
				var entry:UTF8ConstantEntry = (UTF8ConstantEntry)(constantPool.getConstantAt(nameIndex));
				var fieldName:String = entry.getValue();
	
				var descriptorIndex:int = din.readUnsignedShort();
				var descriptorEntry:UTF8ConstantEntry = (UTF8ConstantEntry)(constantPool.getConstantAt(descriptorIndex));
				var descriptor:String = descriptorEntry.getValue();
	
				var attributes:Vector.<AttributeInfo> = AttributeInfoParser.parse(din, constantPool);
	
				var field:FieldInfo = new FieldInfo(fieldName, flags, descriptor, attributes, constantPool);
	
				fields.push(field);
			}
	
			return fields;
		}
	}
}
