package com.jkgh.asin;

import java.nio.ByteBuffer;

public abstract class State {

	public static final State IGNORE_REST = new State() {
		
		@Override
		public void bytesRead(ByteBuffer data) {
			data.position(data.limit());
		}
	};
	
	protected StateMachineChannelHandler machine;

	public final void registerMachine(StateMachineChannelHandler machine) {
		this.machine = machine;
	}
	
	public abstract void bytesRead(ByteBuffer data);

	public boolean blocksForData() {
		return true;
	}

}
