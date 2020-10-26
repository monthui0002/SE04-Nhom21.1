package java.lang;

public class VMThread {

	public native static Thread currentThread();
	public native static void start(Thread thread);
	public native static void sleep(long millis);

}
