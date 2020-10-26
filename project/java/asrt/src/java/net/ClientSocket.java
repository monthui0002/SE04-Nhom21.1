package java.net;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

public class ClientSocket {

	private final String host;
	private final int port;
	
	private InputStream inputStream;
	private OutputStream outputStream;
	
	private int handle;

	public ClientSocket(String host, int port) throws ConnectException {
		this.host = host;
		this.port = port;
		
		connect();
	}

	private void connect() throws ConnectException {
		int code = VMSocket.connect(host, port);
				
		if (code == -1) {
			VMSystem.trace("throwing permission error");
			throw new ConnectException("No permission to connect to host "+host+" on port "+port+".");
		} else if (code == -2) {
			VMSystem.trace("throwing network error");
			throw new ConnectException("Could not connect to host "+host+" on port "+port+".");
		}
				
		this.handle = code;
		
		this.inputStream = new InputStream() {

			synchronized public int read() throws IOException {
				int code = VMSocket.read(handle);
				if (code == -2) {
					closeAll();
					throw new IOException("Could not read from a socket.");
				}
				return code;
			}
			
			@Override
			synchronized public int read(byte[] b, int off, int len) throws IOException {
			    if (off < 0 || len < 0 || b.length - off < len) {
			        throw new IndexOutOfBoundsException();
			    }
			    if (len == 0) {
			    	return 0;
			    }
			    
				int code = VMSocket.fillAvailable(handle, b, off, len);
				if (code == -2) {
					closeAll();
					throw new IOException("Could not read from a socket.");
				}
				if (code == 0) {
					code = read();
					if (code != -1) {
						b[off] = (byte) code;
						return 1;
					}
				}
				return code;
			}
			
		};
		this.outputStream = new OutputStream() {
			
			synchronized public void write(int b) throws IOException {
				int code = VMSocket.write(handle, b);
				if (code == -2) {
					closeAll();
					throw new IOException("Could not write to a socket.");
				}
			}
			
			synchronized public void flush() throws IOException {
				int code = VMSocket.flush(handle);
				if (code == -2) {
					closeAll();
					throw new IOException("Could not flush a socket.");
				}
			}
		};
	}

	private void closeAll() {
		if (handle > 0) {
			VMSocket.close(handle);
			this.handle = 0;
			this.inputStream = null;
			this.outputStream = null;
		}
	}

	synchronized public void close() {
		closeAll();
	}
	
	public InputStream getInputStream() {
		return inputStream;
	}

	public OutputStream getOutputStream() {
		return outputStream;
	}

	public String getHost() {
		return host;
	}

	public int getPort() {
		return port;
	}
}
