package com.jkgh.jvm.runtime {
	import flash.utils.ByteArray;
	
	public class NumberHelper {
		
		public static function longBitsToDouble(l:PrimitiveLong):PrimitiveDouble {
			var helper:ByteArray = new ByteArray();
			helper.writeInt(l.highBits);
			helper.writeInt(l.lowBits);
			helper.position = 0;
			var ret:Number = helper.readDouble();
			return new PrimitiveDouble(ret);
		}

		public static function intBitsToFloat(i:int):PrimitiveFloat {
			var helper:ByteArray = new ByteArray();
			helper.writeInt(i);
			helper.position = 0;
			var ret:Number = helper.readFloat();
			return new PrimitiveFloat(ret);
		}

		public static function floatToRawIntBits(f:PrimitiveFloat):int {
			var helper:ByteArray = new ByteArray();
			helper.writeFloat(f.getValue());
			helper.position = 0;
			var ret:Number = helper.readInt();
			return ret;
		}

		public static function doubleToRawLongBits(d:PrimitiveDouble):PrimitiveLong {
			var helper:ByteArray = new ByteArray();
			helper.writeDouble(d.getValue());
			helper.position = 0;
			var u1:uint = helper.readUnsignedInt();
			var u0:uint = helper.readUnsignedInt();
			var ret:PrimitiveLong = PrimitiveLong.newFromUints(u1, u0);
			return ret;
		}
		
	}
}
