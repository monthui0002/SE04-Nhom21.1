package com.jkgh.jvm.runtime {

public class Uints {

		///////////////////////////////////////////////////////////////////////
		// Fields.

		private var _uints:Array;
		private var _start:int;
		private var _end:int;

		///////////////////////////////////////////////////////////////////////
		// Constructor.

		function Uints(uints:Array = null, start:Number = NaN, end:Number = NaN) {
			_uints = (uints === null ? newUintArray(0) : uints);
			_start = (isNaN(start) ? 0 : start);
			_end = (isNaN(end) ? _uints.length : end); 

			if (_end < _start)
				throw new Error("end must be >= start");
		}

		///////////////////////////////////////////////////////////////////////
		// Properties.

		public function getAt(index:int):uint {
			index += _start;
			if (index < 0 || index >= _end || index >= _uints.length)
				return 0;
			return _uints[index];
		}

		public function setAt(value:uint, index:int):void {
			index += _start;
			if (index < 0 || index > _end || index > _uints.length)
				throw new Error("Index out of range: " + index);
			_uints[index] = value;
			if (index == _end)
				_end++;
		}

		public function get length():int {
			return (_end - _start);
		}
		public function set length(length:int):void {
			if (_start < 0 || _end > _uints.length)
				throw new Error("Cannot set length with start=" + _start + " and end=" + _end + " (normalize first)");

			_uints.length = _end = length + start;
		}

		public function get start():int {
			return _start;
		}
		public function set start(value:int):void {
			if (value > _end)
				throw new Error("start cannot be > end: " + _end);
			_start = value;
		}

		public function get end():int {
			return _end;
		}
		public function set end(value:int):void {
			if (value < _start)
				throw new Error("end cannot be < start: " + _start);
			_end = end;
		}

		public function isNormal():Boolean {
			return (
				_start == 0 &&
				_end == _uints.length && 
				(_end == 0 || _uints[_end - 1] != 0)
			);
		}

		///////////////////////////////////////////////////////////////////////
		// Operations.

		public function normalize():void {

			if (isNormal())
				return;

			if (_start != 0 || _end != _uints.length) {
				// zero length uints or start/end out of significant range.
				if (_start >= _end || _end <= 0 || _start >= _uints.length)
					_uints = newUintArray(0);
				// start < 0 means: uints is the most significant part of the number,
				// followed by -start zeros ("45698987"..."000000" [-start * "0"]).
				else if (_start < 0)
					_uints = newUintArray(-_start).concat(_uints.slice(0, _end));
				else
					_uints = _uints.slice(_start, _end);

				_start = 0;
				_end = _uints.length;
			}

			// remove leading zeros (little endian order).
			while (_end > 0 && _uints[_end - 1] == 0)
				_end--;

			_uints.length = _end;
		}

		public function clone():Uints {
			return new Uints(_uints.concat(), _start, _end);
		}

		///////////////////////////////////////////////////////////////////////
		// Static utility (initialized arrays).

		public static function newUintArray(length:int, def:uint = 0):Array {

			function init(e:*, i:int, a:Array):void {
	            a[i] = def;
	        }

			if (length <= 0)
				return new Array(0);

			var uints:Array = new Array(length);
			uints.forEach(init);
			return uints;
		}
	}
}
