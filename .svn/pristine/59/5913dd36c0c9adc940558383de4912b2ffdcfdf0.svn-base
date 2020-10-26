package com.jkgh.jvm.parsing.parsers {
	
	public class ClassFlagParser {
		
		public static const ACC_PUBLIC:int = 0x0001;
		public static const ACC_FINAL:int = 0x0010;
		public static const ACC_SUPER:int = 0x0020;
		public static const ACC_INTERFACE:int = 0x0200;
		public static const ACC_ABSTRACT:int = 0x0400;
	
		public static function hasPublic(accessFlag:int):Boolean {
			return (accessFlag & ACC_PUBLIC) != 0;
		}
		
		public static function hasSuper(accessFlag:int):Boolean {
			return (accessFlag & ACC_SUPER) != 0;
		}
	
		public static function hasInterface(accessFlag:int):Boolean {
			return (accessFlag & ACC_INTERFACE) != 0;
		}
		
		public static function hasFinal(accessFlag:int):Boolean {
			return (accessFlag & ACC_FINAL) != 0;
		}
		
		public static function hasAbstract(accessFlag:int):Boolean {
			return (accessFlag & ACC_ABSTRACT) != 0;
		}
	}
}
