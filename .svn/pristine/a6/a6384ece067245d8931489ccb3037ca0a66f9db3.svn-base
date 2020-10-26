package com.jkgh.jvm.parsing.types {
	
	
	import com.jkgh.jvm.parsing.parsers.MemberFlagParser;
	
	public class MethodInfo extends MemberInfo {
	
		private var returnTypeDescriptor:String;
		private var parameterTypeDescriptors:Vector.<String>;
	
		public function MethodInfo(name:String, flags:int, descriptor:String, attributes:Vector.<AttributeInfo>, constantPool:ConstantPool) {
	
			super(name, attributes, flags, constantPool);
	
			var closingPos:int = descriptor.indexOf(')');
			this.returnTypeDescriptor = descriptor.substring(closingPos + 1);
			this.parameterTypeDescriptors = new Vector.<String>();
	
			var params:String = descriptor.substring(1, closingPos);
			var i:int = 0;
			while (i < params.length) {
				var param:String = findParam(params, i);
				parameterTypeDescriptors.push(param);
				i += param.length;
			}
		}
	
		private function findParam(params:String, i:int):String {
			var ch:String = params.charAt(i);
	
			if (ch == 'L') {
				var next:int = params.indexOf(';', i) + 1;
				return params.substring(i, next);
			}
	
			if (ch == '[') {
				return "[" + findParam(params, i + 1);
			}
	
			return ch;
		}
	
		public function isAbstract():Boolean {
			return MemberFlagParser.hasAbstract(getFlags());
		}
	
		public function isSynchronized():Boolean {
			return MemberFlagParser.hasSynchronized(getFlags());
		}
	
		public function isNative():Boolean {
			return MemberFlagParser.hasNative(getFlags());
		}
	
		public function isStrict():Boolean {
			return MemberFlagParser.hasStrict(getFlags());
		}
	
		public function getReturnTypeDescriptor():String {
			return returnTypeDescriptor;
		}
	
		public function getParameterTypeDescriptors():Vector.<String> {
			return parameterTypeDescriptors;
		}
		
		public function toString():String {
			return getReturnTypeDescriptor()+" "+getName()+"("+getParameterTypeDescriptors()+")";
		}
	}
}
