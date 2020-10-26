package com.jkgh.jvm.runtime.execution {
	
	
	import com.jkgh.jvm.runtime.JVMRuntime;
	import com.jkgh.jvm.runtime.classloading.JVMClassLoadingContext;
	import com.jkgh.jvm.runtime.execution.control.ExceptionThrownResult;
	import com.jkgh.jvm.runtime.execution.control.ExecuteNextInstructionResult;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	import com.jkgh.jvm.runtime.execution.control.InstructionExecutionResult;
	import com.jkgh.jvm.runtime.execution.control.InvokeMethodResult;
	import com.jkgh.jvm.runtime.execution.control.KillThreadResult;
	import com.jkgh.jvm.runtime.execution.control.ReturnResult;
	import com.jkgh.jvm.runtime.execution.instructions.Instruction;
	import com.jkgh.jvm.runtime.execution.instructions.special.SbootstrapInstruction;
	import com.jkgh.jvm.tools.JVMTools;
	import com.jkgh.jvm.tools.Logger;
	
	public class JVMThread {
	
		private static const LOG:Logger = Logger.getLogger("AJVMInternal");
		
		public static const RUN_IDENTITY:JVMMethodIdentity = JVMMethodIdentity.fromValues("run", JVMPrimitiveVoid.INSTANCE, new Vector.<JVMType>());
		
		private var runtime:JVMRuntime;
		private var frameStack:Vector.<FrameExecutionContext>;
		private var jvmThread:JVMObject;
		
		private var waiting:Boolean;
		private var lastResult:InstructionExecutionResult;
		
		public static function fromMainMethod(runtime:JVMRuntime, mainMethod:JVMMethod, args:JVMArrayObject, jvmThread:JVMObject):JVMThread {
			var ret:JVMThread = new JVMThread();

			ret.runtime = runtime;
			ret.frameStack = new Vector.<FrameExecutionContext>();
			
			var initialContext:FrameExecutionContext = new FrameExecutionContext(ret, JVMMethod.fromValues(null, JVMMethodIdentity.fromValues("bootstrap", JVMPrimitiveVoid.INSTANCE, new Vector.<JVMType>()), JVMMethodFlags.fromValues(JVMMemberFlags.fromValues(true, true, JVMAccess.PRIVATE), false, true, false, false), null), new Vector.<Object>());
			initialContext.pushReference(args);
			
			ret.frameStack.push(initialContext);
			var bootStrapInstruction:SbootstrapInstruction = new SbootstrapInstruction(mainMethod);
			ret.lastResult = new ExecuteNextInstructionResult(bootStrapInstruction);
			
			ret.jvmThread = jvmThread;
			ret.jvmThread.setFieldValue(jvmThread.getJVMClass().resolveField("name"), JVMTools.createJVMStringObject(runtime.getStringClass(), runtime.getCharArrayClass(), "Main"));
			ret.waiting = false;
			
			return ret;
		}
	
		public static function fromRunMethod(runtime:JVMRuntime, runMethod:JVMMethod, jvmThread:JVMObject):JVMThread {
			var ret:JVMThread = new JVMThread();
			
			ret.runtime = runtime;
			ret.frameStack = new Vector.<FrameExecutionContext>();
			
			var initialContext:FrameExecutionContext = new FrameExecutionContext(ret, JVMMethod.fromValues(null, JVMMethodIdentity.fromValues("threadstart", JVMPrimitiveVoid.INSTANCE, new Vector.<JVMType>()), JVMMethodFlags.fromValues(JVMMemberFlags.fromValues(true, true, JVMAccess.PRIVATE), false, true, false, false), null), new Vector.<Object>());
			
			ret.frameStack.push(initialContext);
			
			initialContext.pushReference(jvmThread);
			
			var bootStrapInstruction:SbootstrapInstruction = new SbootstrapInstruction(runMethod);
			ret.lastResult = new ExecuteNextInstructionResult(bootStrapInstruction);
			
			ret.jvmThread = jvmThread;
			ret.waiting = false;
			
			return ret;
		}
		
		public function step():void {
			LOG.debug(["--- ", this, " ---\n", frameStack[frameStack.length-1]]);
			if (lastResult is ExecuteNextInstructionResult) {
				var realen:ExecuteNextInstructionResult = (ExecuteNextInstructionResult)(lastResult);
				var currentFrameen:FrameExecutionContext = frameStack[frameStack.length-1];
				var nextInstruction:Instruction = realen.getNextInstruction();
				LOG.debug(["Executing next instruction: ", nextInstruction]);
				currentFrameen.setCurrentInstruction(nextInstruction);
				lastResult = nextInstruction.execute(currentFrameen);
			} else if (lastResult is InvokeMethodResult) {
				var realim:InvokeMethodResult = (InvokeMethodResult)(lastResult);
				var method:JVMMethod = realim.getMethod();
				
				var currentFrame:FrameExecutionContext = frameStack[frameStack.length-1];
				currentFrame.setCurrentInstruction(realim.getNextInstruction());
				var locals:Vector.<Object> = method.prepareLocalVariableArray(currentFrame);
				
				if (method.getFlags().isNative()) {
					LOG.info(["Running native method: ", method], frameStack.length);
					var nativeCode:NativeCode = (NativeCode)(method.getCode());
					while (true) {
						var ioe:int = locals.indexOf(FrameExecutionContext.EMPTY);
						if (ioe == -1) {
							break;
						}
						locals.splice(ioe, 1);
					}
					this.waiting = true;
					lastResult = null;
					nativeCode.run(currentFrame, locals, function(ret:Object):void {
						setWaiting(false);
						if (ret != null && ret is SpecialNativeReturn) {
							var specialRet:SpecialNativeReturn = (SpecialNativeReturn)(ret);
							lastResult = specialRet.execute(currentFrame);
						} else {
							method.getIdentity().getReturnType().performPush(currentFrame, ret);
							lastResult = new ExecuteNextInstructionResult(currentFrame.getCurrentInstruction());
						}
					});
				} else {
					LOG.info(["Invoking java method: ", method], frameStack.length);
					
					var newFrame:FrameExecutionContext = new FrameExecutionContext(this, method, locals);
					if (method.getFlags().isSynchronized()) {
						var refn:JVMObject = method.getFlags().isStatic() ? method.getOwnerClass().getClassLock() : (JVMObject)(locals[0]);
						refn.enterMonitor(this);
						newFrame.setLock(refn);
					}
					frameStack.push(newFrame);
					
					var nextInstructionjm:Instruction = method.getCode().getEntryPoint();
					newFrame.setCurrentInstruction(nextInstructionjm);
					lastResult = new ExecuteNextInstructionResult(nextInstructionjm);
				}
			} else if (lastResult is ReturnResult) {
				
				var currentFramerr:FrameExecutionContext = frameStack.pop();
				
				var methodr:JVMMethod = currentFramerr.getMethod();
				if (methodr.getFlags().isSynchronized()) {
					var refx:JVMObject = currentFramerr.getLock();
					refx.exitMonitor(this);
				}
				
				if (frameStack.length > 0) {
					var callerFrame:FrameExecutionContext = frameStack[frameStack.length-1];
					var returnType:JVMType = currentFramerr.getMethod().getIdentity().getReturnType();
					if (returnType != JVMPrimitiveVoid.INSTANCE) {
						var returnedValue:Object = returnType.performPop(currentFramerr);
						LOG.info(["Returning from ", currentFramerr.getMethod(), ": ", returnedValue], frameStack.length);
						callerFrame.pushAnything(returnedValue);
					} else {
						LOG.info(["Returning from ", currentFramerr.getMethod(), ": void"], frameStack.length);
					}
					lastResult = new ExecuteNextInstructionResult(callerFrame.getCurrentInstruction());
				}
			} else if (lastResult is ExceptionThrownResult) {
				var real:ExceptionThrownResult = (ExceptionThrownResult)(lastResult);
				var currentFrameet:FrameExecutionContext = frameStack[frameStack.length-1];
				LOG.info(["Throwing exception: ", real.getExceptionReference()], frameStack.length);
				while (true) {
					var handler:JVMExceptionHandler = findHandler(currentFrameet, real.getExceptionReference().getJVMClass());
					if (handler == null) {
						LOG.info(["Abrupting method ", currentFrameet.getMethod(), "."], frameStack.length);
						frameStack.pop();
						if (frameStack.length == 1) {
							lastResult = new KillThreadResult(real.getExceptionReference());
							break;
						} else {
							currentFrameet = frameStack[frameStack.length-1];
						}
					} else {
						currentFrameet.clearStack();
						currentFrameet.pushReference(real.getExceptionReference());
						lastResult = new ExecuteNextInstructionResult(handler.getEntryInstruction());
						break;
					}
				}
			} else if (lastResult is KillThreadResult) {
				var realkt:KillThreadResult = (KillThreadResult)(lastResult);
				if (realkt.getAbruptionCause() == null) {
					LOG.info(["Thread ", this, " finished normally."]);
				} else {
					LOG.warning(["Thread ", this, " finished abruptly. Uncaught exception: ", realkt.getAbruptionCause(), "."]);
				}
				frameStack.splice(0, frameStack.length);
			}
		}
	
		private function findHandler(inFrame:FrameExecutionContext, thrownClass:JVMClass):JVMExceptionHandler {
			var currentInstruction:Instruction = inFrame.getCurrentInstruction();
			for each (var handler:JVMExceptionHandler in inFrame.getMethod().getCode().getExceptionHandlers()) {
				var handledClass:JVMClass = handler.getCatchableClass();
				if (currentInstruction.isInRangeOf(handler)) {
					if (thrownClass.isCastableTo(handledClass)) {
						return handler;
					}
				}
			}
			return null;
		}
	
		public function hasNextStep():Boolean {
			return frameStack.length > 0;
		}
	
		public function getRuntime():JVMRuntime {
			return runtime;
		}
	
		public function getClassLoadingContext():JVMClassLoadingContext {
			return runtime.getClassLoadingContext();
		}
	
		public function getFrame(i:int):FrameExecutionContext {
			return frameStack[i];
		}
	
		public function getFrameStack():Vector.<FrameExecutionContext> {
			return frameStack;
		}
	
		public function getJVMThread():JVMObject {
			return jvmThread;
		}
		
		public function setWaiting(waiting:Boolean):void {
			this.waiting = waiting;
		}
		
		public function isWaiting():Boolean {
			return this.waiting;
		}
		
		public function toString():String {
			return JVMTools.readJVMString((JVMObject) (jvmThread.getFieldValue(jvmThread.getJVMClass().resolveField("name"))));
		}
	}
}
