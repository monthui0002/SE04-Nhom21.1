package com.jkgh.remedium.states;

import java.nio.ByteBuffer;

import com.jkgh.asin.State;

public abstract class ReceiveRemediumReferenceState extends State {

	@Override
	public void bytesRead(ByteBuffer data) {
		machine.setState(new ReceiveIntegerState() {
			
			@Override
			protected State onReceived(final int host) {
				return new ReceiveIntegerState() {
					
					@Override
					protected State onReceived(int referenceID) {
						return ReceiveRemediumReferenceState.this.onReceived(host, referenceID);
					};
				};
			}
		});
	}

	protected abstract State onReceived(int host, int referenceID);

}
