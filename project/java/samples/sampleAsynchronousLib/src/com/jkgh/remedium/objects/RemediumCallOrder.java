package com.jkgh.remedium.objects;

import java.util.List;

import com.jkgh.asin.ChannelHandler;
import com.jkgh.remedium.RemediumClient;
import com.jkgh.remedium.helpers.RemediumTransmitContext;
import com.jkgh.remedium.states.ReceiveRemediumObjectState;

public class RemediumCallOrder extends RemediumObject {

	private static final byte[] TYPE_DATA = new byte[] {ReceiveRemediumObjectState.CALL};

	private final int hostID;
	private final int referenceID;
	private final String methodName;
	private final List<RemediumObject> arguments;

	public RemediumCallOrder(int hostID, int referenceID, String methodName, List<RemediumObject> arguments) {
		this.hostID = hostID;
		this.referenceID = referenceID;
		this.methodName = methodName;
		this.arguments = arguments;
	}

	@Override
	public void sendSpecificTo(ChannelHandler channel, RemediumTransmitContext context) {
		channel.write(TYPE_DATA);
		channel.write(RemediumClient.intToByteArray(hostID));
		channel.write(RemediumClient.intToByteArray(referenceID));
		RemediumString.writeStringTo(methodName, channel);
		RemediumList.writeListTo(arguments, channel, context);
	}
}
