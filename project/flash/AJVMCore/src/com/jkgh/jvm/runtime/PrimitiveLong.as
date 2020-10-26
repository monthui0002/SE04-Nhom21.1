package com.jkgh.jvm.runtime {
	

	public class PrimitiveLong {

		///////////////////////////////////////////////////////////////////////
		// Constants.

		public static const MAX_VALUE:PrimitiveLong = newLong(0x7fffffff, 0xffffffff, false);
		public static const MIN_VALUE:PrimitiveLong = newLong(0x80000000, 0x00000000, false);
		public static const BASE_UINT:Number = Number(uint.MAX_VALUE) + Number(1);
		
		/**
		 * The <code>PrimitiveLong</code> constant zero.
		 */
		public static const ZERO:PrimitiveLong = newLong(0x00000000, 0x00000000, false);

		/**
		 * The <code>PrimitiveLong</code> constant one.
		 */
		public static const ONE:PrimitiveLong = newLong(0x00000000, 0x00000001, false);

		/**
		 * The <code>PrimitiveLong</code> constant ten.
		 */
		public static const TEN:PrimitiveLong = newLong(0x00000000, 0x0000000a, false);

		///////////////////////////////////////////////////////////////////////
		// Fields.

		private var _u0:uint = 0;
		private var _u1:uint = 0;

		///////////////////////////////////////////////////////////////////////
		// Constructor.

		/**
		 * Constructs a new <code>PrimitiveLong</code> instance according to the
		 * supplied parameters.
		 * <br>
		 * <br>
		 * The <code>value</code> parameter may be a String representation of
		 * an integer, a <code>int</code> primitive value, a <code>Number</code>
		 * or even another <code>PrimitiveLong</code>:
		 * <br>
		 * <ul>
		 * <li><code>String</code>: it must be a not empty String in the form of
		 * 		<i>-?[0-9a-zA-Z]+</i> (ie: an optional '-' character followed by
		 * 		a not empty sequence of digits (with radix >= 2 and <= 36)). When
		 * 		a String value is used, the second parameter <code>radix</code>
		 * 		is also used, and the supplied digits must be in accordance with
		 * 		the specified radix.</li>
		 * <li><code>int</code>: a primitive integer value (radix ignored).</li>
		 * <li><code>Number</code>: a primitive number value (radix ignored). Only
		 * 		the fixed part of the number will be used (decimal part is
		 *      ignored).</li>
		 * <li><code>PrimitiveLong</code>: the new PrimitiveLong will be an exact copy of
		 * 		the specified parameter.</li>
		 * <li><code>null</code>: the new PrimitiveLong will be an exact copy of
		 * 		the constant <code>PrimitiveLong.ZERO</code>.</li>
		 * </ul>
		 * 
		 * @param value the value to be assigned to the new <code>PrimitiveLong</code>.
		 * @param radix the radix (2 <= radix <= 36) to be used for string conversion
		 * 		(ignored if the <code>value</code> parameter isn't a string).
		 * @throws org.granite.math.NumberFormatError if the <code>value</code>
		 * 		parameter is an invalid String representation or it doesn't fit into
		 * 		a signed 64bits type. 
		 * @throws org.granite.math.IllegalArgumentError if the <code>value</code>
		 * 		parameter is not one of the supported types or if it is
		 * 		<code>Number.NaN</code>, <code>Number.POSITIVE_INFINITY</code> or
		 * 		<code>Number.NEGATIVE_INFINITY</code>.
		 */
		function PrimitiveLong(value:* = null) {
			if (value != null) {
				if (value is PrimitiveLong) {
					_u0 = (value as PrimitiveLong)._u0;
					_u1 = (value as PrimitiveLong)._u1;
				} else if (value is int) {
					forInt(this, value as int);
				} else if (value is Number) {
					forInt(this, value as Number);
				} else {
					throw new Error("Cannot construct a PrimitiveLong from: " + value);
				}
			}
		}

		private static function forInt(a:PrimitiveLong, value:int):void {
			if (value < 0) {
				a._u1 = 0xffffffff;
				a._u0 = (~(-value)) + 1;
			}
			else {
				a._u1 = 0;
				a._u0 = uint(value);
			}
		} 
		
		private static function newLong(u1:uint, u0:uint, constants:Boolean = true):PrimitiveLong {
			if (constants) {
				if (u1 == 0) {
					if (u0 == 0)
						return ZERO;
					if (u0 == 1)
						return ONE;
					if (u0 == 10)
						return TEN;
				}
				else if (u1 == 0x80000000) {
					if (u0 == 0x00000000)
						return MIN_VALUE;
				}
				else if (u1 == 0x7fffffff && u0 == 0xffffffff)
					return MAX_VALUE;
			}

			var l:PrimitiveLong = new PrimitiveLong();
			l._u0 = u0;
			l._u1 = u1;
			return l;
		}

		public static function newFromUints(u1:uint, u0:uint):PrimitiveLong {
			var l:PrimitiveLong = new PrimitiveLong();
			l._u0 = u0;
			l._u1 = u1;
			return l;
		}
		
		private static function asLong(value:*):PrimitiveLong {
			if (value is PrimitiveLong)
				return value as PrimitiveLong;

			if (value is int) {
				switch (value as int) {
					case 0: return ZERO;
					case 1: return ONE;
					case 10: return TEN;
				} 
			}
			else if (value is String) {
				switch (value as String) {
					case "0": return ZERO;
					case "1": return ONE;
					case "10": return TEN;
				} 
			}

			return new PrimitiveLong(value);
		}

		///////////////////////////////////////////////////////////////////////
		// Properties.

	    /**
	     * The sign of this <code>PrimitiveLong</code> as an <code>int</code>, ie:
		 * -1, 0 or 1 as the value of this <code>PrimitiveLong</code> is negative,
		 * zero or positive.
	     */
		public function get sign():int {
			if (_u0 == 0 && _u1 == 0)
				return 0;
			return ((_u1 & 0x80000000) != 0 ? -1 : 1);
		}

	    /**
	     * The low 32bits of this <code>PrimitiveLong</code> as an <code>uint</code>.
	     */
		public function get lowBits():uint {
			return _u0;
		}

	    /**
	     * The high 32bits of this <code>PrimitiveLong</code> as an <code>uint</code>.
	     */
		public function get highBits():uint {
			return _u1;
		}

		///////////////////////////////////////////////////////////////////////
		// Bitwise and bit shift operators.

		/**
		 * Returns <code>(~this)</code> (bitwise NOT).
		 * 
		 * @return <code>(~this)</code>.
		 */
		public function not():PrimitiveLong {
			return newLong(~_u1, ~_u0);
		}

		/**
		 * Returns <code>(this &amp; b)</code> (bitwise AND).
		 * 
		 * @param b the other operand used in the operation (may be of any type
		 * 		accepted by the <code>PrimitiveLong</code> constructor).
		 * @return <code>(this &amp; b)</code>.
		 */
		public function and(b:*):PrimitiveLong {
			var l:PrimitiveLong = asLong(b);
			return newLong((_u1 & l._u1), (_u0 & l._u0));
		}

		/**
		 * Returns <code>(this | b)</code> (bitwise OR).
		 * 
		 * @param b the other operand used in the operation (may be of any type
		 * 		accepted by the <code>PrimitiveLong</code> constructor).
		 * @return <code>(this | b)</code>.
		 */
		public function or(b:*):PrimitiveLong {
			var l:PrimitiveLong = asLong(b);
			return newLong((_u1 | l._u1), (_u0 | l._u0));
		}

		/**
		 * Returns <code>(this ^ b)</code> (bitwise XOR).
		 * 
		 * @param b the other operand used in the operation (may be of any type
		 * 		accepted by the <code>PrimitiveLong</code> constructor).
		 * @return <code>(this ^ b)</code>.
		 */
		public function xor(b:*):PrimitiveLong {
			var l:PrimitiveLong = asLong(b);
			return newLong((_u1 ^ l._u1), (_u0 ^ l._u0));
		}

		/**
		 * Returns <code>(this &lt;&lt; b)</code> (bitwise left shift).
		 * 
		 * @value the number of bits to be left shifted.
		 * @return <code>(this &lt;&lt; b)</code>.
		 */
		public function leftShift(value:uint):PrimitiveLong {
			value %= 64;

			if (value == 0)
				return this;

			if (value >= 32)
				return newLong(_u0 << (value % 32), 0);

			// value < 32.
			return newLong(
				(_u1 << value) | (_u0 >>> (32 - value)),
				(_u0 << value)
			);
		}

		/**
		 * Returns <code>(this &gt;&gt; b)</code> (bitwise right shift).
		 * 
		 * @value the number of bits to be left shifted.
		 * @unsigned if <code>true</code>, the operation will behave as a
		 * 		bitwise <i>unsigned</i> right shift operator (&gt;&gt;&gt;).
		 * @return <code>(this &gt;&gt; b)</code>.
		 */
		public function rightShift(value:uint, unsigned:Boolean = false):PrimitiveLong {
			value %= 64;

			if (value == 0)
				return this;

			if (value >= 32) {

				if (unsigned)
					return newLong(0, _u1 >>> (value % 32));

				return newLong((
					(_u1 & 0x80000000) != 0 ? uint.MAX_VALUE : 0),
					(_u1 >> (value % 32))
				);
			}

			// value < 32.
			if (unsigned) {
				return newLong(
					(_u1 >>> value),
					(_u0 >>> value) | (_u1 << (32 - value))
				);
			}

			return newLong(
				(_u1 >> value),
				(_u0 >> value) | (_u1 << (32 - value))
			);
		}

	    /**
	     * Returns <code>true</code> if and only if the designated bit is set:
	     * computes <code>((this &amp; (1 &lt;&lt; n)) != 0)</code>.
	     *
	     * @param index the index of bit to test.
	     * @return <code>true</code> if and only if the designated bit is set.
	     * @throws org.granite.math.ArithmeticError if <code>index</code> is negative
		 * 		or greater than 63.
	     */
		public function testBit(index:int):Boolean {
			if (index < 0 || index > 63)
				throw new Error("Index out of range: " + index);
			if (index <= 31)
				return ((_u0 & (uint(1) << index)) != 0);
			return ((_u1 & (uint(1) << (index % 32))) != 0);
		}

	    /**
	     * Returns a <code>PrimitiveLong</code> whose value is equivalent to this <code>PrimitiveLong</code>
	     * with the designated bit set: computes <code>(this | (1 &lt;&lt; n))</code>.
	     *
	     * @param index the index of bit to set.
	     * @return <code>this | (1 &lt;&lt; n)</code>
	     * @throws org.granite.math.ArithmeticError if <code>index</code> is negative
		 * 		or greater than 63.
	     */
		public function setBit(index:int):PrimitiveLong {
			if (testBit(index))
				return this;

			var u0:uint = _u0, u1:uint = _u1;
			if (index <= 31)
				u0 |= (uint(1) << index);
			else
				u1 |= (uint(1) << (index % 32));
			return newLong(u1, u0);
		}

	    /**
	     * Returns a <code>PrimitiveLong</code> whose value is equivalent to this <code>PrimitiveLong</code>
	     * with the designated bit cleared: computes <code>(this &amp; ~(1 &lt;&lt; n))</code>.
	     *
	     * @param index the index of bit to clear.
	     * @return <code>this &amp; ~(1 &lt;&lt; n)</code>
	     * @throws org.granite.math.ArithmeticError if <code>index</code> is negative
		 * 		or greater than 63.
	     */
		public function clearBit(index:int):PrimitiveLong {
			if (!testBit(index))
				return this;

			var u0:uint = _u0, u1:uint = _u1;
			if (index <= 31)
				u0 &= ~(uint(1) << index);
			else
				u1 &= ~(uint(1) << (index % 32));
			return newLong(u1, u0);
		}

		///////////////////////////////////////////////////////////////////////
		// Unary operations.

	    /**
	     * Returns a <code>PrimitiveLong</code> whose value is the absolute value
		 * of this <code>PrimitiveLong</code>.
	     *
	     * @return the absolute value of this <code>PrimitiveLong</code>.
	     */
		public function abs():PrimitiveLong {
			if (sign >= 0)
				return this;
			return negate();
		}

	    /**
	     * Returns a <code>PrimitiveLong</code> whose value is <code>(-this)</code>.
	     *
	     * @return <code>(-this)</code>.
	     */
		public function negate():PrimitiveLong {
			var u0:uint = ((~_u0) + 1),
				u1:uint = (~_u1);

			// overflown...
			if (_u0 == 0)
				u1++;

			return newLong(u1, u0);
		}

		///////////////////////////////////////////////////////////////////////
		// Binary operations.

	    /**
	     * Returns a <code>PrimitiveLong</code> whose value is <code>(this + b)</code>,
		 * with a possible overflow (silently ignored, as in primitive operations).
		 * <br>
		 * <br>
		 * The <code>b</code> parameter may be of any of the supported types as
		 * specified in the <code>PrimitiveLong</code> constructor documentation
		 * (a radix of 10 is assumed for String representations).
	     *
	     * @param b the value to be added to this <code>PrimitiveLong</code>.
	     * @return <code>(this + b)</code>.
		 * @throws org.granite.math.NumberFormatError if the <code>b</code>
		 * 		parameter is an invalid String representation (for radix 10). 
		 * @throws org.granite.math.IllegalArgumentError if the <code>b</code>
		 * 		parameter is not one of the supported types or if it is
		 * 		<code>Number.NaN</code>, <code>Number.POSITIVE_INFINITY</code> or
		 * 		<code>Number.NEGATIVE_INFINITY</code>.
	     */
		public function add(b:*):PrimitiveLong {
			var l:PrimitiveLong = asLong(b),
				s0:uint = _u0 + l._u0,
				s1:uint = _u1 + l._u1;

			// overflown...
			if (s0 < _u0 || s0 < l._u0)
				s1++;

			return newLong(s1, s0);
		}

	    /**
	     * Returns a <code>PrimitiveLong</code> whose value is <code>(this - b)</code>,
		 * with a possible overflow (silently ignored, as in primitive operations).
		 * <br>
		 * <br>
		 * The <code>b</code> parameter may be of any of the supported types as
		 * specified in the <code>PrimitiveLong</code> constructor documentation
		 * (a radix of 10 is assumed for String representations).
	     *
	     * @param b the value to be subtracted from this <code>PrimitiveLong</code>.
	     * @return <code>(this - b)</code>.
		 * @throws org.granite.math.NumberFormatError if the <code>b</code>
		 * 		parameter is an invalid String representation (for radix 10). 
		 * @throws org.granite.math.IllegalArgumentError if the <code>b</code>
		 * 		parameter is not one of the supported types or if it is
		 * 		<code>Number.NaN</code>, <code>Number.POSITIVE_INFINITY</code> or
		 * 		<code>Number.NEGATIVE_INFINITY</code>.
	     */
		public function subtract(b:*):PrimitiveLong {
			var l:PrimitiveLong = asLong(b),
				s0:uint = _u0 - l._u0,
				s1:uint = _u1 - l._u1;

			// overflown...
			if (_u0 < l._u0)
				s1--;

			return newLong(s1, s0);
		}

	    /**
	     * Returns a <code>PrimitiveLong</code> whose value is <code>(this ~~ b)</code>,
		 * with a possible overflow (silently ignored, as in primitive operations).
		 * <br>
		 * <br>
		 * The <code>b</code> parameter may be of any of the supported types as
		 * specified in the <code>PrimitiveLong</code> constructor documentation
		 * (a radix of 10 is assumed for String representations).
	     *
	     * @param b the value to be multiplied by this <code>PrimitiveLong</code>.
	     * @return <code>(this ~~ b)</code>.
		 * @throws org.granite.math.NumberFormatError if the <code>b</code>
		 * 		parameter is an invalid String representation (for radix 10). 
		 * @throws org.granite.math.IllegalArgumentError if the <code>b</code>
		 * 		parameter is not one of the supported types or if it is
		 * 		<code>Number.NaN</code>, <code>Number.POSITIVE_INFINITY</code> or
		 * 		<code>Number.NEGATIVE_INFINITY</code>.
	     */
		public function multiply(b:*):PrimitiveLong {
			var l:PrimitiveLong = asLong(b),
				p:Array = [0, 0],
				p0:uint = 0,
				p1:uint = 0;

			if (_u0 == 1)
				p0 = l._u0;
			else if (_u0 != 0) {
				if (l._u0 == 1)
					p0 = _u0;
				else if (l._u0 != 0) {
					multiplyUints(_u0, l._u0, p);
					p0 = p[0];
					p1 = p[1];
				}
			}

			// forget about ((_u1 * l._u1) << 32): no room for the result.
			p1 += (_u0 * l._u1) + (l._u0 * _u1); 

			return newLong(p1, p0);
		}

		private static function multiplyUints(a:uint, b:uint, r:Array):void {
			var a0:uint = (a & 0xffff),
				a1:uint = (a >>> 16),
				b0:uint = (b & 0xffff),
				b1:uint = (b >>> 16),

				a0b0:uint = (a0 * b0),
				a0b1:uint = (a0 * b1),
				a1b0:uint = (a1 * b0),
				a1b1:uint = (a1 * b1);

			b0 = (a0b1 << 16);
			a0 = a0b0 + b0;
			if (a0 < a0b0 || a0 < b0)
				a1 = 1;
			else
				a1 = 0;

			b0 = (a1b0 << 16);
			b1 = a0 + b0;
			if (b1 < a0 || b1 < b0)
				a1++;

			// return a little endian result.
			r[0] = b1;
			// 0x2 + 0xfffe0001 + 0xfffe + 0xfffe = 0xffffffff max.
			r[1] = a1 + a1b1 + (a0b1 >>> 16) + (a1b0 >>> 16);
		}
		
	    /**
	     * Returns a <code>PrimitiveLong</code> whose value is <code>(this / b)</code>.
		 * <br>
		 * <br>
		 * The <code>b</code> parameter may be of any of the supported types as
		 * specified in the <code>PrimitiveLong</code> constructor documentation
		 * (a radix of 10 is assumed for String representations).
	     *
	     * @param b the value by which this <code>PrimitiveLong</code> is to be divided.
	     * @return <code>(this / b)</code>.
		 * @throws org.granite.math.ArithmeticError if the <code>b</code>
		 * 		parameter is equals to <code>0</code>. 
		 * @throws org.granite.math.NumberFormatError if the <code>b</code>
		 * 		parameter is an invalid String representation (for radix 10). 
		 * @throws org.granite.math.IllegalArgumentError if the <code>b</code>
		 * 		parameter is not one of the supported types or if it is
		 * 		<code>Number.NaN</code>, <code>Number.POSITIVE_INFINITY</code> or
		 * 		<code>Number.NEGATIVE_INFINITY</code>.
	     */
		public function divide(b:*):PrimitiveLong {
			return divideAndRemainder(b)[0];
		}

	    /**
	     * Returns a <code>PrimitiveLong</code> whose value is <code>(this % b)</code>.
		 * <br>
		 * <br>
		 * The <code>b</code> parameter may be of any of the supported types as
		 * specified in the <code>PrimitiveLong</code> constructor documentation
		 * (a radix of 10 is assumed for String representations).
	     *
	     * @param b the value by which this <code>PrimitiveLong</code> is to be divided,
		 * 		and the remainder computed.
	     * @return <code>(this % b)</code>.
		 * @throws org.granite.math.ArithmeticError if the <code>b</code>
		 * 		parameter is equals to <code>0</code>. 
		 * @throws org.granite.math.NumberFormatError if the <code>b</code>
		 * 		parameter is an invalid String representation (for radix 10). 
		 * @throws org.granite.math.IllegalArgumentError if the <code>b</code>
		 * 		parameter is not one of the supported types or if it is
		 * 		<code>Number.NaN</code>, <code>Number.POSITIVE_INFINITY</code> or
		 * 		<code>Number.NEGATIVE_INFINITY</code>.
	     */
		public function remainder(b:*):Array {
			return divideAndRemainder(b)[1];
		}

	    /**
	     * Returns an array of two <code>PrimitiveLong</code> containing
		 * <code>(this / b)</code> followed by <code>(this % b)</code>. 
		 * <br>
		 * <br>
		 * The <code>b</code> parameter may be of any of the supported types as
		 * specified in the <code>PrimitiveLong</code> constructor documentation
		 * (a radix of 10 is assumed for String representations).
	     *
	     * @param b the value by which this <code>PrimitiveLong</code> is to be divided,
		 * 		and the remainder computed.
	     * @return an array of two PrimitiveLong: the quotient <code>(this / val)</code>
		 * 		is the initial element, and the remainder <code>(this % val)</code>
		 * 		is the final element.
		 * @throws org.granite.math.ArithmeticError if the <code>b</code>
		 * 		parameter is equals to <code>0</code>. 
		 * @throws org.granite.math.NumberFormatError if the <code>b</code>
		 * 		parameter is an invalid String representation (for radix 10). 
		 * @throws org.granite.math.IllegalArgumentError if the <code>b</code>
		 * 		parameter is not one of the supported types or if it is
		 * 		<code>Number.NaN</code>, <code>Number.POSITIVE_INFINITY</code> or
		 * 		<code>Number.NEGATIVE_INFINITY</code>.
	     */
		public function divideAndRemainder(b:*):Array {
			var l:PrimitiveLong = asLong(b),
				lsign:int = l.sign,
				sign:int = this.sign;

			// b == 0 --> error.
			if (lsign == 0)
				throw new Error("Cannot divide by zero");

			// this == 0 --> [q = 0, r = 0].
			if (sign == 0)
				return [ZERO, ZERO];

			// b == 1 || b == -1
			if ((l._u1 == 0 && l._u0 == 1) || (l._u1 == uint.MAX_VALUE && l._u0 == uint.MAX_VALUE)) {
				// b == 1 --> [q = this, r = 0].
				if (lsign == 1)
					return [this, ZERO];
				// b == -1 --> [q = -this, r = 0].
				return [negate(), ZERO];
			}

			// this == PrimitiveLong.MIN_VALUE. 
			if (_u0 == 0 && _u1 == uint(0x80000000)) {

			}

			// compare the absolute values of this and b.
			var left:PrimitiveLong = (sign < 0 ? this.negate() : this),
				right:PrimitiveLong = (lsign < 0 ? l.negate() : l),
				comp:int = left.compareTo(right);

			// |this| < |b| && this != PrimitiveLong.MIN_VALUE --> 0.
			if (comp < 0 && !(_u0 == 0 && _u1 == uint(0x80000000)))
				return [ZERO, this];

			// |this| == |b| --> +/-1.
			if (comp == 0)
				return [(sign == lsign ? ONE : ONE.negate()), ZERO];

			// |this| > |b|, calculate [q, r].
			var q:PrimitiveLong,
				r:PrimitiveLong,
				ma:MutableBigInteger,
				mb:MutableBigInteger,
				mr:MutableBigInteger;

			// left._u1 == 0 ==> right._u1 == 0 && left._u0 > right._u0.
			if (left._u1 == 0) {
				q = newLong(0, left._u0 / right._u0);
				r = newLong(0, left._u0 % right._u0);
			}
			// left._u1 > 0 && right._u1 == 0.
			else if (right._u1 == 0) {
				ma = new MutableBigInteger(new Uints([left._u0, left._u1]));
				r = newLong(0, ma.divideByUint(right._u0));
				q = newLong(ma.uints[1], ma.uints[0]);
			}
			// left._u1 > 0 && right._u1 > 0.
			else {
				ma = new MutableBigInteger(new Uints([left._u0, left._u1])),
				mb = new MutableBigInteger(new Uints([right._u0, right._u1])),
				mr = ma.divide(mb);

				q = newLong(ma.uints[1], ma.uints[0]);
				r = newLong(mr.uints[1], mr.uints[0]);
			}

			// remainder must have the same sign as the dividend.
			if (sign == -1)
				r = r.negate();

			return (sign == lsign ? [q, r] : [q.negate(), r]);
		}

		///////////////////////////////////////////////////////////////////////
		// Comparisons.

	    /**
	     * Compares this <code>PrimitiveLong</code> with the specified
		 * <code>PrimitiveLong</code>. This method is provided in preference to
		 * individual methods for each of the six boolean comparison operators
		 * (&lt;, ==, &gt;, &lt;=, !=, &gt;=).  The suggested idiom for performing
		 * these comparisons is: <code>(x.compareTo(y) &lt;<i>op</i>&gt; 0)</code>,
		 * where &lt;<i>op</i>&gt; is one of the six comparison operators.
	     *
	     * @param b the <code>PrimitiveLong</code> to which this <code>PrimitiveLong</code>
		 * 		is to be compared.
	     * @return -1, 0 or 1 as this <code>PrimitiveLong</code> is numerically less than,
		 * 		equal to, or greater than <code>b</code>.
	     */
		public function compareTo(b:PrimitiveLong):int {
			if (this === b)
				return 0;

			const sign:int = this.sign,
				  bSign:int = b.sign;

			// this == 0:
			// | b == 0 --> -0 == 0;
			// | b <  0 --> -(-1) == 1;
			// | b >  0 --> -1.
			if (sign == 0)
				return -bSign;

			// sign (!= 0) == bSign.
			if (sign == bSign) {
				// this == b --> 0.
				if (_u1 == b._u1 && _u0 == b._u0)
					return 0;
				// works with positive and negative numbers.
				return (_u1 > b._u1 || _u0 > b._u0 ? 1 : -1);
			}

			// sign (!= 0) != bSign:
			// | sign == -1 --> bSign == 0|1 --> -1;
			// | sign == 1 --> bSign == -1|0 --> 1.
			return sign < bSign ? -1 : 1;
		}

	    /**
	     * Compares this <code>PrimitiveLong</code> with the specified object
		 * for equality.
		 * <br>
		 * <br>
		 * The <code>b</code> parameter may be of any of the supported types as
		 * specified in the <code>PrimitiveLong</code> constructor documentation
		 * (a radix of 10 is assumed for String representations).
	     *
	     * @param b an object to which this <code>PrimitiveLong</code> is to
		 * 		be compared.
	     * @return <code>true</code> if and only if the specified object is
		 * 		a <code>PrimitiveLong</code> (or convertible to a
		 * 		<code>PrimitiveLong</code>) whose value is numerically equal
		 * 		to this <code>PrimitiveLong</code>.
	     */
		public function equals(b:*):Boolean {
			try {
				return (compareTo(asLong(b)) == 0);
			}
			catch (e:Error) {
			}
			return false;
		}

		///////////////////////////////////////////////////////////////////////
		// Conversions.

	    /**
	     * Converts this <code>PrimitiveLong</code> to an <code>int</code>: it is equivalent
		 * to <code>int(this.lowBits)</code> with a possible lose of precision and
		 * a different sign than the original value.
	     *
	     * @return this <code>PrimitiveLong</code> converted to an <code>int</code>.
	     */
		public function toInt():int {
			return int(_u0);
		}

	    /**
	     * Converts this <code>PrimitiveLong</code> to a <code>Number</code> (with a possible
		 * lose of precision).
	     *
	     * @return this <code>PrimitiveLong</code> converted to a <code>Number</code>.
	     */
		public function toNumber():Number {
			var sign:int = this.sign;

			if (sign == 0)
				return 0;
			if (sign == 1)
				return ((Number(_u1) * BASE_UINT) + Number(_u0));

			var abs:PrimitiveLong = this.negate();

			return Number(-1) * ((Number(abs._u1) * BASE_UINT) + Number(abs._u0));
		}
		
		public function ushr(off:int):PrimitiveLong {
			var ret:PrimitiveLong = new PrimitiveLong(this);
			for (var i:int = 0; i<off; ++i) {
				ret.selfUSHR();
			}
			return ret;
		}
		
		public function shr(off:int):PrimitiveLong {
			var ret:PrimitiveLong = new PrimitiveLong(this);
			for (var i:int = 0; i<off; ++i) {
				ret.selfSHR();
			}
			return ret;
		}
		
		private function selfUSHR():void {
			var last:uint = _u1 & 1;
			_u0 = (_u0 >>> 1) | (last << 31);
			_u1 = _u1 >>> 1;
		}
		
		private function selfSHR():void {
			var signBefore:int = this.sign;
			selfUSHR();
			if (this.sign != signBefore) {
				selfNegate();
			}
		}
		
		private function selfNegate():void {
			var u0:uint = ((~_u0) + 1),
				u1:uint = (~_u1);
			
			// overflown...
			if (_u0 == 0)
				u1++;
			
			_u0 = u0;
			_u1 = u1;
		}
		
		public function shl(off:int):PrimitiveLong {
			var ret:PrimitiveLong = new PrimitiveLong(this);
			for (var i:int = 0; i<off; ++i) {
				ret.selfSHL();
			}
			return ret;
		}
		
		public function selfSHL():void {
			var last:uint = _u0 & (1 << 31);
			_u0 = _u0 << 1;
			_u1 = (_u1 << 1) | (last >>> 31);
		}
		
		public function toString():String {
			return toNumber()+"L";
		}
	}
}
