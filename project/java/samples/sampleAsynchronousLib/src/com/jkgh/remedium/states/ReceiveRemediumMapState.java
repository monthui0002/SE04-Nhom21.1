package com.jkgh.remedium.states;

import java.nio.ByteBuffer;

import com.jkgh.asin.State;
import com.jkgh.remedium.helpers.RemediumReceiveContext;
import com.jkgh.remedium.objects.RemediumMap;
import com.jkgh.remedium.objects.RemediumObject;
import com.jkgh.remedium.objects.RemediumString;

public abstract class ReceiveRemediumMapState extends RemediumState {

	public ReceiveRemediumMapState(RemediumReceiveContext context) {
		super(context);
	}

	@Override
	public void bytesRead(ByteBuffer data) {
		machine.setState(new ReceiveIntegerState() {

			@Override
			protected State onReceived(int length) {
				
				final RemediumMap ret = new RemediumMap();
				context.toHistory(ret);
				
				State s = new State() {
					
					@Override
					public void bytesRead(ByteBuffer data) {
						machine.setState(ReceiveRemediumMapState.this.onReceived(ret));
					}
					
					public boolean blocksForData() {
						return false;
					}
				};
				for (int i=0; i<length; ++i) {
					final State fs = s;
					s = new ReceiveRemediumStringState() {

						@Override
						protected State onReceived(final RemediumString fkey) {
							return new ReceiveRemediumObjectState(context) {

								@Override
								protected State onReceived(RemediumObject item) {
									ret.put(fkey.getValue(), item);
									return fs;
								}
								
							};
						}
						
					};
				}
				
				return s;
			}
			
		});
	}

	protected abstract State onReceived(RemediumMap ret);

}
