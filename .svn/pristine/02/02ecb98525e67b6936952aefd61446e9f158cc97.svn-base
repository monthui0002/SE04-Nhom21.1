package com.jkgh.remedium.objects;

import com.jkgh.asin.ChannelHandler;
import com.jkgh.remedium.RemediumClient;
import com.jkgh.remedium.helpers.RemediumReturner;
import com.jkgh.remedium.helpers.RemediumTransmitContext;
import com.jkgh.remedium.states.ReceiveRemediumObjectState;

public class RemediumReturnObject extends RemediumOrder {

	private static final byte[] TYPE_DATA = new byte[] {ReceiveRemediumObjectState.RETURN_OBJECT};
	
	private int callID;
	private RemediumObject result;

	public RemediumReturnObject(int callID, RemediumObject result) {
		init(callID, result);
	}

	public void init(int callID, RemediumObject result) {
		this.callID = callID;
		this.result = result;
	}
	
	public RemediumReturnObject() {

	}

	@Override
	public void sendSpecificTo(ChannelHandler channel, RemediumTransmitContext context) {
		channel.write(TYPE_DATA);
		channel.write(RemediumClient.intToByteArray(callID));
		result.sendTo(channel, context);
	}

	@Override
	public void execute(RemediumClient client) {
		RemediumReturner returner = client.retrieveReturner(callID);
		returner.returned(result);
	}

}
