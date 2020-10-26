package java.lang;

public class VMSystem {

	public native static int identityHashCode(Object object);

	public native static String classNameOf(Object object);

	public native static Object clone(Cloneable cloneable);

	public native static void arraycopy(Object src, int srcOffset, Object dst, int dstOffset, int length);

	public native static long currentTimeMillis();

	public native static void trace(String string);

	public native static String getCurrentMethodName();

}
