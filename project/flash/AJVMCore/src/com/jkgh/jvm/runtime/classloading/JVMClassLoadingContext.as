package com.jkgh.jvm.runtime.classloading {
	
	
	import com.jkgh.jvm.parsing.parsers.ClassFileParser;
	import com.jkgh.jvm.parsing.parsers.ConstantEntryParser;
	import com.jkgh.jvm.parsing.parsers.FileHeaderInfoParser;
	import com.jkgh.jvm.parsing.types.ClassConstantEntry;
	import com.jkgh.jvm.parsing.types.ConstantEntry;
	import com.jkgh.jvm.parsing.types.FileHeaderInfo;
	import com.jkgh.jvm.parsing.types.ParsedJavaClass;
	import com.jkgh.jvm.parsing.types.StringConstantEntry;
	import com.jkgh.jvm.parsing.types.UTF8ConstantEntry;
	import com.jkgh.jvm.runtime.JVMRuntime;
	import com.jkgh.jvm.runtime.execution.JVMArrayClass;
	import com.jkgh.jvm.runtime.execution.JVMClass;
	import com.jkgh.jvm.runtime.execution.JVMMethodIdentity;
	import com.jkgh.jvm.runtime.execution.JVMSpecialInvocator;
	import com.jkgh.jvm.runtime.execution.JVMType;
	import com.jkgh.jvm.runtime.execution.JVMVirtualInvocator;
	import com.jkgh.jvm.tools.JVMTools;
	import com.jkgh.jvm.tools.Logger;
	
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	public class JVMClassLoadingContext {
	
		private static const LOG:Logger = Logger.getLogger("AJVMInternal");
		
		private var loadedClasses:Dictionary/*String, JVMClass*/;
		private var jvmRuntime:JVMRuntime;
		private var invocators:Dictionary/*String, JVMVirtualInvokator*/;
		private var locatedClasses:Dictionary/*String, ByteArray*/;
		
		public function JVMClassLoadingContext(jvmRuntime:JVMRuntime) {
			this.jvmRuntime = jvmRuntime;
			this.loadedClasses = new Dictionary();
			this.invocators = new Dictionary();
			this.locatedClasses = new Dictionary();
		}
		
		public function loadClass(fullyQualifiedName:String, input:ByteArray):JVMClass {
			var parsed:ParsedJavaClass = ClassFileParser.parse(input);
			var ret:JVMClass = new JVMClass(this, parsed);
			LOG.info(["Loaded ", fullyQualifiedName]);
			loadedClasses[fullyQualifiedName] = ret;
			return ret;
		}
		
		public function getJVMClass(fullyQualifiedName:String):JVMClass {
			if (fullyQualifiedName != null) {
				var ret:JVMClass = loadedClasses[fullyQualifiedName];
				if (ret == null) {
					ret = loadClass(fullyQualifiedName, locateClass(fullyQualifiedName));
				}
				return ret;
			} else {
				return null;
			}
		}
	
		private function locateClass(fullyQualifiedName:String):ByteArray {
			var ret:ByteArray = locatedClasses[fullyQualifiedName];
			if (ret == null) {
				throw new Error("BootstrapClassLoader failed for class "+fullyQualifiedName+".");
			}
			return ret;
		}
	
		public function resolveType(typeDescriptor:String):JVMType {
			switch (typeDescriptor.charAt(0)) {
			case 'L': return getJVMClass(typeDescriptor.substring(1, typeDescriptor.length-1));
			case '[': return getJVMArrayClass(typeDescriptor.substring(1));
			default: return JVMTools.getPrimitiveTypeByDescriptor(typeDescriptor.charAt(0));
			}
		}
	
		public function getJVMArrayClass(componentTypeDescriptor:String):JVMArrayClass {
			var ret:JVMArrayClass = (JVMArrayClass) (loadedClasses["["+componentTypeDescriptor]);
			if (ret == null) {
				ret = new JVMArrayClass(this, componentTypeDescriptor);
				loadedClasses[ret.getFullyQualifiedName()] = ret;
			}
			return ret;
		}
	
		public function getJVMVirtualInvokator(methodName:String, methodDescriptor:String):JVMVirtualInvocator {
			var methodID:String = methodName+methodDescriptor;
			var ret:JVMVirtualInvocator = invocators[methodID];
			if (ret == null) {
				ret = new JVMVirtualInvocator(JVMMethodIdentity.fromDescriptor(this, methodName, methodDescriptor));
				invocators[methodID] = ret;
			}
			return ret;
		}
	
		public function getRuntime():JVMRuntime {
			return jvmRuntime;
		}
	
		public function getJVMSpecialInvokator(methodName:String, methodDescriptor:String, ownerClass:JVMClass):JVMSpecialInvocator {
			var methodID:String = methodName+methodDescriptor+ownerClass;
			var ret:JVMSpecialInvocator = (JVMSpecialInvocator)(invocators[methodID]);
			if (ret == null) {
				ret = new JVMSpecialInvocator(JVMMethodIdentity.fromDescriptor(this, methodName, methodDescriptor), ownerClass);
				invocators[methodID] = ret;
			}
			return ret;
		}
	
		public function getArrayClassForComponent(componentClass:JVMClass):JVMArrayClass {
			return getJVMArrayClass(componentClass.getDescriptor());
		}
		
		public function locatedClass(fullyQualifiedName:String, data:ByteArray):void {
			locatedClasses[fullyQualifiedName] = data;
		}
		
		public function locateClassesUsedBy(fullyQualifiedName:String, after:Function):void {
			if (locatedClasses[fullyQualifiedName] == null) {
				LOG.info(["Locating ", fullyQualifiedName]);
				locatedClasses[fullyQualifiedName] = new Object();
				tryLocateClassesUsedBy(fullyQualifiedName, 0, after);
			} else {
				after();
			}
		}
		
		private function tryLocateClassesUsedBy(fullyQualifiedName:String, i:int, after:Function):void {
			if (i < jvmRuntime.getClasspath().length) {
				ByteArrayLoader.load(jvmRuntime.getClasspath()[i]+"/"+fullyQualifiedName+".class", function(data:ByteArray):void {
					if (data == null) {
						tryLocateClassesUsedBy(fullyQualifiedName, i+1, after);
					} else {
						locatedClass(fullyQualifiedName, data);
						var referenced:Vector.<String> = findClassReferencesOf(data);
						var wait:uint = referenced.length;
						for each (var r:String in referenced) {
							locateClassesUsedBy(r, function():void {
								--wait;
								if (wait == 0) {
									after();
								}
							});
						}
					}
				});
			} else {
				LOG.severe(["Could not locate class ", fullyQualifiedName]);
			}
		}
		
		private function findClassReferencesOf(classData:ByteArray):Vector.<String> {
			var ret:Vector.<String> = new Vector.<String>();
			
			var fileHeaderInfo:FileHeaderInfo = FileHeaderInfoParser.parse(classData);
			
			var constantPool:Vector.<ConstantEntry> = new Vector.<ConstantEntry>(fileHeaderInfo.constantPoolSize());

			for (var i:int = 1; i < fileHeaderInfo.constantPoolSize(); ++i) {
				var constant:ConstantEntry = ConstantEntryParser.parseNextConstant(classData);
				
				constantPool[i] = constant;
				
				if (ConstantEntryParser.isEightByteConstantThatUsesTwoPoolEntries(constant)) {
					++i;
				}
			}
			
			for (var j:int = 0; j < constantPool.length; ++j) {
				var c:ConstantEntry = constantPool[j];
				if (c is ClassConstantEntry) {
					var utf8:UTF8ConstantEntry = (UTF8ConstantEntry) (constantPool[((ClassConstantEntry) (c)).getNameIndex()]);
					var className:String = utf8.getValue();
					if (className.charAt(0) != "[") {
						ret.push(className);
					}
				}
			}
			
			classData.position = 0;
			return ret;
		}
	}
}
