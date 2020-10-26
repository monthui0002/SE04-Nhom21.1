package java.lang;


public abstract class Enum<T extends Enum<T>> implements Comparable<T> {

	final String name;
	final int ordinal;

	protected Enum(String name, int ordinal) {
		this.name = name;
		this.ordinal = ordinal;
	}

	public final int hashCode() {
		return ordinal;
	}

	public String toString() {
		return name;
	}

	public final int compareTo(T e) {
		return ordinal - e.ordinal;
	}

	protected final Object clone() throws CloneNotSupportedException {
		throw new CloneNotSupportedException("Cannot clone an enum constant");
	}

	public final String name() {
		return name;
	}

	public final int ordinal() {
		return ordinal;
	}
}
