package com.jkgh.jvm.runtime.execution {
	
	import com.jkgh.jvm.parsing.types.ClassInfo;
	
	public class JVMClassFlags {
	
		private var iAbstract:Boolean;
		private var iFinal:Boolean;
		private var iInterface:Boolean;
		private var iPublic:Boolean;
		private var iSuper:Boolean;
	
		public static function fromClassInfo(classInfo:ClassInfo):JVMClassFlags {
			var rthis:JVMClassFlags = new JVMClassFlags();
			rthis.iAbstract = classInfo.isAbstract();
			rthis.iFinal = classInfo.isFinal();
			rthis.iInterface = classInfo.isInterface();
			rthis.iPublic = classInfo.isPublic();
			rthis.iSuper = classInfo.isSuper();
			return rthis;
		}
	
		public static function fromValues(isAbstract:Boolean, isFinal:Boolean, isInterface:Boolean, isPublic:Boolean, isSuper:Boolean):JVMClassFlags {
			var rthis:JVMClassFlags = new JVMClassFlags();
			rthis.iAbstract = isAbstract;
			rthis.iFinal = isFinal;
			rthis.iInterface = isInterface;
			rthis.iPublic = isPublic;
			rthis.iSuper = isSuper;
			return rthis;
		}
	
		public function isAbstract():Boolean {
			return iAbstract;
		}
	
		public function setAbstract(iAbstract:Boolean):void {
			this.iAbstract = iAbstract;
		}
	
		public function isFinal():Boolean {
			return iFinal;
		}
	
		public function setFinal(iFinal:Boolean):void {
			this.iFinal = iFinal;
		}
	
		public function isInterface():Boolean {
			return iInterface;
		}
	
		public function setInterface(iInterface:Boolean):void {
			this.iInterface = iInterface;
		}
	
		public function isPublic():Boolean {
			return iPublic;
		}
	
		public function setPublic(iPublic:Boolean):void {
			this.iPublic = iPublic;
		}
	
		public function isSuper():Boolean {
			return iSuper;
		}
	
		public function setSuper(iSuper:Boolean):void {
			this.iSuper = iSuper;
		}
	
	}
}
