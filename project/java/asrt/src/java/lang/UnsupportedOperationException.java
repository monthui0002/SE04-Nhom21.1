package java.lang;

public class UnsupportedOperationException extends RuntimeException {

	public UnsupportedOperationException() {
	}

	public UnsupportedOperationException(String s) {
		super(s);
	}

	public UnsupportedOperationException(String message, Throwable cause) {
		super(message, cause);
	}

	public UnsupportedOperationException(Throwable cause) {
		super(cause);
	}

}
