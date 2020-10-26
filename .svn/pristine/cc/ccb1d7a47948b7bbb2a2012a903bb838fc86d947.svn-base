package com.jkgh.remedium.states;

import java.nio.ByteBuffer;

import com.jkgh.asin.State;
import com.jkgh.remedium.helpers.RemediumReceiveContext;
import com.jkgh.remedium.objects.RemediumList;
import com.jkgh.remedium.objects.RemediumObject;

public abstract class ReceiveRemediumListState extends RemediumState {

	public ReceiveRemediumListState(RemediumReceiveContext context) {
		super(context);
	}

	@Override
	public void bytesRead(ByteBuffer data) {
		machine.setState(new ReceiveIntegerState() {

			@Override
			protected State onReceived(int length) {
				
				final RemediumList ret = new RemediumList(length);
				context.toHistory(ret);
				
				State s = new State() {
					
					@Override
					public void bytesRead(ByteBuffer data) {
						machine.setState(ReceiveRemediumListState.this.onReceived(ret));
					}
					
					public boolean blocksForData() {
						return false;
					}
				};
				for (int i=0; i<length; ++i) {
					final State fs = s;
					s = new ReceiveRemediumObjectState(context) {

						@Override
						protected State onReceived(RemediumObject item) {
							ret.add(item);
							return fs;
						}
						
					};
				}
				
				return s;
			}
			
		});
	}

	protected abstract State onReceived(RemediumList list);
}
