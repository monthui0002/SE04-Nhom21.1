package com.jkgh.jvm.runtime.execution {
	
	import com.jkgh.jvm.runtime.classloading.JVMClassLoadingContext;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	
	public interface JVMType {
	
		function getWordSize():int;
		function getByPush(from:FieldHolder, jvmField:JVMField, frame:FrameExecutionContext):void;
		function getDefaultValue():Object;
		function getDescriptor():String;
		function performPop(frame:FrameExecutionContext):Object;
		function performPush(frame:FrameExecutionContext, value:Object):void;
		function getClassLoadingContext():JVMClassLoadingContext;
		function getJavaName():String;
	
	}
}
