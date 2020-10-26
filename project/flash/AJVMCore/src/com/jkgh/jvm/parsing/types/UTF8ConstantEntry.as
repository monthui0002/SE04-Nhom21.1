package com.jkgh.jvm.parsing.types {
	
	
	import flash.utils.ByteArray;
	import com.jkgh.jvm.parsing.parsers.ConstantEntryParser;
	import com.jkgh.jvm.runtime.classloading.JVMClassLoadingContext;
	import com.jkgh.jvm.runtime.execution.JVMArrayClass;
	import com.jkgh.jvm.runtime.execution.JVMObject;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	import com.jkgh.jvm.tools.JVMTools;
	
	public class UTF8ConstantEntry extends ConstantEntry {
	
		private var value:String;
		private var cachedRef:JVMObject;
	
		public function UTF8ConstantEntry(dataInputStream:ByteArray) {
			this.value = dataInputStream.readUTF();
		}
	
		override public function getTag():int {
			return ConstantEntryParser.CONSTANT_UTF8;
		}
	
		public function getValue():String {
			return value;
		}
	
		override public function getByPush(frame:FrameExecutionContext):void {
			frame.pushReference(cachedRef);
		}
	
		override public function getJVMValue():Object {
			return cachedRef;
		}
	
		public function initialize(classLoadingContext:JVMClassLoadingContext):void {
			if (cachedRef == null) {
				cachedRef = JVMTools.getJVMStringObject(classLoadingContext.getRuntime().getInternCache(), classLoadingContext.getRuntime().getStringClass(), (JVMArrayClass)(classLoadingContext.resolveType("[C")), value);
			}
		}
	
	}
}
