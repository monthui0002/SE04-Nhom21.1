package com.jkgh.jvm.tools {
	
	import com.jkgh.jvm.parsing.types.ConstantPool;
	import com.jkgh.jvm.parsing.types.FieldConstantEntry;
	import com.jkgh.jvm.parsing.types.NameAndTypeConstantEntry;
	import com.jkgh.jvm.parsing.types.ReferenceConstantEntry;
	import com.jkgh.jvm.parsing.types.UTF8ConstantEntry;
	import com.jkgh.jvm.runtime.classloading.JVMClassLoadingContext;
	import com.jkgh.jvm.runtime.execution.JVMAccess;
	import com.jkgh.jvm.runtime.execution.JVMArrayClass;
	import com.jkgh.jvm.runtime.execution.JVMArrayObject;
	import com.jkgh.jvm.runtime.execution.JVMClass;
	import com.jkgh.jvm.runtime.execution.JVMField;
	import com.jkgh.jvm.runtime.execution.JVMMethod;
	import com.jkgh.jvm.runtime.execution.JVMMethodIdentity;
	import com.jkgh.jvm.runtime.execution.JVMObject;
	import com.jkgh.jvm.runtime.execution.JVMPrimitive;
	import com.jkgh.jvm.runtime.execution.JVMPrimitiveBoolean;
	import com.jkgh.jvm.runtime.execution.JVMPrimitiveByte;
	import com.jkgh.jvm.runtime.execution.JVMPrimitiveChar;
	import com.jkgh.jvm.runtime.execution.JVMPrimitiveDouble;
	import com.jkgh.jvm.runtime.execution.JVMPrimitiveFloat;
	import com.jkgh.jvm.runtime.execution.JVMPrimitiveInteger;
	import com.jkgh.jvm.runtime.execution.JVMPrimitiveLong;
	import com.jkgh.jvm.runtime.execution.JVMPrimitiveShort;
	import com.jkgh.jvm.runtime.execution.JVMPrimitiveVoid;
	import com.jkgh.jvm.runtime.execution.JVMSpecialInvocator;
	import com.jkgh.jvm.runtime.execution.JVMType;
	import com.jkgh.jvm.runtime.execution.JVMVirtualInvocator;
	
	import flash.utils.ByteArray;
	
	public class JVMTools {
		
		private static var PRIMITIVE_TYPES:Object/*JVMPrimitive*/;
		private static var PRIMITIVE_TYPES_BY_CODE:Vector.<JVMPrimitive> = Vector.<JVMPrimitive>([null, null, null, null, JVMPrimitiveBoolean.INSTANCE, JVMPrimitiveChar.INSTANCE, JVMPrimitiveFloat.INSTANCE, JVMPrimitiveDouble.INSTANCE, JVMPrimitiveByte.INSTANCE, JVMPrimitiveShort.INSTANCE, JVMPrimitiveInteger.INSTANCE, JVMPrimitiveLong.INSTANCE]);
		private static var PRIMITIVE_TYPES_BY_NAME:Object/*JVMPrimitive*/;
		
		public static const NULL_POINTER_EXCEPTION_CONSTRUCTOR_IDENTITY:JVMMethodIdentity = JVMMethodIdentity.fromValues("<init>", JVMPrimitiveVoid.INSTANCE, Vector.<JVMType>([]));
			
		{
			PRIMITIVE_TYPES = new Object();
				
			PRIMITIVE_TYPES['I'] = JVMPrimitiveInteger.INSTANCE;
			PRIMITIVE_TYPES['Z'] = JVMPrimitiveBoolean.INSTANCE;
			PRIMITIVE_TYPES['V'] = JVMPrimitiveVoid.INSTANCE;
			PRIMITIVE_TYPES['B'] = JVMPrimitiveByte.INSTANCE;
			PRIMITIVE_TYPES['C'] = JVMPrimitiveChar.INSTANCE;
			PRIMITIVE_TYPES['J'] = JVMPrimitiveLong.INSTANCE;
			PRIMITIVE_TYPES['S'] = JVMPrimitiveShort.INSTANCE;
			PRIMITIVE_TYPES['D'] = JVMPrimitiveDouble.INSTANCE;
			PRIMITIVE_TYPES['F'] = JVMPrimitiveFloat.INSTANCE;
				
			PRIMITIVE_TYPES_BY_NAME = new Object();
				
			PRIMITIVE_TYPES_BY_NAME["int"] = JVMPrimitiveInteger.INSTANCE;
			PRIMITIVE_TYPES_BY_NAME["Boolean"] = JVMPrimitiveBoolean.INSTANCE;
			PRIMITIVE_TYPES_BY_NAME["void"] = JVMPrimitiveVoid.INSTANCE;
			PRIMITIVE_TYPES_BY_NAME["byte"] = JVMPrimitiveByte.INSTANCE;
			PRIMITIVE_TYPES_BY_NAME["char"] = JVMPrimitiveChar.INSTANCE;
			PRIMITIVE_TYPES_BY_NAME["long"] = JVMPrimitiveLong.INSTANCE;
			PRIMITIVE_TYPES_BY_NAME["short"] = JVMPrimitiveShort.INSTANCE;
			PRIMITIVE_TYPES_BY_NAME["double"] = JVMPrimitiveDouble.INSTANCE;
			PRIMITIVE_TYPES_BY_NAME["float"] = JVMPrimitiveFloat.INSTANCE;
		}
			
		public static function dotsToSlashes(className:String):String {
			return className.split('.').join('/');
		}
		
		public static function readSignedShort(data:ByteArray, offset:int):int {
			var oldPosition:uint = data.position;
			data.position = offset;
			var ret:int = data.readShort();
			data.position = oldPosition;
			return ret;
		}
		
		public static function readUnsignedByte(data:ByteArray, offset:int):int {
			var oldPosition:uint = data.position;
			data.position = offset;
			var ret:int = data.readUnsignedByte();
			data.position = oldPosition;
			return ret;
		}
		
		public static function readSignedByte(data:ByteArray, offset:int):int {
			var oldPosition:uint = data.position;
			data.position = offset;
			var ret:int = data.readByte();
			data.position = oldPosition;
			return ret;
		}
		
		public static function readUnsignedShort(data:ByteArray, offset:int):int {
			var oldPosition:uint = data.position;
			data.position = offset;
			var ret:int = data.readUnsignedShort();
			data.position = oldPosition;
			return ret;
		}
		
		public static function readSignedInt(data:ByteArray, offset:int):int {
			var oldPosition:uint = data.position;
			data.position = offset;
			var ret:int = data.readInt();
			data.position = oldPosition;
			return ret;
		}
		
		public static function getPrimitiveTypeByDescriptor(typeDenoter:String):JVMType {
			return PRIMITIVE_TYPES[typeDenoter];
		}
		
		public static function getPrimitiveTypeByName(name:String):JVMType {
			return PRIMITIVE_TYPES_BY_NAME[name];
		}
		
		public static function findMainMethod(classLoadingContext:JVMClassLoadingContext, cls:JVMClass):JVMMethod {
			var mmi:JVMMethodIdentity = JVMMethodIdentity.fromValues("main", JVMPrimitiveVoid.INSTANCE, Vector.<JVMType>([classLoadingContext.resolveType("[Ljava/lang/String;")]));
			for each (var m:JVMMethod in cls.getMethods()) {
				if (m.getIdentity().equals(mmi) && m.getFlags().isStatic() && m.getFlags().getAccess() == JVMAccess.PUBLIC) {
					return m;
				}
			}
			throw new Error("Cannot find public static void main(String[]) method in main class.");
		}
		
		public static function getPrimitiveTypeByCode(b:int):JVMPrimitive {
			return PRIMITIVE_TYPES_BY_CODE[b];
		}
		
		public static function getFieldByIndex(classLoadingContext:JVMClassLoadingContext, constantPool:ConstantPool, index:int):JVMField {
			var fieldEntry:FieldConstantEntry = (FieldConstantEntry)(constantPool.getConstantAt(index));
			var fieldsClass:JVMClass = JVMTools.getClassByIndex(classLoadingContext, constantPool, fieldEntry.getClassIndex());
			var fieldNameAndTypeEntry:NameAndTypeConstantEntry = (NameAndTypeConstantEntry)(constantPool.getConstantAt(fieldEntry.getNameAndTypeIndex()));
			var fieldNameEntry:UTF8ConstantEntry = (UTF8ConstantEntry)(constantPool.getConstantAt(fieldNameAndTypeEntry.getNameIndex()));
			return fieldsClass.resolveField(fieldNameEntry.getValue());
		}
		
		public static function getClassByIndex(classLoadingContext:JVMClassLoadingContext, constantPool:ConstantPool, index:int):JVMClass {
			return classLoadingContext.getJVMClass(((UTF8ConstantEntry)(constantPool.getConstantAt(index))).getValue());
		}
		
		public static function getClassNameByIndex(constantPool:ConstantPool, index:int):String {
			var rcc:UTF8ConstantEntry = (UTF8ConstantEntry)(constantPool.getConstantAt(index));
			return rcc.getValue();
		}
		
		public static function getInvokatorByIndex(classLoadingContext:JVMClassLoadingContext, constantPool:ConstantPool, index:int):JVMVirtualInvocator {
			var methodEntry:ReferenceConstantEntry = (ReferenceConstantEntry)(constantPool.getConstantAt(index));
			var nate:NameAndTypeConstantEntry = (NameAndTypeConstantEntry)(constantPool.getConstantAt(methodEntry.getNameAndTypeIndex()));
			var methodName:String = ((UTF8ConstantEntry)(constantPool.getConstantAt(nate.getNameIndex()))).getValue();
			var methodDescriptor:String = ((UTF8ConstantEntry)(constantPool.getConstantAt(nate.getDescriptorIndex()))).getValue();
			return classLoadingContext.getJVMVirtualInvokator(methodName, methodDescriptor);
		}
		
		public static function getSpecialInvokatorByIndex(classLoadingContext:JVMClassLoadingContext, constantPool:ConstantPool, index:int):JVMSpecialInvocator {
			var methodEntry:ReferenceConstantEntry = (ReferenceConstantEntry)(constantPool.getConstantAt(index));
			var ownerClass:JVMClass = getClassByIndex(classLoadingContext, constantPool, methodEntry.getClassIndex());
			var nate:NameAndTypeConstantEntry = (NameAndTypeConstantEntry)(constantPool.getConstantAt(methodEntry.getNameAndTypeIndex()));
			var methodName:String = ((UTF8ConstantEntry)(constantPool.getConstantAt(nate.getNameIndex()))).getValue();
			var methodDescriptor:String = ((UTF8ConstantEntry)(constantPool.getConstantAt(nate.getDescriptorIndex()))).getValue();
			return classLoadingContext.getJVMSpecialInvokator(methodName, methodDescriptor, ownerClass);
		}
		
		public static function getJVMStringObject(internCache:Object/*JVMObject*/, stringClass:JVMClass, charArrayClass:JVMArrayClass, value:String):JVMObject {
			var interned:JVMObject = internCache[value];
			if (interned == null) {
				interned = createJVMStringObject(stringClass, charArrayClass, value);
				internCache[value] = interned;
			}
			return interned;
		}
		
		public static function createJVMStringObject(stringClass:JVMClass, charArrayClass:JVMArrayClass, value:String):JVMObject {
			var inner:JVMArrayObject = new JVMArrayObject(charArrayClass, value.length);
			for (var i:int = 0; i<value.length; ++i) {
				inner.setElement(i, (int) (value.charCodeAt(i)));
			}
			var ret:JVMObject = stringClass.instantiate();
			for each (var sf:JVMField in stringClass.getFields()) {
				if (sf.getName() == "value") {
					ret.setFieldValue(sf, inner);
				} else if (sf.getName() == "count") {
					ret.setFieldValue(sf, value.length);
				}
			}
			return ret;
		}
		
		public static function readJVMString(jvmString:JVMObject):String {
			if (jvmString == null) {
				return null;
			}
			
			var stringClass:JVMClass = jvmString.getJVMClass();
			var jvmValue:JVMArrayObject = null;
			var offset:int = 0;
			var count:int = 0;
			for each (var sf:JVMField in stringClass.getFields()) {
				if (sf.getName() == "value") {
					jvmValue = (JVMArrayObject)(jvmString.getFieldValue(sf));
				} else if (sf.getName() == "count") {
					count = (int)(jvmString.getFieldValue(sf));
				} else if (sf.getName() == "offset") {
					offset = (int)(jvmString.getFieldValue(sf));
				}
			}
			if (jvmValue == null) {
				return "[uninitialized]";
			} else {
				var ret:String = "";
				for (var i:int = offset; i<offset+count; ++i) {
					ret += String.fromCharCode((int)(jvmValue.getElement(i)));
				}
				return ret;
			}
		}
		
		public static function slashesToDots(fullyQualifiedName:String):String {
			return fullyQualifiedName.split('/').join('.');
		}
		
		public static function endsWith(s:String, e:String):Boolean {
			return s.substring(s.length-e.length) == e;
		}
	}
}
