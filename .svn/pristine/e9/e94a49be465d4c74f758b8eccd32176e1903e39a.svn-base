package java.concurrent;

public class Semaphore {

	private static int idGenerator = 0;
	
	private final int id;

	public Semaphore() {
		this.id = nextID();
	}
	
	private static int nextID() {
		return ++idGenerator;
	}

	public void open() {
		VMSemaphore.open(id);
	}

	public void pass() {
		VMSemaphore.pass(id);
	}
	
	public void close() {
		VMSemaphore.close(id);
	}

}
