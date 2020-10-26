package com.jkgh.jvm.parsing.types {
	
	
	import com.jkgh.jvm.parsing.parsers.MemberFlagParser;
	
	public class MemberInfo {
	
		private var name:String;
		private var attributes:Vector.<AttributeInfo>;
		private var flags:int;
		private var constantPool:ConstantPool;
	
		public function MemberInfo(name:String, attributes:Vector.<AttributeInfo>, flags:int, constantPool:ConstantPool) {
			this.name = name;
			this.attributes = attributes;
			this.flags = flags;
			this.constantPool = constantPool;
		}
	
		public function isStatic():Boolean {
			return MemberFlagParser.hasStatic(getFlags());
		}
	
		public function isFinal():Boolean {
			return MemberFlagParser.hasFinal(getFlags());
		}
	
		public function isProtected():Boolean {
			return MemberFlagParser.hasProtected(getFlags());
		}
	
		public function isPrivate():Boolean {
			return MemberFlagParser.hasPrivate(getFlags());
		}
	
		public function isPublic():Boolean {
			return MemberFlagParser.hasPublic(getFlags());
		}
	
		public function getName():String {
			return name;
		}
	
		public function getAttributes():Vector.<AttributeInfo> {
			return attributes;
		}
	
		public function getFlags():int {
			return flags;
		}
	
		public function getConstantPool():ConstantPool {
			return constantPool;
		}
	
	}
}
