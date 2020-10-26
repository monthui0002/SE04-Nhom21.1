package com.jkgh.remedium.objects;

import com.jkgh.asin.ChannelHandler;
import com.jkgh.remedium.RemediumClient;
import com.jkgh.remedium.helpers.RemediumTransmitContext;
import com.jkgh.remedium.states.ReceiveRemediumObjectState;

public abstract class RemediumObject {

	private static final byte[] HISTORY_INDEX = new byte[] {ReceiveRemediumObjectState.HISTORY_INDEX};

	public abstract void sendSpecificTo(ChannelHandler channel, RemediumTransmitContext context);
	
	public final void sendTo(ChannelHandler channel, RemediumTransmitContext context) {
		int historyIndex = context.toHistory(this);
		if (historyIndex != -1) {
			channel.write(HISTORY_INDEX);
			channel.write(RemediumClient.intToByteArray(historyIndex));
		} else {
			sendSpecificTo(channel, context);
		}
	}
}
