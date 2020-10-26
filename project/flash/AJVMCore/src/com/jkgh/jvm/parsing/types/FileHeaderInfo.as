package com.jkgh.jvm.parsing.types {
	
	public class FileHeaderInfo {
		
		private var myMagic:int;
		private var myMajorVersion:int;
		private var myMinorVersion:int;
		private var myConstantPoolSize:int;
	
		public function FileHeaderInfo(magic:int, majorVersion:int, minorVersion:int, constantPoolSize:int) {
			this.myMagic = magic;
			this.myMajorVersion = majorVersion;
			this.myMinorVersion = minorVersion;
			this.myConstantPoolSize = constantPoolSize;
		}
	
		public function constantPoolSize():int {
			return myConstantPoolSize;
		}
	
		public function magic():int {
			return myMagic;
		}
	
		public function majorVersion():int {
			return myMajorVersion;
		}
	
		public function minorVersion():int {
			return myMinorVersion;
		}
	
	}
}
