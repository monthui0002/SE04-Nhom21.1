package java.lang;

public class Throwable {

	private final String detailMessage;
	private Throwable cause = this;

	public Throwable() {
		this((String) null);
	}

	public Throwable(String message) {
		detailMessage = message;
	}

	public Throwable(String message, Throwable cause) {
		this(message);
		this.cause = cause;
	}

	public Throwable(Throwable cause) {
		this(cause == null ? null : cause.toString(), cause);
	}

	public String getMessage() {
		return detailMessage;
	}

	public String getLocalizedMessage() {
		return getMessage();
	}

	public Throwable getCause() {
		return cause == this ? null : cause;
	}

	public Throwable initCause(Throwable cause) {
		this.cause = cause;
		return this;
	}

	public String toString() {
		String msg = getLocalizedMessage();
		return VMSystem.classNameOf(this) + (msg == null ? "" : ": " + msg);
	}

}
