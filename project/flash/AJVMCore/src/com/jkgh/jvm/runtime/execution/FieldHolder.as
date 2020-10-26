package com.jkgh.jvm.runtime.execution {
	import flash.utils.Dictionary;
	
	
	public class FieldHolder {
	
		protected var fieldValues:Dictionary/*JVMField, Object*/;
	
		public function FieldHolder() {
			this.fieldValues = new Dictionary();
		}
	
		public function getFieldValue(jvmField:JVMField):Object {
			return fieldValues[jvmField];
		}
	
		public function setFieldValue(f:JVMField, value:Object):void {
			fieldValues[f] = value;
		}
	
	}
}
