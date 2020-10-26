package com.jkgh.jvm.parsing.types {
	
	import flash.utils.ByteArray;
	
	public class ReferenceConstantEntry extends ConstantEntry {
	
		private var classIndex:int;
		private var nameAndTypeIndex:int;
	
		public function ReferenceConstantEntry(dataInputStream:ByteArray) {
			classIndex = dataInputStream.readShort();
			nameAndTypeIndex = dataInputStream.readShort();
		}
	
		public function getClassIndex():int {
			return classIndex;
		}
	
		public function getNameAndTypeIndex():int {
			return nameAndTypeIndex;
		}
	}
}
