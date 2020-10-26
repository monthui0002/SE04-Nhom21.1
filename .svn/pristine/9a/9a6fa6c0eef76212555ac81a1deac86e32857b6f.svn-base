package com.jkgh.jvm.runtime {
	
	public class Radix {

		///////////////////////////////////////////////////////////////////////
		// Constants.

		public static const MIN:int = 2;
		public static const MAX:int = 36;

		public static const ALPHA:String = "0123456789abcdefghijklmnopqrstuvwxyz";
		public static const BASE_UINT:Number = Number(uint.MAX_VALUE) + Number(1);
		public static const BASE_UINT_SQUARE:Number = BASE_UINT * BASE_UINT;

		private static const _RADICES:Array = new Array(MAX + 1);
		private static const _ZEROS:Array = function():Array {
			var zeros:Array = new Array(32);

			var zeros31:String = "0000000000000000000000000000000";
			for (var i:int = 0; i < 31; i++)
				zeros[i] = zeros31.substr(0, i);
			zeros[31] = zeros31;

			return zeros;
		}();

		///////////////////////////////////////////////////////////////////////
		// Fields.

		private var _value:int;
		private var _pattern:RegExp;
		private var _maxUintPower:uint;
		private var _maxUintExponent:uint;

		///////////////////////////////////////////////////////////////////////
		// Constructor.

		function Radix(value:int) {
			if (value < MIN || value > MAX)
				throw new Error("radix out of range: " + value);

			// store radix value.
			_value = value;

			// compute validation regexp.
			var pattern:String = "^[0-" + (value < 10 ? (value - 1) : 9);
			if (value > 11)
				pattern += "a-" + ALPHA.charAt(value - 1);
			else if (value == 11)
				pattern += "a";
			pattern += "]+$";
			_pattern = new RegExp(pattern, "ig");

			// compute max radix power that fits in a uint and the
			// corresponding exponent.
			var power:Number = 1, exponent:uint = 0;
			while (power < BASE_UINT) {
				power *= value;
				exponent++;
			}
			_maxUintPower = power / value;
			_maxUintExponent = exponent - 1;
		}

		///////////////////////////////////////////////////////////////////////
		// Static accessors.

		public static function getRadix(value:int):Radix {
			var radix:Radix = _RADICES[value];
			if (radix == null) {
				radix = new Radix(value);
				_RADICES[value] = radix;
			}
			return radix;
		}

		public static function getZeros(count:int):String {
			if (count < 0)
				throw new Error("Zeros count cannot be negative: " + count);
			if (count < 32)
				return _ZEROS[count];

			var div31:int = (count / 31),
				mod31:int = (count % 31),
				zeros31:String = _ZEROS[31],
				zeros:String = zeros31,
				i:int;

			for (i = 1; i < div31; i++)
				zeros += zeros31;

			zeros += _ZEROS[mod31];

			return zeros;
		}

		///////////////////////////////////////////////////////////////////////
		// Properties.

		public function get value():int {
			return _value;
		}

		public function get pattern():RegExp {
			return _pattern;
		}

		public function get maxUintPower():uint {
			return _maxUintPower;
		}

		public function get maxUintExponent():uint {
			return _maxUintExponent;
		}

		///////////////////////////////////////////////////////////////////////
		// Number format validation.

		public function validate(s:String):Boolean {
			_pattern.lastIndex = 0;
			return _pattern.test(s);
		}
	}
}
