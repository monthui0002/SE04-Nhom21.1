package com.jkgh.jvm.parsing.parsers {
	
	
	import flash.utils.ByteArray;
	import com.jkgh.jvm.parsing.types.ClassConstantEntry;
	import com.jkgh.jvm.parsing.types.ConstantEntry;
	import com.jkgh.jvm.parsing.types.ConstantPool;
	import com.jkgh.jvm.parsing.types.FileHeaderInfo;
	import com.jkgh.jvm.parsing.types.StringConstantEntry;
	
	public class ConstantPoolParser {
		
		public static function parse(dataInput:ByteArray, fileHeaderInfo:FileHeaderInfo):ConstantPool {
			var constantPool:Vector.<ConstantEntry> = new Vector.<ConstantEntry>(fileHeaderInfo.constantPoolSize());
	
			for (var i:int = 1; i < fileHeaderInfo.constantPoolSize(); ++i) {
				var constant:ConstantEntry = ConstantEntryParser.parseNextConstant(dataInput);
	
				constantPool[i] = constant;
	
				if (ConstantEntryParser.isEightByteConstantThatUsesTwoPoolEntries(constant)) {
					++i;
				}
			}
	
			for (var j:int = 0; j < constantPool.length; ++j) {
				var c:ConstantEntry = constantPool[j];
				if (c is StringConstantEntry) {
					constantPool[j] = constantPool[((StringConstantEntry) (c)).getIndex()];
				} else if (c is ClassConstantEntry) {
					constantPool[j] = constantPool[((ClassConstantEntry) (c)).getNameIndex()];
				}
			}
			
			return new ConstantPool(constantPool);
		}
	
	}
}
