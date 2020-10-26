package com.jkgh.jvm.parsing.parsers {
	
	public class MemberFlagParser {
		
		public static const ACC_PUBLIC:int = 0x0001;
		public static const ACC_PRIVATE:int = 0x0002;
		public static const ACC_PROTECTED:int = 0x0004;
		public static const ACC_STATIC:int = 0x0008;
		public static const ACC_FINAL:int = 0x0010;
		public static const ACC_SYNCHRONIZED:int = 0x0020;
		public static const ACC_VOLATILE:int = 0x0040;
		public static const ACC_TRANSIENT:int = 0x0080;
		public static const ACC_NATIVE:int = 0x0100;
		public static const ACC_ABSTRACT:int = 0x0400;
		public static const ACC_STRICT:int = 0x0800;
	
		public static function hasPublic(accessFlag:int):Boolean {
			return (accessFlag & ACC_PUBLIC) != 0;
		}
	
		public static function hasPrivate(accessFlag:int):Boolean {
			return (accessFlag & ACC_PRIVATE) != 0;
		}
	
		public static function hasProtected(accessFlag:int):Boolean {
			return (accessFlag & ACC_PROTECTED) != 0;
		}
	
		public static function hasStatic(accessFlag:int):Boolean {
			return (accessFlag & ACC_STATIC) != 0;
		}
	
		public static function hasFinal(accessFlag:int):Boolean {
			return (accessFlag & ACC_FINAL) != 0;
		}
	
		public static function hasSynchronized(accessFlag:int):Boolean {
			return (accessFlag & ACC_SYNCHRONIZED) != 0;
		}
	
		public static function hasVolatile(accessFlag:int):Boolean {
			return (accessFlag & ACC_VOLATILE) != 0;
		}
	
		public static function hasTransient(accessFlag:int):Boolean {
			return (accessFlag & ACC_TRANSIENT) != 0;
		}
	
		public static function hasNative(accessFlag:int):Boolean {
			return (accessFlag & ACC_NATIVE) != 0;
		}
	
		public static function hasAbstract(accessFlag:int):Boolean {
			return (accessFlag & ACC_ABSTRACT) != 0;
		}
	
		public static function hasStrict(accessFlag:int):Boolean {
			return (accessFlag & ACC_STRICT) != 0;
		}
	}
}
