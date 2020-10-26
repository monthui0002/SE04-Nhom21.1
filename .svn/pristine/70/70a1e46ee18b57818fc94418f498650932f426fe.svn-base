package com.jkgh.jvm.runtime.execution {
	
	import com.jkgh.jvm.parsing.types.MethodInfo;
	
	public class JVMMethodFlags extends JVMMemberFlags {
	
		private var iAbstract:Boolean;
		private var iNative:Boolean;
		private var iStrict:Boolean;
		private var iSynchronized:Boolean;
	
		public static function fromInfo(m:MethodInfo):JVMMethodFlags {
			var rthis:JVMMethodFlags = new JVMMethodFlags();
			rthis.setFinal(m.isFinal());
			rthis.setStatic(m.isStatic());
			rthis.setAccess(JVMAccess.fromMemberInfo(m));
			rthis.iAbstract = m.isAbstract();
			rthis.iNative = m.isNative();
			rthis.iStrict = m.isStrict();
			rthis.iSynchronized = m.isSynchronized();
			return rthis;
		}
	
		public static function fromValues(memberFlags:JVMMemberFlags, iAbstract:Boolean, iNative:Boolean, iStrict:Boolean, iSynchronized:Boolean):JVMMethodFlags {
			var rthis:JVMMethodFlags = new JVMMethodFlags();
			rthis.setFinal(memberFlags.isFinal());
			rthis.setStatic(memberFlags.isStatic());
			rthis.setAccess(memberFlags.getAccess());
			rthis.iAbstract = iAbstract;
			rthis.iNative = iNative;
			rthis.iStrict = iStrict;
			rthis.iSynchronized = iSynchronized;
			return rthis;
		}
		
		override public function toString():String {
			return super.toString()+(iAbstract ? "abstract " : "")+(iNative ? "native " : "")+(iStrict ? "strict " : "")+(iSynchronized ? "synchronized " : "");
		}
		
		public function isAbstract():Boolean {
			return iAbstract;
		}
	
		public function setAbstract(iAbstract:Boolean):void {
			this.iAbstract = iAbstract;
		}
	
		public function isNative():Boolean {
			return iNative;
		}
	
		public function setNative(iNative:Boolean):void {
			this.iNative = iNative;
		}
	
		public function isStrict():Boolean {
			return iStrict;
		}
	
		public function setStrict(iStrict:Boolean):void {
			this.iStrict = iStrict;
		}
	
		public function isSynchronized():Boolean {
			return iSynchronized;
		}
	
		public function setSynchronized(iSynchronized:Boolean):void {
			this.iSynchronized = iSynchronized;
		}
	
	}
}
