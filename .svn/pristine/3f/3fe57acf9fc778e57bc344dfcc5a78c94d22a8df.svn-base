package com.jkgh.jvm.gateways {
	
	import com.jkgh.jvm.runtime.execution.JVMThread;
	
	public class LockWaiter {
		
		private var thread:JVMThread;
		private var onReturn:Function;
		
		public function LockWaiter(thread:JVMThread, onReturn:Function) {
			this.thread = thread;
			this.onReturn = onReturn;
		}
		
		public function getThread():JVMThread {
			return thread;
		}
		
		public function doOnReturn():void {
			onReturn(null);
		}
	}
}