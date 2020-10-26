package java.lang;

public class VMSemaphore {

	public native static void open(int id);
	public native static void close(int id);
	public native static void pass(int id);

}
