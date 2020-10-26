package java.concurrent;

public class Lock {

	private static int idGenerator = 0;
	
	private final int id;

	public Lock() {
		this.id = nextID();
	}
	
	private static int nextID() {
		return ++idGenerator;
	}

	public void lock() {
		VMLock.lock(id);
	}

	public void unlock() {
		if (VMLock.unlock(id) != 0) {
			throw new IllegalStateException("The thread invoking Lock.unlock() was not the locker of this lock.");
		}
	}

}
