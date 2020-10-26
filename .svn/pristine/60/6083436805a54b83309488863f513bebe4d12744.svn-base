package com.jkgh.remedium.states;

import java.nio.ByteBuffer;

import com.jkgh.asin.State;

public abstract class ReceiveByteState extends State {

	@Override
	public void bytesRead(ByteBuffer data) {
		State newState = onReceived(data.get());
		machine.setState(newState);
	}

	protected abstract State onReceived(byte b);

}
