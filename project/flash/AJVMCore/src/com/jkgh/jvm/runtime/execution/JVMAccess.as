package com.jkgh.jvm.runtime.execution {
	
	import com.jkgh.jvm.parsing.types.MemberInfo;
	
	public class JVMAccess {
	
		public static const PRIVATE:JVMAccess = new JVMAccess("private");
		public static const PROTECTED:JVMAccess = new JVMAccess("protected");
		public static const PUBLIC:JVMAccess = new JVMAccess("public");
		
		private var name:String;
	
		public function JVMAccess(name:String) {
			this.name = name;
		}
	
		public function toString():String {
			return name;
		}
		
		public static function fromMemberInfo(m:MemberInfo):JVMAccess {
			return m.isPublic() ? PUBLIC : m.isProtected() ? PROTECTED : PRIVATE;
		}
	
	}
}
