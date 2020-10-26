package com.jkgh.jvm.parsing.parsers {
	import com.jkgh.jvm.parsing.types.AttributeInfo;
	import com.jkgh.jvm.parsing.types.ClassInfo;
	import com.jkgh.jvm.parsing.types.ConstantPool;
	import com.jkgh.jvm.parsing.types.FieldInfo;
	import com.jkgh.jvm.parsing.types.FileHeaderInfo;
	import com.jkgh.jvm.parsing.types.MethodInfo;
	import com.jkgh.jvm.parsing.types.ParsedJavaClass;
	
	import flash.utils.ByteArray;
	import com.jkgh.jvm.parsing.types.EnclosingMethodAttributeInfo;
	
	public class ClassFileParser {
		
		public static function parse(din:ByteArray):ParsedJavaClass {
	
			var fileHeaderInfo:FileHeaderInfo = FileHeaderInfoParser.parse(din);
			var constantPool:ConstantPool = ConstantPoolParser.parse(din, fileHeaderInfo);
			var classInfo:ClassInfo = ClassInfoParser.parse(din, constantPool);
			var fieldInfos:Vector.<FieldInfo> = FieldInfoParser.parse(din, constantPool);
			var methodInfos:Vector.<MethodInfo> = MethodInfoParser.parse(din, constantPool);
			var attributeInfos:Vector.<AttributeInfo> = AttributeInfoParser.parse(din, constantPool);
			var enclosingMethodAttributeInfo:EnclosingMethodAttributeInfo = null;
			
			for each (var a:AttributeInfo in attributeInfos) {
				if (a.getName() == "EnclosingMethod") {
					enclosingMethodAttributeInfo = EnclosingMethodAttributeParser.parse(a.getValue(), constantPool);
				}
			}
	
			return new ParsedJavaClass(fileHeaderInfo, classInfo, fieldInfos, methodInfos, enclosingMethodAttributeInfo, constantPool);
		}
	}
}
