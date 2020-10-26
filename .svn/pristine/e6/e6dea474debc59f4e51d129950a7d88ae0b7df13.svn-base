package com.jkgh.jvm.parsing.parsers {
	import com.jkgh.jvm.parsing.types.AttributeInfo;
	import com.jkgh.jvm.parsing.types.ConstantPool;
	
	import flash.utils.ByteArray;
	import com.jkgh.jvm.parsing.types.UTF8ConstantEntry;

	public class AttributeInfoParser {
		
		public static function parse(din:ByteArray, constantPool:ConstantPool):Vector.<AttributeInfo> {
			var attributesList:Vector.<AttributeInfo> = new Vector.<AttributeInfo>();
	
			var attributesCount:int = din.readUnsignedShort();
			for (var a:int = 0; a < attributesCount; ++a) {
				var attribute:AttributeInfo = parseAttribute(din, constantPool);
				attributesList.push(attribute);
			}
	
			return attributesList;
		}
	
		private static function parseAttribute(din:ByteArray, constantPool:ConstantPool):AttributeInfo {
	
			var nameIndex:int = din.readUnsignedShort();
			var entry:UTF8ConstantEntry = (UTF8ConstantEntry)(constantPool.getConstantAt(nameIndex));
	
			var attributeLength:int = din.readInt();
			var value:ByteArray = new ByteArray();
			for (var b:int = 0; b < attributeLength; ++b) {
				value.writeByte(din.readByte());
			}
	
			return new AttributeInfo(entry.getValue(), value);
		}
	}
}
