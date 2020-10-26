package java.net;

public class VMSocket {

	public native static int connect(String host, int port);
	public native static int read(int handle);
	public native static int write(int handle, int b);
	public native static int flush(int handle);
	public native static void close(int handle);
	public native static int fillAvailable(int handle, byte[] b, int off, int len);

}
