package com.jkgh.jvm.runtime.execution {
	
	
	import com.jkgh.jvm.parsing.types.ConstantEntry;
	import com.jkgh.jvm.parsing.types.EnclosingMethodAttributeInfo;
	import com.jkgh.jvm.parsing.types.FieldInfo;
	import com.jkgh.jvm.parsing.types.MethodInfo;
	import com.jkgh.jvm.parsing.types.ParsedJavaClass;
	import com.jkgh.jvm.parsing.types.UTF8ConstantEntry;
	import com.jkgh.jvm.runtime.classloading.JVMClassLoadingContext;
	import com.jkgh.jvm.runtime.execution.control.FrameExecutionContext;
	import com.jkgh.jvm.tools.JVMTools;
	
	import flash.utils.Dictionary;
	
	public class JVMClass extends FieldHolder implements JVMType {
	
		private var fullyQualifiedName:String;
		private var classLoadingContext:JVMClassLoadingContext;
		private var methodCache:Dictionary/*JVMMethodIdentity, JVMMethod*/;
		private var classLock:JVMObject;
		
		private var parsedInfo:ParsedJavaClass;
		
		private var superClass:JVMClass;
		private var interfaces:Vector.<JVMClass>;
		private var flags:JVMClassFlags;
		private var fields:Vector.<JVMField>;
		private var methods:Vector.<JVMMethod>;
		private var enclosingClass:JVMClass;
		private var enclosingMethod:JVMMethod;
	
		private var initialized:Boolean;
		
		public function JVMClass(classLoadingContext:JVMClassLoadingContext, parsed:ParsedJavaClass, fullyQualifiedName:String = null, superClass:JVMClass = null, interfaces:Vector.<JVMClass> = null, flags:JVMClassFlags = null, fields:Vector.<JVMField> = null, methods:Vector.<JVMMethod> = null) {
			if (parsed == null) {
				this.classLoadingContext = classLoadingContext;
				this.fullyQualifiedName = fullyQualifiedName;
				this.superClass = superClass;
				this.interfaces = interfaces;
				this.flags = flags;
				this.fields = fields;
				this.methods = methods;
				this.parsedInfo = null;
				this.methodCache = new Dictionary();
				this.initialized = false;
				this.classLock = new JVMPseudoObject();
			} else {
				this.fullyQualifiedName = parsed.getClassInfo().getClassName();
				this.classLoadingContext = classLoadingContext;
				this.parsedInfo = parsed;
				this.methodCache = new Dictionary();
				this.initialized = false;
				this.classLock = new JVMPseudoObject();
			}
		}
		
		public function toString():String {
			return fullyQualifiedName;
		}
		
		public function getFullyQualifiedName():String {
			return fullyQualifiedName;
		}
	
		private function checkIfLoaded():void {
			if (parsedInfo != null) {
				var parsedInfoRem:ParsedJavaClass = parsedInfo;
				parsedInfo = null;
				load(parsedInfoRem);
			}
		}
		
		private function load(parsedInfoRem:ParsedJavaClass):void {
			this.flags = JVMClassFlags.fromClassInfo(parsedInfoRem.getClassInfo());
			this.superClass = classLoadingContext.getJVMClass(parsedInfoRem.getClassInfo().getSuperClassName());
			
			var emai:EnclosingMethodAttributeInfo = parsedInfoRem.getEnclosingMethodAttributeInfo();
			if (emai != null) {
				this.enclosingClass = classLoadingContext.getJVMClass(emai.getClassName());
				if (emai.getMethodName() != null) {
					var enclosingMethodIdentity:JVMMethodIdentity = JVMMethodIdentity.fromDescriptor(classLoadingContext, emai.getMethodName(), emai.getMethodDescriptor());
					for each (var mm:JVMMethod in enclosingClass.getMethods()) {
						if (mm.getIdentity().equals(enclosingMethodIdentity)) {
							this.enclosingMethod = mm;
						}
					}
				}
			}
			
			this.interfaces = new Vector.<JVMClass>();
			for each (var i:String in parsedInfoRem.getClassInfo().getInterfaces()) {
				interfaces.push(classLoadingContext.getJVMClass(i));
			}
			
			this.fields = new Vector.<JVMField>();
			for each (var f:FieldInfo in parsedInfoRem.getFieldInfos()) {
				var field:JVMField = JVMField.fromInfo(this, classLoadingContext, f);
				fields.push(field);
				if (field.getFlags().isStatic()) {
					var constantAttribute:JVMConstantValueFieldAttribute = (JVMConstantValueFieldAttribute)(field.getAttributes()["ConstantValue"]);
					if (constantAttribute != null) {
						var constant:ConstantEntry = constantAttribute.getConstantValue();
						if (constant is UTF8ConstantEntry) {
							(UTF8ConstantEntry)(constant).initialize(classLoadingContext);
						}
						setFieldValue(field, constant.getJVMValue());
					} else {
						setFieldValue(field, field.getType().getDefaultValue());
					}
				}
			}
			
			this.methods = new Vector.<JVMMethod>();
			trace("start loop")
			for each (var m:MethodInfo in parsedInfoRem.getMethodInfos()) {
				methods.push(JVMMethod.fromInfo(classLoadingContext, this, m));
			}
			trace(methods.length)
			trace("Finish loop")
		}
		
		public function getSuperClass():JVMClass {
			checkIfLoaded();
			return superClass;
		}
	
		public function getInterfaces():Vector.<JVMClass> {
			checkIfLoaded();
			return interfaces;
		}
	
		public function getFlags():JVMClassFlags {
			checkIfLoaded();
			return flags;
		}
	
		public function getFields():Vector.<JVMField> {
			checkIfLoaded();
			return fields;
		}
	
		public function getMethods():Vector.<JVMMethod> {
			checkIfLoaded();
			return methods;
		}
	
		public function resolveField(name:String):JVMField {
			var field:JVMField = getField(name);
			if (field == null) {
				return superClass.resolveField(name);
			} else {
				return field;
			}
		}
	
		private function getField(name:String):JVMField {
			for each (var f:JVMField in getFields()) {
				if (f.getName() == name) {
					return f;
				}
			}
			return null;
		}
	
		public function resolveStaticMethod(identity:JVMMethodIdentity):JVMMethod {
			var method:JVMMethod = getStaticMethod(identity);
			if (method == null) {
				return superClass.resolveStaticMethod(identity);
			} else {
				return method;
			}
		}
	
		private function getStaticMethod(identity:JVMMethodIdentity):JVMMethod {
			for each (var m:JVMMethod in getMethods()) {
				if (m.getFlags().isStatic() && m.getIdentity().equals(identity)) {
					return m;
				}
			}
			return null;
		}
	
		public function getWordSize():int {
			return 1;
		}
	
		public function isCastableTo(jvmClass:JVMClass):Boolean {
			if (this == jvmClass) {
				return true;
			} else {
				for each (var i:JVMClass in getInterfaces()) {
					if (i.isCastableTo(jvmClass)) {
						return true;
					}
				}
				if (superClass != null) {
					return superClass.isCastableTo(jvmClass);
				} else {
					return false;
				}
			}
		}
	
		public function initAllFields(jvmObject:JVMObject):void {
			initFields(jvmObject);
			if (superClass != null) {
				superClass.initAllFields(jvmObject);
			}
		}
	
		private function initFields(jvmObject:JVMObject):void {
			for each (var f:JVMField in getFields()) {
				if (!f.getFlags().isStatic()) {
					jvmObject.setFieldValue(f, f.getType().getDefaultValue());
				}
			}
		}
	
		public function getByPush(from:FieldHolder, jvmField:JVMField, frame:FrameExecutionContext):void {
			var fieldValue:JVMObject = (JVMObject)(from.getFieldValue(jvmField));
			frame.pushReference(fieldValue);
		}
	
		public function getDefaultValue():Object {
			return null;
		}
	
		public function resolveVirtualMethod(identity:JVMMethodIdentity):JVMMethod {
			var method:JVMMethod = methodCache[identity];
			if (method == null) {
				method = getVirtualMethod(identity);
				if (method == null) {
					method = superClass.resolveVirtualMethod(identity);
				}
				methodCache[identity] = method;
			}
			return method;
		}
	
		private function getVirtualMethod(identity:JVMMethodIdentity):JVMMethod {
			for each (var m:JVMMethod in getMethods()) {
				if (!m.getFlags().isStatic() && m.getIdentity().equals(identity)) {
					return m;
				}
			}
			return null;
		}
	
		public function getDescriptor():String {
			return "L"+fullyQualifiedName+";";
		}
	
		public function performPop(frame:FrameExecutionContext):Object {
			return frame.popReference();
		}
	
		public function getInitializerIfNeeded():JVMMethod {
			if (initialized) {
				return null;
			} else {
				initialized = true;
				var clinit:JVMMethod = getStaticMethod(JVMMethodIdentity.fromValues("<clinit>", JVMPrimitiveVoid.INSTANCE, Vector.<JVMType>([])));
				return clinit;
			}
		}
	
		public function resolveSpecialMethod(identity:JVMMethodIdentity):JVMMethod {
			var method:JVMMethod = methodCache[identity];
			if (method == null) {
				method = getVirtualMethod(identity);
				if (method == null) {
					method = superClass.getVirtualMethod(identity);
				}
				methodCache[identity] = method;
			}
			return method;
		}
	
		public function performPush(frame:FrameExecutionContext, value:Object):void {
			frame.pushReference((JVMObject)(value));
		}
	
		public function getClassLoadingContext():JVMClassLoadingContext {
			return classLoadingContext;
		}
	
		public function getEnclosingMethod():JVMMethod {
			return enclosingMethod;
		}
	
		public function getEnclosingClass():JVMClass {
			return enclosingClass;
		}
	
		public function getJavaName():String {
			return JVMTools.slashesToDots(fullyQualifiedName);
		}
	
		public function instantiate():JVMObject {
			return new JVMObject(this);
		}
	
		public function getClassLock():JVMObject {
			return classLock;
		}
	}
}
