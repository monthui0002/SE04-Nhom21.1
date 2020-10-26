package java.nio.charset;

import java.nio.ByteBuffer;
import java.nio.CharBuffer;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

/**
 * @author Jesse Rosenstock
 * @since 1.4
 * @status updated to 1.5
 */
public abstract class Charset implements Comparable<Charset> {
	private CharsetEncoder cachedEncoder;
	private CharsetDecoder cachedDecoder;

	private final String canonicalName;
	private final String[] aliases;

	protected Charset(String canonicalName, String[] aliases) {
		checkName(canonicalName);
		if (aliases != null) {
			int n = aliases.length;
			for (int i = 0; i < n; ++i)
				checkName(aliases[i]);
		}

		cachedEncoder = null;
		cachedDecoder = null;
		this.canonicalName = canonicalName;
		this.aliases = aliases;
	}

	/**
	 * @throws IllegalCharsetNameException
	 *             if the name is illegal
	 */
	private static void checkName(String name) {
		int n = name.length();

		if (n == 0)
			throw new IllegalCharsetNameException(name);

		char ch = name.charAt(0);
		if (!(('A' <= ch && ch <= 'Z') || ('a' <= ch && ch <= 'z') || ('0' <= ch && ch <= '9')))
			throw new IllegalCharsetNameException(name);

		for (int i = 1; i < n; ++i) {
			ch = name.charAt(i);
			if (!(('A' <= ch && ch <= 'Z') || ('a' <= ch && ch <= 'z')
					|| ('0' <= ch && ch <= '9') || ch == '-' || ch == '.'
					|| ch == ':' || ch == '_'))
				throw new IllegalCharsetNameException(name);
		}
	}

	/**
	 * Returns the system default charset.
	 * 
	 * This may be set by the user or VM with the file.encoding property.
	 * 
	 * @since 1.5
	 */
	public static Charset defaultCharset() {
		return new Windows1250();
	}

	public final String name() {
		return canonicalName;
	}

	public final Set<String> aliases() {
		if (aliases == null)
			return Collections.<String> emptySet();

		// should we cache the aliasSet instead?
		int n = aliases.length;
		HashSet<String> aliasSet = new HashSet<String>(n);
		for (int i = 0; i < n; ++i)
			aliasSet.add(aliases[i]);
		return Collections.unmodifiableSet(aliasSet);
	}

	public String displayName() {
		return canonicalName;
	}

	public final boolean isRegistered() {
		return (!canonicalName.startsWith("x-") && !canonicalName
				.startsWith("X-"));
	}

	public abstract boolean contains(Charset cs);

	public abstract CharsetDecoder newDecoder();

	public abstract CharsetEncoder newEncoder();

	public boolean canEncode() {
		return true;
	}

	// NB: This implementation serializes different threads calling
	// Charset.encode(), a potential performance problem. It might
	// be better to remove the cache, or use ThreadLocal to cache on
	// a per-thread basis.
	public final synchronized ByteBuffer encode(CharBuffer cb) {
		try {
			if (cachedEncoder == null) {
				cachedEncoder = newEncoder().onMalformedInput(
						CodingErrorAction.REPLACE).onUnmappableCharacter(
						CodingErrorAction.REPLACE);
			} else
				cachedEncoder.reset();
			return cachedEncoder.encode(cb);
		} catch (CharacterCodingException e) {
			throw new AssertionError(e);
		}
	}

	public final ByteBuffer encode(String str) {
		return encode(CharBuffer.wrap(str));
	}

	// NB: This implementation serializes different threads calling
	// Charset.decode(), a potential performance problem. It might
	// be better to remove the cache, or use ThreadLocal to cache on
	// a per-thread basis.
	public final synchronized CharBuffer decode(ByteBuffer bb) {
		try {
			if (cachedDecoder == null) {
				cachedDecoder = newDecoder().onMalformedInput(
						CodingErrorAction.REPLACE).onUnmappableCharacter(
						CodingErrorAction.REPLACE);
			} else
				cachedDecoder.reset();

			return cachedDecoder.decode(bb);
		} catch (CharacterCodingException e) {
			throw new AssertionError(e);
		}
	}

	public final int compareTo(Charset other) {
		return canonicalName.compareToIgnoreCase(other.canonicalName);
	}

	public final int hashCode() {
		return canonicalName.hashCode();
	}

	public final boolean equals(Object ob) {
		if (ob instanceof Charset)
			return canonicalName.equalsIgnoreCase(((Charset) ob).canonicalName);
		else
			return false;
	}

	public final String toString() {
		return canonicalName;
	}
}
