package com.jkgh.jvm.parsing.parsers {
	
	import flash.utils.ByteArray;
	import com.jkgh.jvm.parsing.types.FileHeaderInfo;
	
	public class FileHeaderInfoParser {
	
		public static function parse(din:ByteArray):FileHeaderInfo {
			var magic:int = din.readInt();
			var minorVersion:int = din.readUnsignedShort();
			var majorVersion:int = din.readUnsignedShort();
			var constantPoolSize:int = din.readUnsignedShort();
	
			return new FileHeaderInfo(magic, majorVersion, minorVersion, constantPoolSize);
		}
	}
}
