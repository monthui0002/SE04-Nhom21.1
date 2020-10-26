package com.jkgh.jvm.runtime.execution {
	
	
	import com.jkgh.jvm.parsing.parsers.CodeParser;
	import com.jkgh.jvm.parsing.types.AttributeInfo;
	import com.jkgh.jvm.parsing.types.MethodInfo;
	import com.jkgh.jvm.runtime.classloading.JVMClassLoadingContext;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	
	public class JVMMethod {
	
		private var flags:JVMMethodFlags;
		private var identity:JVMMethodIdentity;
		private var code:JVMCode;
		private var ownerClass:JVMClass;
	
		public static function fromInfo(classLoadingContext:JVMClassLoadingContext, ownerClass:JVMClass, m:MethodInfo):JVMMethod {
			var rthis:JVMMethod = new JVMMethod();
			rthis.ownerClass = ownerClass;
			rthis.identity = JVMMethodIdentity.fromInfo(classLoadingContext, m);
			rthis.flags = JVMMethodFlags.fromInfo(m);
			var foundCode:JVMCode = findCode(classLoadingContext, m);
			if (!rthis.flags.isAbstract() && foundCode == null) {
				foundCode = classLoadingContext.getRuntime().getNativeCodeFor(ownerClass, rthis.identity);
				if (foundCode == null) {
					throw new Error("Missing code for "+rthis+".");
				}
			}
			rthis.code = foundCode;
			return rthis;
		}
	
		private static function findCode(classLoadingContext:JVMClassLoadingContext, m:MethodInfo):JVMCode {
			for each (var a:AttributeInfo in m.getAttributes()) {
				if (a.getName() == "Code") {
					return CodeParser.parse(classLoadingContext, a.getValue(), m);
				}
			}
			return null;
		}
		
		public static function fromValues(ownerClass:JVMClass, identity:JVMMethodIdentity, flags:JVMMethodFlags, code:JVMCode):JVMMethod {
			var rthis:JVMMethod = new JVMMethod();
			rthis.ownerClass = ownerClass;
			rthis.identity = identity;
			rthis.flags = flags;
			rthis.code = code;
			return rthis;
		}
	
		public static function fromNativeCode(identity:JVMMethodIdentity, nativeCode:NativeCode):JVMMethod {
			var rthis:JVMMethod = new JVMMethod();
			rthis.identity = identity;
			rthis.flags = JVMMethodFlags.fromValues(JVMMemberFlags.fromValues(false, false, JVMAccess.PUBLIC), false, true, false, false);
			rthis.code = nativeCode;
			return rthis;
		}
	
		public function toString():String {
			return ownerClass+": "+flags+""+identity;
		}
		
		public function getFlags():JVMMethodFlags {
			return flags;
		}
	
		public function getIdentity():JVMMethodIdentity {
			return identity;
		}
	
		public function getCode():JVMCode {
			return code;
		}
	
		public function prepareLocalVariableArray(frame:FrameExecutionContext):Vector.<Object> {
			var ret:Vector.<Object> = new Vector.<Object>();
			
			var needed:int = 0;
			if (!flags.isStatic()) {
				++needed;
			}
			for each (var a:JVMType in identity.getParameterTypes()) {
				needed += a.getWordSize();
			}
			
			if (flags.isNative()) {
				for (var i:int = 0; i<needed; ++i) {
					ret.push(FrameExecutionContext.EMPTY);
				}
			} else {
				for (var j:int = 0; j<code.getMaxLocals(); ++j) {
					ret.push(FrameExecutionContext.EMPTY);
				}
			}
			for (var k:int = needed-1; k >= 0; --k) {
				ret[k] = frame.popOne();
			}
			return ret;	
		}
	
		public function getOwnerClass():JVMClass {
			return ownerClass;
		}
	
	}
}
