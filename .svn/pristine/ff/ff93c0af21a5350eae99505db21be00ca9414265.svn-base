package java.lang;

public class Object {
	
	public boolean equals(Object obj) {
		return this == obj;
	}

	public int hashCode() {
		return System.identityHashCode(this);
	}

	public String toString() {
		return getClassName() + '@' + hashCode();
	}

	protected Object clone() throws CloneNotSupportedException {
		if (this instanceof Cloneable) {
			return VMSystem.clone((Cloneable) this);
		}
		throw new CloneNotSupportedException("Object not cloneable");
	}

	public String getClassName() {
		return VMSystem.classNameOf(this);
	}
}
