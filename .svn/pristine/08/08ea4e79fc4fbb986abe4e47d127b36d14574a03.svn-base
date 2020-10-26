package com.jkgh.remedium.objects;

import java.util.List;

import com.jkgh.asin.ChannelHandler;
import com.jkgh.remedium.RemediumClient;
import com.jkgh.remedium.helpers.RemediumReturner;
import com.jkgh.remedium.helpers.RemediumTransmitContext;
import com.jkgh.remedium.states.ReceiveRemediumObjectState;

public abstract class RemediumReference extends RemediumObject {

	private static final byte[] TYPE_DATA = new byte[] {ReceiveRemediumObjectState.REFERENCE};

	protected final int referenceID;
	protected final int hostID;

	public RemediumReference(int hostID, int referenceID) {
		this.hostID = hostID;
		this.referenceID = referenceID;
	}

	@Override
	public void sendSpecificTo(ChannelHandler channel, RemediumTransmitContext context) {
		channel.write(TYPE_DATA);
		channel.write(RemediumClient.intToByteArray(hostID));
		channel.write(RemediumClient.intToByteArray(referenceID));
	}

	public abstract void call(String methodName, List<RemediumObject> arguments, RemediumReturner returner);

}
