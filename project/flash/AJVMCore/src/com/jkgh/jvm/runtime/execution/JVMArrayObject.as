package com.jkgh.jvm.runtime.execution {
	
	public class JVMArrayObject extends JVMObject {
	
		private var elements:Vector.<Object>;
	
		public function JVMArrayObject(arrayClass:JVMArrayClass, count:int) {
			super(arrayClass);
			this.elements = new Vector.<Object>(count);
		}
	
		public function getElement(i:int):Object {
			return elements[i];
		}
		
		public function setElement(i:int, e:Object):void {
			elements[i] = e;
		}
		
		public function getCount():int {
			return elements.length;
		}
	
		override public function toString():String {
			return super.toString()+"(length: "+elements.length+")";
		}
	}
}
