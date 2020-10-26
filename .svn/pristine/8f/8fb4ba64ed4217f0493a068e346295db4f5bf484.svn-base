package com.jkgh.jvm.gateways {
	
	import com.jkgh.jvm.runtime.execution.JVMThread;
	
	import flash.utils.Dictionary;

	public class SemaphoreGateway {
		
		private static var semaphores:Dictionary = new Dictionary();

		public static function pass(semaphoreID:int, onReturn:Function):void {
			var semaphore:Semaphore = semaphores[semaphoreID];
			if (semaphore != null) {
				semaphore.pass(onReturn);
			} else {
				onReturn(null);
			}
		}
		
		public static function open(semaphoreID:int):void {
			var semaphore:Semaphore = semaphores[semaphoreID];
			if (semaphore != null) {
				semaphore.open();
				delete semaphores[semaphoreID];
			}
		}
		
		public static function close(semaphoreID:int):void {
			var semaphore:Semaphore = semaphores[semaphoreID];
			if (semaphore == null) {
				semaphores[semaphoreID] = new Semaphore();
			}
		}

	}
}