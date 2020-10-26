package com.jkgh.remedium.states;

import java.nio.ByteBuffer;

import com.jkgh.asin.State;
import com.jkgh.remedium.helpers.RemediumReceiveContext;
import com.jkgh.remedium.objects.RemediumObject;
import com.jkgh.remedium.objects.RemediumReturnObject;

public abstract class ReceiveRemediumReturnObjectState extends RemediumState {

	public ReceiveRemediumReturnObjectState(RemediumReceiveContext context) {
		super(context);
	}

	@Override
	public void bytesRead(ByteBuffer data) {
		final RemediumReturnObject ret = new RemediumReturnObject();
		machine.setState(new ReceiveIntegerState() {

			@Override
			protected State onReceived(final int callID) {
				return new ReceiveRemediumObjectState(context) {
					
					@Override
					protected State onReceived(RemediumObject result) {
						ret.init(callID, result);
						return ReceiveRemediumReturnObjectState.this.onReceived(ret);
					}
				};
			}
		});
	}

	protected abstract State onReceived(RemediumReturnObject result);
}
