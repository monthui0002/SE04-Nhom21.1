package com.jkgh.jvm.gateways {
	
	public class Semaphore {
		
		private var waiters:Vector.<Function>;
	
		public function Semaphore() {
			this.waiters = new Vector.<Function>();
		}
		
		public function open():void {
			for each (var waiter:Function in waiters) {
				waiter(null);
			}
		}
		
		public function pass(onReturn:Function):void {
			waiters.push(onReturn);
		}
	}
}