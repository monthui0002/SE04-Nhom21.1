package com.jkgh.jvm.runtime.execution {
	import flash.utils.ByteArray;
	import com.jkgh.jvm.parsing.types.ConstantEntry;
	import com.jkgh.jvm.parsing.types.FieldInfo;
	import com.jkgh.jvm.runtime.classloading.JVMClassLoadingContext;
	import com.jkgh.jvm.tools.JVMTools;
	
	public class JVMConstantValueFieldAttribute implements JVMFieldAttribute {
	
		private var constantValue:ConstantEntry;
	
		public function JVMConstantValueFieldAttribute(classLoadingContext:JVMClassLoadingContext, f:FieldInfo, value:ByteArray) {
			var index:int = JVMTools.readUnsignedShort(value, 0);
			this.constantValue = f.getConstantPool().getConstantAt(index);
		}
	
		public function getConstantValue():ConstantEntry {
			return constantValue;
		}
	
	}
}
