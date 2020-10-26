package com.jkgh.jvm.runtime.execution {
	
	import com.jkgh.jvm.parsing.types.FieldInfo;
	
	public class JVMFieldFlags extends JVMMemberFlags {
	
		private var iTransient:Boolean;
		private var iVolatile:Boolean;
	
		public static function fromValues(iFinal:Boolean, iStatic:Boolean, access:JVMAccess, iTransient:Boolean, iVolatile:Boolean):JVMFieldFlags {
			var rthis:JVMFieldFlags = new JVMFieldFlags();
			rthis.setFinal(iFinal);
			rthis.setStatic(iStatic);
			rthis.setAccess(access);
			rthis.iTransient = iTransient;
			rthis.iVolatile = iVolatile;
			return rthis;
		}
		
		public static function fromInfo(f:FieldInfo):JVMFieldFlags {
			var rthis:JVMFieldFlags = new JVMFieldFlags();
			rthis.setFinal(f.isFinal());
			rthis.setStatic(f.isStatic());
			rthis.setAccess(JVMAccess.fromMemberInfo(f));
			rthis.iTransient = f.isTransient();
			rthis.iVolatile = f.isVolatile();
			return rthis;
		}
	
		override public function toString():String {
			return super.toString()+(iTransient ? "transient " : "")+(iVolatile ? "volatile " : "");
		}
		
		public function isTransient():Boolean {
			return iTransient;
		}
	
		public function setTransient(iTransient:Boolean):void {
			this.iTransient = iTransient;
		}
	
		public function isVolatile():Boolean {
			return iVolatile;
		}
	
		public function setVolatile(iVolatile:Boolean):void {
			this.iVolatile = iVolatile;
		}
	
	}
}
