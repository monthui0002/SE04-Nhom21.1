package java.lang;

public final class Double extends Number implements Comparable<Double> {

	/**
	 * The maximum positive value a <code>double</code> may represent is
	 * 1.7976931348623157e+308.
	 */
	public static final double MAX_VALUE = 1.7976931348623157e+308;

	/**
	 * The minimum positive value a <code>double</code> may represent is 5e-324.
	 */
	public static final double MIN_VALUE = 5e-324;

	/**
	 * The value of a double representation -1.0/0.0, negative infinity.
	 */
	public static final double NEGATIVE_INFINITY = -1.0 / 0.0;

	/**
	 * The value of a double representing 1.0/0.0, positive infinity.
	 */
	public static final double POSITIVE_INFINITY = 1.0 / 0.0;

	/**
	 * All IEEE 754 values of NaN have the same value in Java.
	 */
	public static final double NaN = 0.0 / 0.0;

	/**
	 * The number of bits needed to represent a <code>double</code>.
	 * 
	 * @since 1.5
	 */
	public static final int SIZE = 64;

	/**
	 * Cache representation of 0
	 */
	private static final Double ZERO = new Double(0.0d);

	/**
	 * Cache representation of 1
	 */
	private static final Double ONE = new Double(1.0d);

	
	private final double value;

	public Double(double value) {
		this.value = value;
	}

	public Double(String s) {
		value = parseDouble(s);
	}

	public static String toString(double d) {
		return VMNumber.toString(d);
	}

	public static String toHexString(double d) {
		if (isNaN(d))
			return "NaN";
		if (isInfinite(d))
			return d < 0 ? "-Infinity" : "Infinity";

		long bits = doubleToLongBits(d);
		StringBuilder result = new StringBuilder();

		if (bits < 0) {
			result.append('-');
		}
		result.append("0x");

		final int mantissaBits = 52;
		final int exponentBits = 11;
		long mantMask = (1L << mantissaBits) - 1;
		long mantissa = bits & mantMask;
		long expMask = (1L << exponentBits) - 1;
		long exponent = (bits >>> mantissaBits) & expMask;

		result.append(exponent == 0 ? '0' : '1');
		result.append('.');
		result.append(Long.toHexString(mantissa));
		if (exponent == 0 && mantissa != 0) {
			// Treat denormal specially by inserting '0's to make
			// the length come out right. The constants here are
			// to account for things like the '0x'.
			int offset = 4 + ((bits < 0) ? 1 : 0);
			// The silly +3 is here to keep the code the same between
			// the Float and Double cases. In Float the value is
			// not a multiple of 4.
			int desiredLength = offset + (mantissaBits + 3) / 4;
			while (result.length() < desiredLength)
				result.insert(offset, '0');
		}
		result.append('p');
		if (exponent == 0 && mantissa == 0) {
			// Zero, so do nothing special.
		} else {
			// Apply bias.
			boolean denormal = exponent == 0;
			exponent -= (1 << (exponentBits - 1)) - 1;
			// Handle denormal.
			if (denormal)
				++exponent;
		}

		result.append(Long.toString(exponent));
		return result.toString();
	}

	/**
	 * Returns a <code>Double</code> object wrapping the value. In contrast to
	 * the <code>Double</code> constructor, this method may cache some values.
	 * It is used by boxing conversion.
	 * 
	 * @param val
	 *            the value to wrap
	 * @return the <code>Double</code>
	 * @since 1.5
	 */
	public static Double valueOf(double val) {
		if ((val == 0.0) && (doubleToRawLongBits(val) == 0L))
			return ZERO;
		else if (val == 1.0)
			return ONE;
		else
			return new Double(val);
	}

	/**
	 * Create a new <code>Double</code> object using the <code>String</code>.
	 * 
	 * @param s
	 *            the <code>String</code> to convert
	 * @return the new <code>Double</code>
	 * @throws NumberFormatException
	 *             if <code>s</code> cannot be parsed as a <code>double</code>
	 * @throws NullPointerException
	 *             if <code>s</code> is null.
	 * @see #parseDouble(String)
	 */
	public static Double valueOf(String s) {
		return valueOf(parseDouble(s));
	}

	public static double parseDouble(String str) {
		return VMNumber.parseDouble(str);
	}

	/**
	 * Return <code>true</code> if the <code>double</code> has the same value as
	 * <code>NaN</code>, otherwise return <code>false</code>.
	 * 
	 * @param v
	 *            the <code>double</code> to compare
	 * @return whether the argument is <code>NaN</code>.
	 */
	public static boolean isNaN(double v) {
		return v != v;
	}

	/**
	 * Return <code>true</code> if the <code>double</code> has a value equal to
	 * either <code>NEGATIVE_INFINITY</code> or <code>POSITIVE_INFINITY</code>,
	 * otherwise return <code>false</code>.
	 * 
	 * @param v
	 *            the <code>double</code> to compare
	 * @return whether the argument is (-/+) infinity.
	 */
	public static boolean isInfinite(double v) {
		return v == POSITIVE_INFINITY || v == NEGATIVE_INFINITY;
	}

	/**
	 * Return <code>true</code> if the value of this <code>Double</code> is the
	 * same as <code>NaN</code>, otherwise return <code>false</code>.
	 * 
	 * @return whether this <code>Double</code> is <code>NaN</code>
	 */
	public boolean isNaN() {
		return isNaN(value);
	}

	/**
	 * Return <code>true</code> if the value of this <code>Double</code> is the
	 * same as <code>NEGATIVE_INFINITY</code> or <code>POSITIVE_INFINITY</code>,
	 * otherwise return <code>false</code>.
	 * 
	 * @return whether this <code>Double</code> is (-/+) infinity
	 */
	public boolean isInfinite() {
		return isInfinite(value);
	}

	/**
	 * Convert the <code>double</code> value of this <code>Double</code> to a
	 * <code>String</code>. This method calls
	 * <code>Double.toString(double)</code> to do its dirty work.
	 * 
	 * @return the <code>String</code> representation
	 * @see #toString(double)
	 */
	public String toString() {
		return toString(value);
	}

	/**
	 * Return the value of this <code>Double</code> as a <code>byte</code>.
	 * 
	 * @return the byte value
	 * @since 1.1
	 */
	public byte byteValue() {
		return (byte) value;
	}

	/**
	 * Return the value of this <code>Double</code> as a <code>short</code>.
	 * 
	 * @return the short value
	 * @since 1.1
	 */
	public short shortValue() {
		return (short) value;
	}

	/**
	 * Return the value of this <code>Double</code> as an <code>int</code>.
	 * 
	 * @return the int value
	 */
	public int intValue() {
		return (int) value;
	}

	/**
	 * Return the value of this <code>Double</code> as a <code>long</code>.
	 * 
	 * @return the long value
	 */
	public long longValue() {
		return (long) value;
	}

	/**
	 * Return the value of this <code>Double</code> as a <code>float</code>.
	 * 
	 * @return the float value
	 */
	public float floatValue() {
		return (float) value;
	}

	/**
	 * Return the value of this <code>Double</code>.
	 * 
	 * @return the double value
	 */
	public double doubleValue() {
		return value;
	}

	/**
	 * Return a hashcode representing this Object. <code>Double</code>'s hash
	 * code is calculated by:<br>
	 * <code>long v = Double.doubleToLongBits(doubleValue());<br>
	 *    int hash = (int)(v^(v&gt;&gt;32))</code>.
	 * 
	 * @return this Object's hash code
	 * @see #doubleToLongBits(double)
	 */
	public int hashCode() {
		long v = doubleToLongBits(value);
		return (int) (v ^ (v >>> 32));
	}

	/**
	 * Returns <code>true</code> if <code>obj</code> is an instance of
	 * <code>Double</code> and represents the same double value. Unlike
	 * comparing two doubles with <code>==</code>, this treats two instances of
	 * <code>Double.NaN</code> as equal, but treats <code>0.0</code> and
	 * <code>-0.0</code> as unequal.
	 * 
	 * <p>
	 * Note that <code>d1.equals(d2)</code> is identical to
	 * <code>doubleToLongBits(d1.doubleValue()) ==
	 *    doubleToLongBits(d2.doubleValue())</code>.
	 * 
	 * @param obj
	 *            the object to compare
	 * @return whether the objects are semantically equal
	 */
	public boolean equals(Object obj) {
		if (obj instanceof Double) {
			double d = ((Double) obj).value;
			return (doubleToRawLongBits(value) == doubleToRawLongBits(d))
					|| (isNaN(value) && isNaN(d));
		}
		return false;
	}

	/**
	 * Convert the double to the IEEE 754 floating-point "double format" bit
	 * layout. Bit 63 (the most significant) is the sign bit, bits 62-52 (masked
	 * by 0x7ff0000000000000L) represent the exponent, and bits 51-0 (masked by
	 * 0x000fffffffffffffL) are the mantissa. This function collapses all
	 * versions of NaN to 0x7ff8000000000000L. The result of this function can
	 * be used as the argument to <code>Double.longBitsToDouble(long)</code> to
	 * obtain the original <code>double</code> value.
	 * 
	 * @param value
	 *            the <code>double</code> to convert
	 * @return the bits of the <code>double</code>
	 * @see #longBitsToDouble(long)
	 */
	public static long doubleToLongBits(double value) {
		if (isNaN(value))
			return 0x7ff8000000000000L;
		else
			return VMNumber.doubleToRawLongBits(value);
	}

	/**
	 * Convert the double to the IEEE 754 floating-point "double format" bit
	 * layout. Bit 63 (the most significant) is the sign bit, bits 62-52 (masked
	 * by 0x7ff0000000000000L) represent the exponent, and bits 51-0 (masked by
	 * 0x000fffffffffffffL) are the mantissa. This function leaves NaN alone,
	 * rather than collapsing to a canonical value. The result of this function
	 * can be used as the argument to <code>Double.longBitsToDouble(long)</code>
	 * to obtain the original <code>double</code> value.
	 * 
	 * @param value
	 *            the <code>double</code> to convert
	 * @return the bits of the <code>double</code>
	 * @see #longBitsToDouble(long)
	 */
	public static long doubleToRawLongBits(double value) {
		return VMNumber.doubleToRawLongBits(value);
	}

	/**
	 * Convert the argument in IEEE 754 floating-point "double format" bit
	 * layout to the corresponding float. Bit 63 (the most significant) is the
	 * sign bit, bits 62-52 (masked by 0x7ff0000000000000L) represent the
	 * exponent, and bits 51-0 (masked by 0x000fffffffffffffL) are the mantissa.
	 * This function leaves NaN alone, so that you can recover the bit pattern
	 * with <code>Double.doubleToRawLongBits(double)</code>.
	 * 
	 * @param bits
	 *            the bits to convert
	 * @return the <code>double</code> represented by the bits
	 * @see #doubleToLongBits(double)
	 * @see #doubleToRawLongBits(double)
	 */
	public static double longBitsToDouble(long bits) {
		return VMNumber.longBitsToDouble(bits);
	}

	/**
	 * Compare two Doubles numerically by comparing their <code>double</code>
	 * values. The result is positive if the first is greater, negative if the
	 * second is greater, and 0 if the two are equal. However, this special
	 * cases NaN and signed zero as follows: NaN is considered greater than all
	 * other doubles, including <code>POSITIVE_INFINITY</code>, and positive
	 * zero is considered greater than negative zero.
	 * 
	 * @param d
	 *            the Double to compare
	 * @return the comparison
	 * @since 1.2
	 */
	public int compareTo(Double d) {
		return compare(value, d.value);
	}

	/**
	 * Behaves like <code>new Double(x).compareTo(new Double(y))</code>; in
	 * other words this compares two doubles, special casing NaN and zero,
	 * without the overhead of objects.
	 * 
	 * @param x
	 *            the first double to compare
	 * @param y
	 *            the second double to compare
	 * @return the comparison
	 * @since 1.4
	 */
	public static int compare(double x, double y) {
		if (x < y)
			return -1;
		if (x > y)
			return 1;

		long lx = doubleToRawLongBits(x);
		long ly = doubleToRawLongBits(y);
		if (lx == ly)
			return 0;

		if (x != x)
			return (y != y) ? 0 : 1;
		else if (y != y)
			return -1;

		return (lx < ly) ? -1 : 1;
	}
}
