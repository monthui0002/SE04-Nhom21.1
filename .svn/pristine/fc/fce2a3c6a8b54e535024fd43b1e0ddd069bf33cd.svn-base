package com.jkgh.jvm.runtime.execution {
	
	
	import flash.utils.Dictionary;
	import com.jkgh.jvm.parsing.types.AttributeInfo;
	import com.jkgh.jvm.parsing.types.FieldInfo;
	import com.jkgh.jvm.runtime.classloading.JVMClassLoadingContext;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	
	public class JVMField {
			
		private var name:String;
		private var type:JVMType;
		private var flags:JVMFieldFlags;
		private var attributes:Dictionary/*String, JVMFieldAttribute*/;
		private var ownerClass:JVMClass;
		
		public static function fromInfo(ownerClass:JVMClass, classLoadingContext:JVMClassLoadingContext, f:FieldInfo):JVMField {
			return fromValues(ownerClass, f.getName(), classLoadingContext.resolveType(f.getTypeName()), f.getFlags(), JVMFieldFlags.fromInfo(f), prepareAttributes(classLoadingContext, f));
		}
	
		private static function prepareAttributes(classLoadingContext:JVMClassLoadingContext, f:FieldInfo):Dictionary/*String, JVMFieldAttribute*/ {
			var ret:Dictionary = new Dictionary/*String, JVMFieldAttribute*/();
			for each (var a:AttributeInfo in f.getAttributes()) {
				if (a.getName() == "ConstantValue") {
					ret[a.getName()] = new JVMConstantValueFieldAttribute(classLoadingContext, f, a.getValue());
				}
			}
			return ret;
		}
	
		public static function fromValues(ownerClass:JVMClass, name:String, type:JVMType, rawModifiers:int, flags:JVMFieldFlags, attributes:Dictionary/*String, JVMFieldAttribute*/):JVMField {
			var rthis:JVMField = new JVMField();
			rthis.ownerClass = ownerClass;
			rthis.name = name;
			rthis.type = type;
			rthis.flags = flags;
			rthis.attributes = attributes;
			return rthis;
		}
	
		public function toString():String {
			return ownerClass+": "+flags+""+type+" "+name;
		}
		
		public function getName():String {
			return name;
		}
	
		public function getType():JVMType {
			return type;
		}
	
		public function getFlags():JVMFieldFlags {
			return flags;
		}
	
		public function getAttributes():Dictionary/*String, JVMFieldAttribute*/ {
			return attributes;
		}
	
		public function getOwnerClass():JVMClass {
			return ownerClass;
		}
	
		public function getByPush(objectRef:JVMObject, frame:FrameExecutionContext):void {
			type.getByPush(objectRef, this, frame);
		}
	
		public function getStaticByPush(frame:FrameExecutionContext):void {
			type.getByPush(ownerClass, this, frame);
		}
	
	}
}
