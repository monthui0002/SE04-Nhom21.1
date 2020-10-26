package com.jkgh.jvm.runtime.execution {
	
	import com.jkgh.jvm.parsing.types.MemberInfo;
	
	public class JVMMemberFlags {
	
		private var iFinal:Boolean;
		private var iStatic:Boolean;
		private var access:JVMAccess;
	
		public static function fromInfo(m:MemberInfo):JVMMemberFlags {
			var rthis:JVMMemberFlags = new JVMMemberFlags();
			rthis.iFinal = m.isFinal();
			rthis.iStatic = m.isStatic();
			rthis.access = JVMAccess.fromMemberInfo(m);
			return rthis;
		}
	
		public static function fromValues(iFinal:Boolean, iStatic:Boolean, access:JVMAccess):JVMMemberFlags {
			var rthis:JVMMemberFlags = new JVMMemberFlags();
			rthis.iFinal = iFinal;
			rthis.iStatic = iStatic;
			rthis.access = access;
			return rthis;
		}
	
		public static function fromOther(memberFlags:JVMMemberFlags):JVMMemberFlags {
			var rthis:JVMMemberFlags = new JVMMemberFlags();
			rthis.iFinal = memberFlags.isFinal();
			rthis.iStatic = memberFlags.isStatic();
			rthis.access = memberFlags.getAccess();
			return rthis;
		}
	
		public function toString():String {
			return access+" "+(iFinal ? "final " : "")+(iStatic ? "static " : "");
		}
		
		public function isFinal():Boolean {
			return iFinal;
		}
	
		public function setFinal(iFinal:Boolean):void {
			this.iFinal = iFinal;
		}
	
		public function isStatic():Boolean {
			return iStatic;
		}
	
		public function setStatic(iStatic:Boolean):void {
			this.iStatic = iStatic;
		}
	
		public function getAccess():JVMAccess {
			return access;
		}
	
		public function setAccess(access:JVMAccess):void {
			this.access = access;
		}
	
	}
}
