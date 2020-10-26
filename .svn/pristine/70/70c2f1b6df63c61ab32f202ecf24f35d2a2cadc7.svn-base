package com.jkgh.remedium.states;

import java.nio.ByteBuffer;

import com.jkgh.asin.State;
import com.jkgh.remedium.helpers.RemediumReceiveContext;
import com.jkgh.remedium.objects.RemediumBlob;

public abstract class ReceiveRemediumBlobState extends RemediumState {

	public ReceiveRemediumBlobState(RemediumReceiveContext context) {
		super(context);
	}

	@Override
	public void bytesRead(ByteBuffer data) {
		machine.setState(new ReceiveIntegerState() {
			
			@Override
			protected State onReceived(final int length) {
				if (length > 0) {
					final byte[] ret = new byte[length];
					return new State() {
						
						private int i = 0;
						
						@Override
						public void bytesRead(ByteBuffer data) {
							int take = Math.min(data.remaining(), length-i);
							data.get(ret, i, take);
							i += take;
							if (i == length) {
								machine.setState(ReceiveRemediumBlobState.this.onReceived(new RemediumBlob(ret)));
							}
						}
					};
				} else {
					return ReceiveRemediumBlobState.this.onReceived(new RemediumBlob());
				}
			}
		});
	}

	protected abstract State onReceived(RemediumBlob blob);
}
