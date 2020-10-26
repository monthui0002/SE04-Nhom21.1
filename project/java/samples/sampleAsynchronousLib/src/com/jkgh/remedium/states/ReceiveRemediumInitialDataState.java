package com.jkgh.remedium.states;

import java.nio.ByteBuffer;

import com.jkgh.asin.State;
import com.jkgh.remedium.helpers.RemediumReceiveContext;
import com.jkgh.remedium.objects.RemediumInitialData;
import com.jkgh.remedium.objects.RemediumObject;

public abstract class ReceiveRemediumInitialDataState extends RemediumState {

	public ReceiveRemediumInitialDataState(RemediumReceiveContext context) {
		super(context);
	}

	@Override
	public void bytesRead(ByteBuffer data) {
		final RemediumInitialData ret = new RemediumInitialData();
		machine.setState(new ReceiveIntegerState() {
			
			@Override
			protected State onReceived(final int hostID) {
				return new ReceiveRemediumObjectState(context) {
					
					@Override
					protected State onReceived(final RemediumObject mainObject) {
						ret.init(hostID, mainObject);
						return ReceiveRemediumInitialDataState.this.onReceived(ret);
					}
				};
			}
		});
	}

	protected abstract State onReceived(RemediumInitialData data);
}
