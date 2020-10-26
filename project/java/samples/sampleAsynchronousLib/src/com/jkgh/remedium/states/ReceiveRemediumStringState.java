package com.jkgh.remedium.states;

import java.nio.ByteBuffer;

import com.jkgh.asin.State;
import com.jkgh.remedium.objects.RemediumString;

public abstract class ReceiveRemediumStringState extends State {

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
								machine.setState(ReceiveRemediumStringState.this.onReceived(new RemediumString(new String(ret, RemediumString.UTF8))));
							}
						}
					};
				} else {
					return ReceiveRemediumStringState.this.onReceived(new RemediumString());
				}
			}
		});
	}

	protected abstract State onReceived(RemediumString ret);

}
