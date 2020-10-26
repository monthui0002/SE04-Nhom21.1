package com.jkgh.remedium.objects;

import com.jkgh.asin.ChannelHandler;
import com.jkgh.remedium.RemediumClient;
import com.jkgh.remedium.helpers.RemediumTransmitContext;
import com.jkgh.remedium.states.ReceiveRemediumObjectState;

public class RemediumReturnOrder extends RemediumObject {

	private static final byte[] TYPE_DATA = new byte[] {ReceiveRemediumObjectState.RETURN};

	private final int hostID;
	private final int callID;
	private final RemediumObject result;

	public RemediumReturnOrder(int hostID, int callID, RemediumObject result) {
		this.hostID = hostID;
		this.callID = callID;
		this.result = result;
	}

	@Override
	public void sendSpecificTo(ChannelHandler channel, RemediumTransmitContext context) {
		channel.write(TYPE_DATA);
		channel.write(RemediumClient.intToByteArray(hostID));
		channel.write(RemediumClient.intToByteArray(callID));
		result.sendTo(channel, context);
	}
}
