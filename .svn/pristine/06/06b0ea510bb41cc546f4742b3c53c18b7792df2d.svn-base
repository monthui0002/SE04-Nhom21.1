package java.lang;

public class Thread implements Runnable {

	/** The minimum priority for a Thread. */
	public static final int MIN_PRIORITY = 1;

	/** The priority a Thread gets by default. */
	public static final int NORM_PRIORITY = 5;

	/** The maximum priority for a Thread. */
	public static final int MAX_PRIORITY = 10;

	/** The object to run(), null if this is the target. */
	final Runnable runnable;

	/** The thread name, non-null. */
	volatile String name;

	/** Whether the thread is a daemon. */
	volatile boolean daemon;

	/** The thread priority, 1 to 10. */
	volatile int priority;

	/** The next thread number to use. */
	private static int numAnonymousThreadsCreated;

	public Thread() {
		this((Runnable) null);
	}

	public Thread(Runnable target) {
		this(target, createAnonymousThreadName());
	}

	public Thread(String name) {
		this(null, name);
	}

	public Thread(Runnable target, String name) {

		this.name = name.toString();
		this.runnable = target;
		this.priority = NORM_PRIORITY;
		this.daemon = false;
	}

	/**
	 * Generate a name for an anonymous thread.
	 */
	private static synchronized String createAnonymousThreadName() {
		return "Thread-" + ++numAnonymousThreadsCreated;
	}

	public static Thread currentThread() {
		return VMThread.currentThread();
	}

	public final String getName() {
		return name;
	}

	public final synchronized int getPriority() {
		return priority;
	}

	public final boolean isDaemon() {
		return daemon;
	}

	public void run() {
		if (runnable != null) {
			runnable.run();
		}
	}

	public final synchronized void setDaemon(boolean daemon) {
		this.daemon = daemon;
	}

	public synchronized void start() {
		if (priority < MIN_PRIORITY) {
			throw new IllegalThreadStateException("Thread has already died");
		}
		
		VMThread.start(this);
	}

	public final synchronized void setPriority(int priority) {
		if (priority < MIN_PRIORITY || priority > MAX_PRIORITY) {
			throw new IllegalArgumentException("Invalid thread priority value "
					+ priority + ".");
		}
		this.priority = priority;
	}

	public static void sleep(long millis) {
		VMThread.sleep(millis);
	}
	
	public String toString() {
		return "Thread[" + name + ", " + priority + ", "+daemon+"]";
	}

}
