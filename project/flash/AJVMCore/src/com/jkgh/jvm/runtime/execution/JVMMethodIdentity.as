package com.jkgh.jvm.runtime.execution {
	
	
	import com.jkgh.jvm.parsing.types.MethodInfo;
	import com.jkgh.jvm.runtime.classloading.JVMClassLoadingContext;
	
	public class JVMMethodIdentity {
	
		private var name:String;
		private var returnType:JVMType;
		private var parameterTypes:Vector.<JVMType>;
		
		public static function fromInfo(classLoadingContext:JVMClassLoadingContext, m:MethodInfo):JVMMethodIdentity {
			var rthis:JVMMethodIdentity = new JVMMethodIdentity();
			rthis.name = m.getName();
			rthis.returnType = classLoadingContext.resolveType(m.getReturnTypeDescriptor());
			rthis.parameterTypes = new Vector.<JVMType>();
			for each (var p:String in m.getParameterTypeDescriptors()) {
				rthis.parameterTypes.push(classLoadingContext.resolveType(p));
			}
			return rthis;
		}
		
		public static function fromDescriptor(classLoadingContext:JVMClassLoadingContext, name:String, descriptor:String):JVMMethodIdentity {
			var rthis:JVMMethodIdentity = new JVMMethodIdentity();
			rthis.name = name;
			
			var closingPos:int = descriptor.indexOf(')');
			rthis.returnType = classLoadingContext.resolveType(descriptor.substring(closingPos+1));
			rthis.parameterTypes = new Vector.<JVMType>();
			
			var params:String = descriptor.substring(1, closingPos);
			var i:int = 0;
			while (i < params.length) {
				var param:String = findParam(params, i);
				rthis.parameterTypes.push(classLoadingContext.resolveType(param));
				i += param.length;
			}
			return rthis;
		}
	
		public static function fromValues(name:String, returnType:JVMType, parameterTypes:Vector.<JVMType>):JVMMethodIdentity {
			var rthis:JVMMethodIdentity = new JVMMethodIdentity();
			rthis.name = name;
			rthis.returnType = returnType;
			rthis.parameterTypes = parameterTypes;
			return rthis;
		}
	
		public function toString():String {
			var ps:String = "";
			for each (var p:JVMType in parameterTypes) {
				ps += p+", ";
			}
			if (ps.length > 0) {
				ps = ps.substring(0, ps.length-2);
			}
			return returnType+" "+name+"("+ps+")";
		}
		
		private static function findParam(params:String, i:int):String {
			var ch:String = params.charAt(i);
			
			if (ch == 'L') {
				var next:int = params.indexOf(';', i)+1;
				return params.substring(i, next);
			}
			
			if (ch == '[') {
				return "["+findParam(params, i+1);
			}
			
			return ch;
		}
		
		public function getName():String {
			return name;
		}
	
		public function getReturnType():JVMType {
			return returnType;
		}
	
		public function getParameterTypes():Vector.<JVMType> {
			return parameterTypes;
		}
		
		// TODO: tu jest problem. Dictionary nie uzyje tego...
		public function equals(obj:Object):Boolean {
			if (obj is JVMMethodIdentity) {
				var other:JVMMethodIdentity = (JVMMethodIdentity)(obj);
				return name == other.getName() && returnType == other.getReturnType() && haveSameElements(parameterTypes, other.getParameterTypes());
			} else {
				return false;
			}
		}

		private function haveSameElements(v1:Vector.<JVMType>, v2:Vector.<JVMType>):Boolean {
			if (v1.length == v2.length) {
				for (var i:int = 0; i<v1.length; ++i) {
					if (v1[i] != v2[i]) {
						return false;
					}
				}
				return true;
			}
			return false;
		}
	
		public function getDescriptor():String {
			var ps:String = "";
			for each (var p:JVMType in parameterTypes) {
				ps += p.getDescriptor();
			}
			return name+"("+ps+")"+returnType.getDescriptor();
		}
	}
}
