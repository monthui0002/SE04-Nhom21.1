package com.jkgh.jvm.runtime {
	
	
	import com.jkgh.jvm.gateways.ClientSocketGateway;
	import com.jkgh.jvm.gateways.LockGateway;
	import com.jkgh.jvm.gateways.SemaphoreGateway;
	import com.jkgh.jvm.runtime.classloading.JVMClassLoadingContext;
	import com.jkgh.jvm.runtime.execution.JVMArrayClass;
	import com.jkgh.jvm.runtime.execution.JVMArrayObject;
	import com.jkgh.jvm.runtime.execution.JVMClass;
	import com.jkgh.jvm.runtime.execution.JVMCode;
	import com.jkgh.jvm.runtime.execution.JVMMethod;
	import com.jkgh.jvm.runtime.execution.JVMMethodIdentity;
	import com.jkgh.jvm.runtime.execution.JVMObject;
	import com.jkgh.jvm.runtime.execution.JVMThread;
	import com.jkgh.jvm.runtime.execution.NativeCode;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	import com.jkgh.jvm.tools.JVMTools;
	import com.jkgh.jvm.tools.Logger;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	
	public class JVMRuntime {
	
		private static const LOG:Logger = Logger.getLogger("AJVMInternal");
		
		private var bootstrapClassLoader:JVMClassLoadingContext;
		private var classPath:Vector.<String>;
		
		private var classCastExceptionClass:JVMClass;
		private var negativeArraySizeExceptionClass:JVMClass;
		private var nullPointerExceptionClass:JVMClass;
		private var stringClass:JVMClass;
		private var objectClass:JVMClass;
		private var arrayIndexOutOfBoundsExceptionClass:JVMClass;
		private var objectArrayClass:JVMArrayClass;
		private var charArrayClass:JVMArrayClass;
		private var systemClass:JVMClass;
		private var fieldClass:JVMClass;
		private var throwableClass:JVMClass;
		private var threadClass:JVMClass;
		private var millisecondsPerFrame:int;
		
		private var nativeCodes:Dictionary/*String, Function*/;
		private var internCache:Dictionary/*String, JVMObject*/;
		private var allThreads:Dictionary/*JVMObject, JVMThread*/;
		private var ownSprite:Sprite;
		
		private var paused:Boolean;
		
		public function JVMRuntime() {
			LOG.info(["Starting AJVM"]);
		
			this.millisecondsPerFrame = 20;
			this.allThreads = new Dictionary();
			this.internCache = new Dictionary();
			this.classPath = new Vector.<String>();
			this.nativeCodes = new Dictionary();
			registerNatives();
			
			this.bootstrapClassLoader = new JVMClassLoadingContext(this);
			this.ownSprite = new Sprite();
			this.paused = false;
		}
		
		private function onFrame(e:Event):void {
			if (!paused) {
				var steps:int = doSteps();
				LOG.info(["Instructions executed during a frame: ", steps]);
			}
		}
		
		public function setPaused(p:Boolean):void {
			this.paused = p;
		}
		
		private function doSteps():int {
			var maxTime:int = getTimer() + getMillisecondsPerFrame();
			var count:int = 0;
			while (true) {
				var anyStep:Boolean = false;
				var anyAlive:Boolean = false;
				for each (var t:JVMThread in allThreads) {
					anyAlive = true;
					if (!t.isWaiting()) {
						anyStep = true;
						var tp:int = (int) (t.getJVMThread().getFieldValue(threadClass.resolveField("priority")));
						for (var i:int = 0; i<tp; ++i) {
							t.step();
							++count;
							if (t.isWaiting()) {
								break;
							}
							if (!t.hasNextStep()) {
								delete allThreads[t.getJVMThread()];
								break;
							}
							if (getTimer() >= maxTime) {
								return count;
							}
						}
					}
				}
				if (!anyStep) {
					break;
				}
			}
			if (!anyAlive) {
				setPaused(true);
			}
			return count;
		}
		
		/**
		 * fullSignature - a String of a form:
		 *                 "java/lang/VMNumber:toString(D)Ljava/lang/String;",
		 *                 that is, a full qualified class name followed by a colon
		 *                 and a method signature. Does not specify a static or
		 *                 a non-static context (because javac does not as well).
		 * 
		 * code - a Function of a signature:
		 *        function(currentFrame:FrameExecutionContext, args:Vector.<Object>, 
		 *                 onResult:Function):void,
		 *        executing a native functionality, using the supplied arguments (of which
		 *        the first is "this" in case of a non-static method), and returning the
		 *        result (even null, in case of a void method, obligatory) by calling
		 *        the onResult function.
		 */
		public function registerNative(fullSignature:String, code:Function):void {
			nativeCodes[fullSignature] = code;
		}
		
		private function registerNatives():void {
			
			var thisReference:JVMRuntime = this;

			registerNative("java/lang/VMSystem:trace(Ljava/lang/String;)V", function(currentFrame:FrameExecutionContext, args:Vector.<Object>, onReturn:Function):void {
				var stringObject:JVMObject = (JVMObject)(args[0]);
				var string:String = JVMTools.readJVMString(stringObject);
				trace(string);
				onReturn(null);
			});
			
			registerNative("java/lang/VMSystem:getCurrentMethodName()Ljava/lang/String;", function(currentFrame:FrameExecutionContext, args:Vector.<Object>, onReturn:Function):void {
				var retString:String = currentFrame.getMethod().getIdentity().getName();
				var ret:JVMObject = JVMTools.createJVMStringObject(stringClass, charArrayClass, retString);
				onReturn(ret);
			});
			
			registerNative("java/lang/VMNumber:toString(D)Ljava/lang/String;", function(currentFrame:FrameExecutionContext, args:Vector.<Object>, onReturn:Function):void {
				var d:Number = ((PrimitiveDouble)(args[0])).getValue();
				onReturn(JVMTools.getJVMStringObject(internCache, stringClass, charArrayClass, new String(d)));
			});
			
			registerNative("java/lang/VMNumber:toString(F)Ljava/lang/String;", function(currentFrame:FrameExecutionContext, args:Vector.<Object>, onReturn:Function):void {
				var d:Number = ((PrimitiveFloat)(args[0])).getValue();
				onReturn(JVMTools.getJVMStringObject(internCache, stringClass, charArrayClass, new String(d)));
			});
			
			registerNative("java/lang/VMThread:currentThread()Ljava/lang/Thread;", function(currentFrame:FrameExecutionContext, args:Vector.<Object>, onReturn:Function):void {
				onReturn(currentFrame.getThread().getJVMThread());
			});
			
			registerNative("java/lang/VMThread:sleep(J)V", function(currentFrame:FrameExecutionContext, args:Vector.<Object>, onReturn:Function):void {
				var delay:PrimitiveLong = (PrimitiveLong)(args[0]);
				var number:Number = delay.toNumber();
				setTimeout(function():void {
					onReturn(null);
				}, number);
			});
			
			registerNative("java/lang/VMNumber:longBitsToDouble(J)D", function(currentFrame:FrameExecutionContext, args:Vector.<Object>, onReturn:Function):void {
				var l:PrimitiveLong = (PrimitiveLong)(args[0]);
				onReturn(NumberHelper.longBitsToDouble(l));
			});
			
			registerNative("java/lang/VMNumber:intBitsToFloat(I)F", function(currentFrame:FrameExecutionContext, args:Vector.<Object>, onReturn:Function):void {
				var i:int = (int)(args[0]);
				onReturn(NumberHelper.intBitsToFloat(i));
			});
			
			registerNative("java/lang/VMNumber:parseFloat(Ljava/lang/String;)F", function(currentFrame:FrameExecutionContext, args:Vector.<Object>, onReturn:Function):void {
				var stringObject:JVMObject = (JVMObject)(args[0]);
				var string:String = JVMTools.readJVMString(stringObject);
				var number:Number = parseFloat(string);
				onReturn(new PrimitiveFloat(number));
			});
			
			registerNative("java/lang/VMNumber:parseDouble(Ljava/lang/String;)D", function(currentFrame:FrameExecutionContext, args:Vector.<Object>, onReturn:Function):void {
				var stringObject:JVMObject = (JVMObject)(args[0]);
				var string:String = JVMTools.readJVMString(stringObject);
				var number:Number = parseFloat(string);
				onReturn(new PrimitiveDouble(number));
			});
			
			registerNative("java/lang/VMNumber:sin(D)D", function(currentFrame:FrameExecutionContext, args:Vector.<Object>, onReturn:Function):void {
				var d:Number = ((PrimitiveDouble)(args[0])).getValue();
				onReturn(new PrimitiveDouble(Math.sin(d)));
			});

			registerNative("java/lang/VMNumber:cos(D)D", function(currentFrame:FrameExecutionContext, args:Vector.<Object>, onReturn:Function):void {
				var d:Number = ((PrimitiveDouble)(args[0])).getValue();
				onReturn(new PrimitiveDouble(Math.cos(d)));
			});
			
			registerNative("java/lang/VMNumber:tan(D)D", function(currentFrame:FrameExecutionContext, args:Vector.<Object>, onReturn:Function):void {
				var d:Number = ((PrimitiveDouble)(args[0])).getValue();
				onReturn(new PrimitiveDouble(Math.tan(d)));
			});
			
			registerNative("java/lang/VMNumber:asin(D)D", function(currentFrame:FrameExecutionContext, args:Vector.<Object>, onReturn:Function):void {
				var d:Number = ((PrimitiveDouble)(args[0])).getValue();
				onReturn(new PrimitiveDouble(Math.asin(d)));
			});
			
			registerNative("java/lang/VMNumber:acos(D)D", function(currentFrame:FrameExecutionContext, args:Vector.<Object>, onReturn:Function):void {
				var d:Number = ((PrimitiveDouble)(args[0])).getValue();
				onReturn(new PrimitiveDouble(Math.acos(d)));
			});
			
			registerNative("java/lang/VMNumber:atan(D)D", function(currentFrame:FrameExecutionContext, args:Vector.<Object>, onReturn:Function):void {
				var d:Number = ((PrimitiveDouble)(args[0])).getValue();
				onReturn(new PrimitiveDouble(Math.atan(d)));
			});
			
			registerNative("java/lang/VMNumber:atan2(DD)D", function(currentFrame:FrameExecutionContext, args:Vector.<Object>, onReturn:Function):void {
				var d:Number = ((PrimitiveDouble)(args[0])).getValue();
				var t:Number = ((PrimitiveDouble)(args[1])).getValue();
				onReturn(new PrimitiveDouble(Math.atan2(d, t)));
			});
			
			registerNative("java/lang/VMNumber:exp(D)D", function(currentFrame:FrameExecutionContext, args:Vector.<Object>, onReturn:Function):void {
				var d:Number = ((PrimitiveDouble)(args[0])).getValue();
				onReturn(new PrimitiveDouble(Math.exp(d)));
			});
			
			registerNative("java/lang/VMNumber:log(D)D", function(currentFrame:FrameExecutionContext, args:Vector.<Object>, onReturn:Function):void {
				var d:Number = ((PrimitiveDouble)(args[0])).getValue();
				onReturn(new PrimitiveDouble(Math.log(d)));
			});
			
			registerNative("java/lang/VMNumber:sqrt(D)D", function(currentFrame:FrameExecutionContext, args:Vector.<Object>, onReturn:Function):void {
				var d:Number = ((PrimitiveDouble)(args[0])).getValue();
				onReturn(new PrimitiveDouble(Math.sqrt(d)));
			});
			
			registerNative("java/lang/VMNumber:pow(DD)D", function(currentFrame:FrameExecutionContext, args:Vector.<Object>, onReturn:Function):void {
				var d:Number = ((PrimitiveDouble)(args[0])).getValue();
				var t:Number = ((PrimitiveDouble)(args[1])).getValue();
				onReturn(new PrimitiveDouble(Math.pow(d, t)));
			});
			
			registerNative("java/lang/VMNumber:ceil(D)D", function(currentFrame:FrameExecutionContext, args:Vector.<Object>, onReturn:Function):void {
				var d:Number = ((PrimitiveDouble)(args[0])).getValue();
				onReturn(new PrimitiveDouble(Math.ceil(d)));
			});
			
			registerNative("java/lang/VMNumber:floor(D)D", function(currentFrame:FrameExecutionContext, args:Vector.<Object>, onReturn:Function):void {
				var d:Number = ((PrimitiveDouble)(args[0])).getValue();
				onReturn(new PrimitiveDouble(Math.floor(d)));
			});
			
			registerNative("java/lang/VMNumber:rint(D)D", function(currentFrame:FrameExecutionContext, args:Vector.<Object>, onReturn:Function):void {
				var d:Number = ((PrimitiveDouble)(args[0])).getValue();
				onReturn(new PrimitiveDouble(Math.round(d)));
			});
			
			registerNative("java/lang/VMNumber:sinh(D)D", function(currentFrame:FrameExecutionContext, args:Vector.<Object>, onReturn:Function):void {
				var d:Number = ((PrimitiveDouble)(args[0])).getValue();
				onReturn(new PrimitiveDouble((Math.exp(d)-Math.exp(-d))/2.0));
			});
			
			registerNative("java/lang/VMNumber:cosh(D)D", function(currentFrame:FrameExecutionContext, args:Vector.<Object>, onReturn:Function):void {
				var d:Number = ((PrimitiveDouble)(args[0])).getValue();
				onReturn(new PrimitiveDouble((Math.exp(d)+Math.exp(-d))/2.0));
			});
			
			registerNative("java/lang/VMNumber:tanh(D)D", function(currentFrame:FrameExecutionContext, args:Vector.<Object>, onReturn:Function):void {
				var d:Number = ((PrimitiveDouble)(args[0])).getValue();
				onReturn(new PrimitiveDouble((Math.exp(d)-Math.exp(-d))/(Math.exp(d)+Math.exp(-d))));
			});
			
			registerNative("java/lang/VMNumber:cbrt(D)D", function(currentFrame:FrameExecutionContext, args:Vector.<Object>, onReturn:Function):void {
				var d:Number = ((PrimitiveDouble)(args[0])).getValue();
				onReturn(new PrimitiveDouble(Math.pow(d, 1.0/3.0)));
			});
			
			registerNative("java/lang/VMSystem:arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V", function(currentFrame:FrameExecutionContext, args:Vector.<Object>, onReturn:Function):void {
				var src:JVMArrayObject = (JVMArrayObject)(args[0]);
				var srcPos:int = (int)(args[1]);
				var dst:JVMArrayObject = (JVMArrayObject)(args[2]);
				var dstPos:int = (int)(args[3]);
				var len:int = (int)(args[4]);
				
				for (var i:int = 0; i < len; ++i) {
					dst.setElement(dstPos+i, src.getElement(srcPos+i));
				}
				
				onReturn(null);
			});
	
			registerNative("java/lang/VMNumber:floatToRawIntBits(F)I", function(currentFrame:FrameExecutionContext, args:Vector.<Object>, onReturn:Function):void {
				var f:PrimitiveFloat = (PrimitiveFloat)(args[0]);
				var ret:int = NumberHelper.floatToRawIntBits(f);
				onReturn(ret);
			});
			
			registerNative("java/lang/VMNumber:doubleToRawLongBits(D)J", function(currentFrame:FrameExecutionContext, args:Vector.<Object>, onReturn:Function):void {
				var d:PrimitiveDouble = (PrimitiveDouble)(args[0]);
				var ret:PrimitiveLong = NumberHelper.doubleToRawLongBits(d);
				onReturn(ret);
			});
			
			registerNative("java/lang/VMSystem:identityHashCode(Ljava/lang/Object;)I", function(currentFrame:FrameExecutionContext, args:Vector.<Object>, onReturn:Function):void {
				var self:JVMObject = (JVMObject)(args[0]);
				onReturn(self.hashCode());
			});
			
			registerNative("java/lang/VMString:intern()Ljava/lang/String;", function(currentFrame:FrameExecutionContext, args:Vector.<Object>, onReturn:Function):void {
				var jvmString:JVMObject = (JVMObject)(args[0]);
				var internedString:JVMObject = JVMTools.getJVMStringObject(internCache, stringClass, charArrayClass, JVMTools.readJVMString(jvmString));
				onReturn(internedString);
			});
			
			registerNative("java/lang/VMSystem:classNameOf(Ljava/lang/Object;)Ljava/lang/String;", function(currentFrame:FrameExecutionContext, args:Vector.<Object>, onReturn:Function):void {
				var objectRef:JVMObject = (JVMObject)(args[0]);
				var jvmClass:JVMClass = objectRef.getJVMClass();
				onReturn(JVMTools.createJVMStringObject(stringClass, charArrayClass, jvmClass.getJavaName()));
			});
			
			registerNative("java/lang/VMThread:start(Ljava/lang/Thread;)V", function(currentFrame:FrameExecutionContext, args:Vector.<Object>, onReturn:Function):void {
				var jvmThread:JVMObject = (JVMObject)(args[0]);
				var runMethod:JVMMethod = jvmThread.getJVMClass().resolveVirtualMethod(JVMThread.RUN_IDENTITY);
				var thread:JVMThread = JVMThread.fromRunMethod(thisReference, runMethod, jvmThread);
				allThreads[jvmThread] = thread;
				onReturn(null);
			});
			
			registerNative("java/lang/VMSystem:currentTimeMillis()J", function(currentFrame:FrameExecutionContext, args:Vector.<Object>, onReturn:Function):void {
				onReturn(new PrimitiveLong(getTimer()));
			});
			
			registerNative("java/lang/VMSystem:clone(Ljava/lang/Cloneable;)Ljava/lang/Object;", function(currentFrame:FrameExecutionContext, args:Vector.<Object>, onReturn:Function):void {
				var object:JVMObject = (JVMObject)(args[0]);
				var ret:JVMObject = object.clone();
				onReturn(ret);
			});
			
			registerNative("java/net/VMSocket:connect(Ljava/lang/String;I)I", function(currentFrame:FrameExecutionContext, args:Vector.<Object>, onReturn:Function):void {
				var hostObject:JVMObject = (JVMObject)(args[0]);
				
				var host:String = JVMTools.readJVMString(hostObject);
				var port:int = (int)(args[1]);
				
				ClientSocketGateway.connect(host, port, onReturn);
			});
			
			registerNative("java/net/VMSocket:read(I)I", function(currentFrame:FrameExecutionContext, args:Vector.<Object>, onReturn:Function):void {
				var handle:int = (int)(args[0]);
				ClientSocketGateway.read(handle, onReturn);
			});
			
			registerNative("java/lang/VMSemaphore:open(I)V", function(currentFrame:FrameExecutionContext, args:Vector.<Object>, onReturn:Function):void {
				var semaphoreID:int = (int)(args[0]);
				SemaphoreGateway.open(semaphoreID);
				onReturn(null);
			});
			
			registerNative("java/lang/VMSemaphore:pass(I)V", function(currentFrame:FrameExecutionContext, args:Vector.<Object>, onReturn:Function):void {
				var semaphoreID:int = (int)(args[0]);
				SemaphoreGateway.pass(semaphoreID, onReturn);
			});
			
			registerNative("java/lang/VMSemaphore:close(I)V", function(currentFrame:FrameExecutionContext, args:Vector.<Object>, onReturn:Function):void {
				var semaphoreID:int = (int)(args[0]);
				SemaphoreGateway.close(semaphoreID);
				onReturn(null);
			});
		
			registerNative("java/lang/VMLock:lock(I)V", function(currentFrame:FrameExecutionContext, args:Vector.<Object>, onReturn:Function):void {
				var lockID:int = (int)(args[0]);
				LockGateway.lock(lockID, currentFrame.getThread(), onReturn);
			});
			
			registerNative("java/lang/VMLock:unlock(I)I", function(currentFrame:FrameExecutionContext, args:Vector.<Object>, onReturn:Function):void {
				var lockID:int = (int)(args[0]);
				onReturn(LockGateway.unlock(lockID, currentFrame.getThread()));
			});
			
			registerNative("java/net/VMSocket:fillAvailable(I[BII)I", function(currentFrame:FrameExecutionContext, args:Vector.<Object>, onReturn:Function):void {
				var handle:int = (int)(args[0]);
				var b:JVMArrayObject = (JVMArrayObject)(args[1]);
				var off:int = (int)(args[2]);
				var len:int = (int)(args[3]);
				ClientSocketGateway.fillAvailable(handle, b, off, len, onReturn);
			});
			
			registerNative("java/net/VMSocket:write(II)I", function(currentFrame:FrameExecutionContext, args:Vector.<Object>, onReturn:Function):void {
				var handle:int = (int)(args[0]);
				var data:int = (int)(args[1]);
				ClientSocketGateway.write(handle, data, onReturn);
			});
			
			registerNative("java/net/VMSocket:flush(I)I", function(currentFrame:FrameExecutionContext, args:Vector.<Object>, onReturn:Function):void {
				var handle:int = (int)(args[0]);
				ClientSocketGateway.flush(handle, onReturn);
			});
			
			registerNative("java/net/VMSocket:close(I)V", function(currentFrame:FrameExecutionContext, args:Vector.<Object>, onReturn:Function):void {
				var handle:int = (int)(args[0]);
				ClientSocketGateway.close(handle);
				onReturn(null);
			});
		}
	
		public function getFieldClass():JVMClass {
			return fieldClass;
		}
	
		protected function getSystemClass():JVMClass {
			return systemClass;
		}
	
		public function addToClasspath(path:String):void {
			classPath.push(path);
		}
	
		public function getClasspath():Vector.<String> {
			return classPath;
		}
	
		public function executeMain(className:String, args:Vector.<String>):void {
			
			var thisReference:JVMRuntime = this;
			var mainClassQualifiedName:String = JVMTools.dotsToSlashes(className);
			bootstrapClassLoader.locateClassesUsedBy(mainClassQualifiedName, function():void {
			
				locateInternalClasses(function():void {
				
					initializeInternalClasses();
					
					var mainClass:JVMClass = bootstrapClassLoader.getJVMClass(mainClassQualifiedName);
					var mainMethod:JVMMethod = JVMTools.findMainMethod(bootstrapClassLoader, mainClass);
					
					var argsRef:JVMArrayObject = new JVMArrayObject(bootstrapClassLoader.getJVMArrayClass("Ljava/lang/String;"), args.length);
					for (var i:int = 0; i < args.length; ++i) {
						argsRef.setElement(i, JVMTools.getJVMStringObject(internCache, stringClass, bootstrapClassLoader.getJVMArrayClass("C"), args[i]));
					}
					
					var jvmThread:JVMObject = threadClass.instantiate();
					jvmThread.setFieldValue(threadClass.resolveField("priority"), 5);
					jvmThread.setFieldValue(threadClass.resolveField("name"), JVMTools.createJVMStringObject(stringClass, charArrayClass, "Main"));
					var mainThread:JVMThread = JVMThread.fromMainMethod(thisReference, mainMethod, argsRef, jvmThread);
					
					allThreads[jvmThread] = mainThread;		
					
					ownSprite.addEventListener(Event.ENTER_FRAME, onFrame);
				});
				
			});
		}
		
		public function getMillisecondsPerFrame():int {
			return millisecondsPerFrame;
		}
		
		public function setMillisecondsPerFrame(milliseconds:int):void {
			this.millisecondsPerFrame = milliseconds;
		}
		
		private function locateInternalClasses(after:Function):void {
			var i:int = 0;
			var subAfter:Function = function():void {
				--i;
				if (i == 0) {
					after()
				}
			}
			var generateAfter:Function = function():Function {
				++i;
				return subAfter;
			}
			bootstrapClassLoader.locateClassesUsedBy("java/lang/ClassCastException", generateAfter());
			bootstrapClassLoader.locateClassesUsedBy("java/lang/NegativeArraySizeException", generateAfter());
			bootstrapClassLoader.locateClassesUsedBy("java/lang/NullPointerException", generateAfter());
			bootstrapClassLoader.locateClassesUsedBy("java/lang/String", generateAfter());
			bootstrapClassLoader.locateClassesUsedBy("java/lang/Object", generateAfter());
			bootstrapClassLoader.locateClassesUsedBy("java/lang/ArrayIndexOutOfBoundsException", generateAfter());
			bootstrapClassLoader.locateClassesUsedBy("java/lang/Throwable", generateAfter());
			bootstrapClassLoader.locateClassesUsedBy("java/lang/Thread", generateAfter());
		}
		
		private function initializeInternalClasses():void {
			this.classCastExceptionClass = bootstrapClassLoader.getJVMClass("java/lang/ClassCastException");
			this.negativeArraySizeExceptionClass = bootstrapClassLoader.getJVMClass("java/lang/NegativeArraySizeException");
			this.nullPointerExceptionClass = bootstrapClassLoader.getJVMClass("java/lang/NullPointerException");
			this.stringClass = bootstrapClassLoader.getJVMClass("java/lang/String");
			this.objectClass = bootstrapClassLoader.getJVMClass("java/lang/Object");
			this.arrayIndexOutOfBoundsExceptionClass = bootstrapClassLoader.getJVMClass("java/lang/ArrayIndexOutOfBoundsException");
			this.objectArrayClass = bootstrapClassLoader.getJVMArrayClass("Ljava/lang/Object;");
			this.charArrayClass = bootstrapClassLoader.getJVMArrayClass("C");
			this.throwableClass = bootstrapClassLoader.getJVMClass("java/lang/Throwable");
			this.threadClass = bootstrapClassLoader.getJVMClass("java/lang/Thread");
		}
	
		public function getClassLoadingContext():JVMClassLoadingContext {
			return bootstrapClassLoader;
		}
	
		public function getThrowableClass():JVMClass {
			return throwableClass;
		}
	
		public function getNegativeArraySizeExceptionClass():JVMClass {
			return negativeArraySizeExceptionClass;
		}
	
		public function getNullPointerExceptionClass():JVMClass {
			return nullPointerExceptionClass;
		}
	
		public function getStringClass():JVMClass {
			return stringClass;
		}
	
		public function getObjectClass():JVMClass {
			return objectClass;
		}
	
		public function getNativeCodeFor(ownerClass:JVMClass, identity:JVMMethodIdentity):JVMCode {
			var id:String = ownerClass.getFullyQualifiedName()+":"+identity.getDescriptor();
			var nativeCode:Function = nativeCodes[id];
			if (nativeCode == null) {
				throw new Error("No native code found for id: "+id+".");
			}
			return new NativeCode(nativeCode);
		}
	
		public function getArrayIndexOutOfBoundsExceptionClass():JVMClass {
			return arrayIndexOutOfBoundsExceptionClass;
		}
		
		public function getObjectArrayClass():JVMArrayClass {
			return objectArrayClass;
		}
	
		public function getCharArrayClass():JVMArrayClass {
			return charArrayClass;
		}
	
		public function getInternCache():Dictionary {
			return internCache;
		}
	
		public function getClassCastExceptionClass():JVMClass {
			return classCastExceptionClass;
		}
	
		public function isPaused():Boolean {
			return paused;
		}
	}
}
