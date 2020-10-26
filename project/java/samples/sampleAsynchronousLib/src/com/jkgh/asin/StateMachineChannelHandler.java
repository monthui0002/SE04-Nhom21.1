package com.jkgh.asin;

import java.nio.ByteBuffer;

import com.jkgh.remedium.tools.BlockingChannelHandler;


public abstract class StateMachineChannelHandler extends BlockingChannelHandler {

	private State state;
	
	public StateMachineChannelHandler() {
		setState(startState());
	}
	
	@Override
	public final void bytesRead(ByteBuffer data) {
		while (true) {
			state.bytesRead(data);
			if (!data.hasRemaining() && state.blocksForData()) {
				break;
			}
		}
	}

	public abstract State startState();

	public void setState(State state) {
		this.state = state;
		state.registerMachine(this);
	}
}
