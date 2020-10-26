package com.jkgh.remedium.states;

import java.nio.ByteBuffer;

import com.jkgh.asin.State;
import com.jkgh.remedium.helpers.RemediumReceiveContext;
import com.jkgh.remedium.objects.RemediumCallObject;
import com.jkgh.remedium.objects.RemediumList;
import com.jkgh.remedium.objects.RemediumString;

public abstract class ReceiveRemediumCallObjectState extends RemediumState {

	public ReceiveRemediumCallObjectState(RemediumReceiveContext context) {
		super(context);
	}

	@Override
	public void bytesRead(ByteBuffer data) {
		final RemediumCallObject ret = new RemediumCallObject();
		machine.setState(new ReceiveIntegerState() {
			
			@Override
			protected State onReceived(final int referenceID) {
				return new ReceiveRemediumStringState() {
					
					@Override
					protected State onReceived(final RemediumString methodName) {
						return new ReceiveRemediumListState(context) {
							
							@Override
							protected State onReceived(final RemediumList arguments) {
								return new ReceiveIntegerState() {
									
									@Override
									protected State onReceived(final int callerHostID) {
										return new ReceiveIntegerState() {
											
											@Override
											protected State onReceived(int callID) {
												ret.init(referenceID, methodName.getValue(), arguments.getValue(), callerHostID, callID);
												return ReceiveRemediumCallObjectState.this.onReceived(ret);
											}
										};
									}
								};
							}
						};
					}
				};
			}
		});
	}

	protected abstract State onReceived(RemediumCallObject call);
}
