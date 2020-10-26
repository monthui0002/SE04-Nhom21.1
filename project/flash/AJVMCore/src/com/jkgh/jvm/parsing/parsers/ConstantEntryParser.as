package com.jkgh.jvm.parsing.parsers {
	
	
	import flash.utils.ByteArray;
	import com.jkgh.jvm.parsing.types.ClassConstantEntry;
	import com.jkgh.jvm.parsing.types.ConstantEntry;
	import com.jkgh.jvm.parsing.types.DoubleConstantEntry;
	import com.jkgh.jvm.parsing.types.FieldConstantEntry;
	import com.jkgh.jvm.parsing.types.FloatConstantEntry;
	import com.jkgh.jvm.parsing.types.IntegerConstantEntry;
	import com.jkgh.jvm.parsing.types.InterfaceMethodConstantEntry;
	import com.jkgh.jvm.parsing.types.LongConstantEntry;
	import com.jkgh.jvm.parsing.types.MethodConstantEntry;
	import com.jkgh.jvm.parsing.types.NameAndTypeConstantEntry;
	import com.jkgh.jvm.parsing.types.StringConstantEntry;
	import com.jkgh.jvm.parsing.types.UTF8ConstantEntry;
	
	public class ConstantEntryParser {
		public static const CONSTANT_UTF8:int = 1;
		public static const CONSTANT_INTEGER:int = 3;
		public static const CONSTANT_FLOAT:int = 4;
		public static const CONSTANT_LONG:int = 5;
		public static const CONSTANT_DOUBLE:int = 6;
		public static const CONSTANT_CLASS:int = 7;
		public static const CONSTANT_STRING:int = 8;
		public static const CONSTANT_FIELD:int = 9;
		public static const CONSTANT_METHOD:int = 10;
		public static const CONSTANT_INTERFACEMETHOD:int = 11;
		public static const CONSTANT_NAMEANDTYPE:int = 12;
	
		public static function isEightByteConstantThatUsesTwoPoolEntries(constant:ConstantEntry):Boolean {
			return constant.getTag() == CONSTANT_DOUBLE || constant.getTag() == CONSTANT_LONG;
		}
	
		public static function parseNextConstant(dataInputStream:ByteArray):ConstantEntry {
			var tag:int = dataInputStream.readByte();
	
			switch (tag) {
			case CONSTANT_UTF8:
				return new UTF8ConstantEntry(dataInputStream);
			case CONSTANT_INTEGER:
				return new IntegerConstantEntry(dataInputStream);
			case CONSTANT_FLOAT:
				return new FloatConstantEntry(dataInputStream);
			case CONSTANT_LONG:
				return new LongConstantEntry(dataInputStream);
			case CONSTANT_DOUBLE:
				return new DoubleConstantEntry(dataInputStream);
			case CONSTANT_CLASS:
				return new ClassConstantEntry(dataInputStream);
			case CONSTANT_STRING:
				return new StringConstantEntry(dataInputStream);
			case CONSTANT_FIELD:
				return new FieldConstantEntry(dataInputStream);
			case CONSTANT_METHOD:
				return new MethodConstantEntry(dataInputStream);
			case CONSTANT_INTERFACEMETHOD:
				return new InterfaceMethodConstantEntry(dataInputStream);
			case CONSTANT_NAMEANDTYPE:
				return new NameAndTypeConstantEntry(dataInputStream);
			default:
				throw new Error("Unknown constant: " + tag);
			}
		}
	
	}
}
