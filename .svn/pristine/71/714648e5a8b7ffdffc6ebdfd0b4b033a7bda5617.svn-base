package com.jkgh.jvm.runtime.execution {
	
	
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	
	
	public class NativeCode extends JVMCode {
		
		private var onRun:Function;
	
		public function NativeCode(onRun:Function) {
			super(0, 0, null, null);
			this.onRun = onRun;
		}
	
		public function run(currentFrame:FrameExecutionContext, args:Vector.<Object>, onReturn:Function):void {
			onRun(currentFrame, args, onReturn);
		}

	}
}
