package com.jkgh.jvm.parsing.types {
	
	
	import com.jkgh.jvm.parsing.parsers.MemberFlagParser;
	
	public class FieldInfo extends MemberInfo {
	
		private var typeName:String;
	
		public function FieldInfo(name:String, flags:int, descriptor:String, attributes:Vector.<AttributeInfo>, constantPool:ConstantPool) {
			super(name, attributes, flags, constantPool);
	
			this.typeName = descriptor;
		}
	
		public function isVolatile():Boolean {
			return MemberFlagParser.hasVolatile(getFlags());
		}
	
		public function isTransient():Boolean {
			return MemberFlagParser.hasTransient(getFlags());
		}
	
		public function getTypeName():String {
			return typeName;
		}
	
	}
}
