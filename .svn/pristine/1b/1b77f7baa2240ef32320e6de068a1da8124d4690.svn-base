package com.jkgh.jvm.runtime.execution {
	
	import com.jkgh.jvm.tools.JVMTools;
	
	public class JVMObject extends FieldHolder {
	
		private static var idGenerator:uint = 1;
		
		private var jvmClass:JVMClass;
		private var id:uint;
		private var monitor:JVMMonitor;
				
		public function JVMObject(jvmClass:JVMClass = null) {
			this.id = ++idGenerator;
			this.jvmClass = jvmClass;
			this.monitor = null;
			if (jvmClass != null) {
				jvmClass.initAllFields(this);
			}
		}
	
		public function getJVMClass():JVMClass {
			return jvmClass;
		}
	
		public function toString():String {
			return jvmClass+"@"+hashCode()+(jvmClass.getFullyQualifiedName() == "java/lang/String" ? "(String: "+JVMTools.readJVMString(this)+")" : JVMTools.endsWith(jvmClass.getFullyQualifiedName(), "Exception") || JVMTools.endsWith(jvmClass.getFullyQualifiedName(), "Error") ? "(Exception: "+JVMTools.readJVMString((JVMObject)(getFieldValue(jvmClass.resolveField("detailMessage"))))+")" : "");
		}

		public function hashCode():int {
			return id;
		}
		
		public function enterMonitor(thread:JVMThread):void {
			if (monitor == null) {
				this.monitor = new JVMMonitor(thread);
			} else {
				monitor.addWaiting(thread);
			}
		}
		
		public function exitMonitor(thread:JVMThread):void {
			var hadWaiters:Boolean = monitor.exit(thread);
			if (!hadWaiters) {
				this.monitor = null;
			}
		}
		
		public function clone():JVMObject {
			var ret:JVMObject = new JVMObject();
			ret.jvmClass = jvmClass;
			for (var field:* in fieldValues) {
				ret.fieldValues[field] = fieldValues[field];
			}
			return ret;
		}
	}
}
