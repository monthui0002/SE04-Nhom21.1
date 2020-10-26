package com.jkgh.remedium.states;

import java.nio.ByteBuffer;

import com.jkgh.asin.State;

public abstract class ReceiveIntegerState extends State {

	private static final byte MISSING_4 = 1;
	private static final byte MISSING_3 = 2;
	private static final byte MISSING_2 = 3;
	private static final byte MISSING_1 = 4;
	
	private byte state;
	private int received;
	
	public ReceiveIntegerState() {
		state = MISSING_4;
		received = 0;
	}
	
	@Override
	public void bytesRead(ByteBuffer data) {
		if (state == MISSING_4 && data.remaining() > 3) {
			machine.setState(onReceived(data.getInt()));
		} else {
			byteProcessor: while (data.hasRemaining()) {
				byte read = data.get();
				switch (state) {
				
				case MISSING_4:
					received = read;
					state = MISSING_3;
					continue byteProcessor;
				case MISSING_3:
					received = (received << 8) | (read & 255);
					state = MISSING_2;
					continue byteProcessor;
				case MISSING_2:
					received = (received << 8) | (read & 255);
					state = MISSING_1;
					continue byteProcessor;
				case MISSING_1:
					received = (received << 8) | (read & 255);
					machine.setState(onReceived(received));
					break byteProcessor;
				}
			}
		}
	}

	protected abstract State onReceived(int received);

}
