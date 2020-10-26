package com.jkgh.jvm.runtime.execution {
	
	
	import com.jkgh.jvm.runtime.classloading.JVMClassLoadingContext;
	
	public class JVMArrayClass extends JVMClass {
	
		private var componentType:JVMType;
	
		public function JVMArrayClass(classLoadingContext:JVMClassLoadingContext, componentTypeDescriptor:String) {
			super(classLoadingContext, null, "["+componentTypeDescriptor, classLoadingContext.getJVMClass("java/lang/Object"), getArrayInterfaces(classLoadingContext), JVMClassFlags.fromValues(false, true, false, true, true), new Vector.<JVMField>(), new Vector.<JVMMethod>());
			this.componentType = classLoadingContext.resolveType(componentTypeDescriptor);
		}
	
		override public function toString():String {
			return componentType+"[]";
		}
		
		private static function getArrayInterfaces(classLoadingContext:JVMClassLoadingContext):Vector.<JVMClass> {
			return Vector.<JVMClass>([classLoadingContext.getJVMClass("java/lang/Cloneable")]);
		}
	
		public function getComponentType():JVMType {
			return componentType;
		}
	
		override public function instantiate():JVMObject {
			return instantiateArray();
		}
		
		public function instantiateArray(count:int = 0):JVMArrayObject {
			return new JVMArrayObject(this, count);
		}
	
		override public function getJavaName():String {
			return getDescriptor();
		}
		
		override public function getDescriptor():String {
			return "["+componentType.getDescriptor();
		}
		
		override public function isCastableTo(jvmClass:JVMClass):Boolean {
			if (super.isCastableTo(jvmClass)) {
				return true;
			} else {
				if (jvmClass is JVMArrayClass) {
					var jvmArrayClass:JVMArrayClass = (JVMArrayClass)(jvmClass);
					if (componentType is JVMClass) {
						if (jvmArrayClass.getComponentType() is JVMClass) {
							var componentClass:JVMClass = (JVMClass)(componentType);
							var jvmArrayClassComponentClass:JVMClass = (JVMClass)(jvmArrayClass.getComponentType());
							return componentClass.isCastableTo(jvmArrayClassComponentClass);
						} else {
							return false;
						}
					} else {
						if (jvmArrayClass.getComponentType() is JVMClass) {
							return false;
						} else {
							return componentType == jvmArrayClass.getComponentType();
						}
					}
				} else {
					return false;
				}
			} 
		}
	}
}
