package com.jkgh.remedium.tools;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.ClientSocket;
import java.nio.ByteBuffer;

public class SocketThread extends Thread {

	private final ClientSocket socket;
	private final InputStream is;
	private final OutputStream os;
	private final byte[] buffer;
	private final BlockingChannelHandler handler;

	public SocketThread(String host, int port, BlockingChannelHandler handler) throws IOException {
		this.handler = handler;
		this.socket = new ClientSocket(host, port);
		this.os = socket.getOutputStream();
		this.is = socket.getInputStream();
		this.buffer = new byte[1024];
		handler.registerSocketThread(this);
	}

	@Override
	public void run() {
		while (true) {
			try {
				int read = is.read(buffer);
				//System.out.println("- "+read+" b");
				ByteBuffer wrapped = ByteBuffer.wrap(buffer, 0, read);
				handler.bytesRead(wrapped);
			} catch (Exception e) {
				handler.disconnected();
				break;
			}
		}
	}

	public void disconnect() {
		try {
			is.close();
			os.close();
			socket.close();
		} catch (IOException e) {
		}
	}

	public void write(byte[] data) {
		try {
			//System.out.println("% "+data.length+" b = "+Arrays.toString(data));
			os.write(data);
			os.flush();
		} catch (IOException e) {
		}
	}
}
