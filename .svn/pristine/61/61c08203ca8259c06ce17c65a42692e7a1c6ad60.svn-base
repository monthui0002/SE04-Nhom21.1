package com.jkgh.jvm.runtime.execution {

	import com.jkgh.jvm.runtime.execution.JVMThread;

	public class JVMMonitor {
		
		private var current:JVMThread;
		private var currentReentrance:int;
		private var waiters:Vector.<JVMThread>;
		
		public function JVMMonitor(current:JVMThread) {
			this.current = current;
			this.currentReentrance = 1;
			this.waiters = new Vector.<JVMThread>();
		}
		
		public function addWaiting(thread:JVMThread):void {
			if (thread == current) {
				++currentReentrance;
			} else {
				waiters.push(thread);
				thread.setWaiting(true);
			}
		}
		
		public function exit(thread:JVMThread):Boolean {
			if (current != thread) {
				throw new Error("Thread "+thread+" exitted the monitor of object "+this+" while the owner was "+current+"!");
			}
			if (currentReentrance == 1) {
				if (waiters.length > 0) {
					this.current = waiters.pop();
					current.setWaiting(false);
					return true;
				} else {
					return false;
				}
			} else {
				--currentReentrance;
				return true;
			}
		}
	}
}