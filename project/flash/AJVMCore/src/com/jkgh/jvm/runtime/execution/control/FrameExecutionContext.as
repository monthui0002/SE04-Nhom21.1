package com.jkgh.jvm.runtime.execution.control {
	
	
	import com.jkgh.jvm.runtime.PrimitiveDouble;
	import com.jkgh.jvm.runtime.PrimitiveFloat;
	import com.jkgh.jvm.runtime.PrimitiveLong;
	import com.jkgh.jvm.runtime.execution.JVMMethod;
	import com.jkgh.jvm.runtime.execution.JVMObject;
	import com.jkgh.jvm.runtime.execution.JVMReturnAddress;
	import com.jkgh.jvm.runtime.execution.JVMThread;
	import com.jkgh.jvm.runtime.execution.instructions.Instruction;
	
	public class FrameExecutionContext {
	
		public static const EMPTY:Object = new EmptyStackSpace();
		
		private var objectStack:Vector.<Object>;
		private var thread:JVMThread;
		private var method:JVMMethod;
		private var locals:Vector.<Object>;
		private var currentInstruction:Instruction;
		private var lock:JVMObject;
		
		public function FrameExecutionContext(thread:JVMThread, method:JVMMethod, locals:Vector.<Object>) {
			this.thread = thread;
			this.method = method;
			this.locals = locals;
			this.objectStack = new Vector.<Object>();
		}
	
		public function toString():String {
			var ss:String = "...";
			for (var i:int = 0; i<objectStack.length; ++i) {
				ss += ", "+objectStack[objectStack.length-i-1];
			}
			return "------------------------------\nMethod: "+method+"\nStack: "+ss+"\nLocals: "+locals+"\n------------------------------";
		}
		
		public function getObjectStack():Vector.<Object> {
			return objectStack;
		}
	
		public function popReference():JVMObject {
			return (JVMObject)(objectStack.pop());
		}
	
		public function pushReference(object:JVMObject):void {
			objectStack.push(object);
		}
	
		public function popInt():int {
			return (int)(objectStack.pop());
		}
	
		public function getThread():JVMThread {
			return thread;
		}
	
		public function pushInt(i:int):void {
			objectStack.push(i);
		}
	
		public function clearStack():void {
			objectStack.splice(0, objectStack.length);
		}
	
		public function getMethod():JVMMethod {
			return method;
		}
	
		public function setCurrentInstruction(currentInstruction:Instruction):void {
			this.currentInstruction = currentInstruction;		
		}
	
		public function getCurrentInstruction():Instruction {
			return currentInstruction;
		}
	
		public function popDouble():PrimitiveDouble {
			objectStack.pop();
			return (PrimitiveDouble)(objectStack.pop());
		}
	
		public function pushFloat(f:PrimitiveFloat):void {
			objectStack.push(f);
		}
	
		public function pushLong(l:PrimitiveLong):void {
			objectStack.push(l);
			objectStack.push(l);
		}
	
		public function pushDouble(d:PrimitiveDouble):void {
			objectStack.push(d);
			objectStack.push(d);
		}
	
		public function dup():void {
			objectStack.push(objectStack[objectStack.length-1]);
		}
	
		public function dup_x1():void {
			var toInsert:Object = objectStack.pop();
			var skip:Object = objectStack.pop();
			objectStack.push(toInsert);
			objectStack.push(skip);
			objectStack.push(toInsert);
		}
	
		public function dup_x2():void {
			var toInsert:Object = objectStack.pop();
			var skipA:Object = objectStack.pop();
			var skipB:Object = objectStack.pop();
			objectStack.push(toInsert);
			objectStack.push(skipB);
			objectStack.push(skipA);
			objectStack.push(toInsert);
		}
	
		public function dup2():void {
			var toInsertA:Object = objectStack.pop();
			var toInsertB:Object = objectStack.pop();
			objectStack.push(toInsertB);
			objectStack.push(toInsertA);
			objectStack.push(toInsertB);
			objectStack.push(toInsertA);
		}
	
		public function dup2_x1():void {
			var toInsertA:Object = objectStack.pop();
			var toInsertB:Object = objectStack.pop();
			var toSkipA:Object = objectStack.pop();
			var toSkipB:Object = objectStack.pop();
			objectStack.push(toInsertB);
			objectStack.push(toInsertA);
			objectStack.push(toSkipB);
			objectStack.push(toSkipA);
			objectStack.push(toInsertB);
			objectStack.push(toInsertA);
		}
		
		public function dup2_x2():void {
			var toInsertA:Object = objectStack.pop();
			var toInsertB:Object = objectStack.pop();
			var toSkip1A:Object = objectStack.pop();
			var toSkip1B:Object = objectStack.pop();
			var toSkip2A:Object = objectStack.pop();
			var toSkip2B:Object = objectStack.pop();
			objectStack.push(toInsertB);
			objectStack.push(toInsertA);
			objectStack.push(toSkip2B);
			objectStack.push(toSkip2A);
			objectStack.push(toSkip1B);
			objectStack.push(toSkip1A);
			objectStack.push(toInsertB);
			objectStack.push(toInsertA);
		}
	
		public function popFloat():PrimitiveFloat {
			return (PrimitiveFloat)(objectStack.pop());
		}
	
		public function pushBoolean(b:Boolean):void {
			pushInt(b ? 1 : 0);
		}
	
		public function pushByte(b:int):void {
			pushInt(b);
		}
	
		public function pushChar(c:int):void {
			pushInt(c);
		}
	
		public function pushShort(s:int):void {
			pushInt(s);
		}
	
		public function getLocalInt(varNum:int):int {
			return (int)(locals[varNum]);
		}
		
		public function getLocalDouble(varNum:int):PrimitiveDouble {
			return (PrimitiveDouble)(locals[varNum]);
		}
		
		public function getLocalLong(varNum:int):PrimitiveLong {
			return (PrimitiveLong)(locals[varNum]);
		}
		
		public function getLocalReference(varNum:int):JVMObject {
			return (JVMObject)(locals[varNum]);
		}
		
		public function getLocalFloat(varNum:int):PrimitiveFloat {
			return (PrimitiveFloat)(locals[varNum]);
		}
	
		public function setLocalInt(varNum:int, a:int):void {
			locals[varNum] = a;
		}
		
		public function setLocalLong(varNum:int, a:PrimitiveLong):void {
			locals[varNum] = a;
		}
		
		public function setLocalReference(varNum:int, a:JVMObject):void {
			locals[varNum] = a;
		}
		
		public function setLocalDouble(varNum:int, a:PrimitiveDouble):void {
			locals[varNum] = a;
		}
		
		public function setLocalFloat(varNum:int, a:PrimitiveFloat):void {
			locals[varNum] = a;
		}
	
		public function peekReference(fromTop:int):JVMObject {
			return (JVMObject)(objectStack[objectStack.length-1-fromTop]);
		}
	
		public function pushReturnAddress(address:JVMReturnAddress):void {
			objectStack.push(address);
		}
	
		public function popLong():PrimitiveLong {
			objectStack.pop();
			return (PrimitiveLong)(objectStack.pop());
		}
	
		public function pop():void {
			objectStack.pop();
		}
	
		public function pop2():void {
			objectStack.pop();
			objectStack.pop();
		}
	
		public function popBoolean():int {
			return popInt();
		}
	
		public function popByte():int {
			return popInt();
		}
	
		public function popChar():int {
			return popInt();
		}
	
		public function popShort():int {
			return popInt();
		}
	
		public function getLocalReturnAddress(varNum:int):JVMReturnAddress {
			return (JVMReturnAddress)(locals[varNum]);
		}
	
		public function swap():void {
			var a:Object = objectStack.pop();
			var b:Object = objectStack.pop();
			objectStack.push(a);
			objectStack.push(b);
		}
	
		public function pushLocal(varNum:int):void {
			var local:Object = locals[varNum];
			pushAnything(local);
		}
	
		public function popLocal(varNum:int):void {
			var popped:Object = popAnything();
			locals[varNum] = popped;
		}
	
		public function pushAnything(object:Object):void {
			var needEmpty:Boolean = false;
			if ((object is PrimitiveDouble || object is PrimitiveLong) && (object != null)) {
				needEmpty = true;
			}
			objectStack.push(object);
			if (needEmpty) {
				objectStack.push(EMPTY);
			}
		}
	
		public function popAnything():Object {
			var popped:Object = objectStack.pop();
			if (popped == EMPTY) {
				popped = objectStack.pop();
			}
			return popped;
		}
	
		public function popOne():Object {
			return objectStack.pop();
		}
	
		public function getLock():JVMObject {
			return lock;
		}
		
		public function setLock(lock:JVMObject):void {
			this.lock = lock;
		}
	}
}
