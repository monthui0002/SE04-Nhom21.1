package com.jkgh.jvm.gateways {

	import com.jkgh.jvm.runtime.execution.JVMThread;
	
	public class Lock {
		
		private var owner:JVMThread;
		private var count:int;
		private var waiters:Vector.<LockWaiter>;
		
		public function Lock(owner:JVMThread) {
			this.owner = owner;
			this.count = 1;
			this.waiters = new Vector.<LockWaiter>();
		}
		
		public function lock(thread:JVMThread, onReturn:Function):void {
			if (owner == thread) {
				++count;
				onReturn(null);
			} else {
				waiters.push(new LockWaiter(thread, onReturn));
			}
		}
		
		public function unlock(thread:JVMThread):int {
			if (owner == thread) {
				--count;
				if (count == 0) {
					if (waiters.length > 0) {
						var waiter:LockWaiter = waiters.pop();
						this.owner = waiter.getThread();
						this.count = 1;
						waiter.doOnReturn();
						return 1;
					} else {
						return 0;
					}
				} else {
					return count;
				}
			} else {
				return -1;
			}
		}
	}
}