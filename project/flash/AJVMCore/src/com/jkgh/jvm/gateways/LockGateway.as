package com.jkgh.jvm.gateways {
	
	import com.jkgh.jvm.runtime.execution.JVMThread;
	
	import flash.utils.Dictionary;

	public class LockGateway {
		
		private static var locks:Dictionary = new Dictionary();
		
		public static function lock(lockID:int, thread:JVMThread, onReturn:Function):void {
			var lock:Lock = locks[lockID];
			if (lock == null) {
				locks[lockID] = new Lock(thread);
				onReturn(null);
			} else {
				lock.lock(thread, onReturn);
			}
		}
		
		public static function unlock(lockID:int, thread:JVMThread):int {
			var lock:Lock = locks[lockID];
			if (lock == null) {
				return -1;
			} else {
				var result:int = lock.unlock(thread);
				if (result == -1) {
					return -1;
				} else {
					if (result == 0) {
						delete locks[lockID];
					}
					return 0;	
				}
			}
		}
	}
}