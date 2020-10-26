package com.jkgh.remedium.states;

import java.nio.ByteBuffer;

import com.jkgh.asin.State;
import com.jkgh.remedium.helpers.RemediumReceiveContext;
import com.jkgh.remedium.objects.RemediumList;
import com.jkgh.remedium.objects.RemediumRunObject;
import com.jkgh.remedium.objects.RemediumString;

public abstract class ReceiveRemediumRunObjectState extends RemediumState {

	public ReceiveRemediumRunObjectState(RemediumReceiveContext context) {
		super(context);
	}

	@Override
	public void bytesRead(ByteBuffer data) {
		final RemediumRunObject ret = new RemediumRunObject();
		machine.setState(new ReceiveIntegerState() {
			
			@Override
			protected State onReceived(final int referenceID) {
				return new ReceiveRemediumStringState() {
					
					@Override
					protected State onReceived(final RemediumString methodName) {
						return new ReceiveRemediumListState(context) {
							
							@Override
							protected State onReceived(RemediumList arguments) {
								ret.init(referenceID, methodName.getValue(), arguments.getValue());
								return ReceiveRemediumRunObjectState.this.onReceived(ret);
							}
						};
					}
				};
			}
		});
	}

	protected abstract State onReceived(RemediumRunObject call);
}
