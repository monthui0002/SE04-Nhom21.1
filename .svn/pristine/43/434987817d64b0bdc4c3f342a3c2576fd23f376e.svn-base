package com.jkgh.jvm.parsing.types {
	
	
	
	public class ParsedJavaClass {
		
		private var fileHeaderInfo:FileHeaderInfo;
		private var classInfo:ClassInfo;
		private var fieldInfos:Vector.<FieldInfo>;
		private var methodInfos:Vector.<MethodInfo>;
		private var constantPool:ConstantPool;
		private var enclosingMethodAttributeInfo:EnclosingMethodAttributeInfo;
	
		public function ParsedJavaClass(fileHeaderInfo:FileHeaderInfo, classInfo:ClassInfo, fieldInfos:Vector.<FieldInfo>, methodInfos:Vector.<MethodInfo>, enclosingMethodAttributeInfo:EnclosingMethodAttributeInfo, constantPool:ConstantPool) {
			
			this.fileHeaderInfo = fileHeaderInfo;
			this.classInfo = classInfo;
			this.fieldInfos = fieldInfos;
			this.methodInfos = methodInfos;
			this.constantPool = constantPool;
			this.enclosingMethodAttributeInfo = enclosingMethodAttributeInfo;
		}
	
		public function getConstantPool():ConstantPool {
			return constantPool;
		}
	
		public function getFieldInfos():Vector.<FieldInfo> {
			return fieldInfos;
		}
	
		public function getMethodInfos():Vector.<MethodInfo> {
			return methodInfos;
		}
	
		public function getFileHeaderInfo():FileHeaderInfo {
			return fileHeaderInfo;
		}
	
		public function getClassInfo():ClassInfo {
			return classInfo;
		}
	
		public function getEnclosingMethodAttributeInfo():EnclosingMethodAttributeInfo {
			return enclosingMethodAttributeInfo;
		}
	
	}
}
