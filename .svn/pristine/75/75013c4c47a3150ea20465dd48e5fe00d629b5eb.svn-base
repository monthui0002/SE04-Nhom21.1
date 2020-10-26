package com.jkgh.remedium.objects;

import java.util.List;

import com.jkgh.asin.ChannelHandler;
import com.jkgh.remedium.RemediumClient;
import com.jkgh.remedium.helpers.RemediumTransmitContext;
import com.jkgh.remedium.states.ReceiveRemediumObjectState;

public class RemediumRunObject extends RemediumOrder {

	private static final byte[] TYPE_DATA = new byte[] {ReceiveRemediumObjectState.RUN_OBJECT};

	private int referenceID;
	private String methodName;
	private List<RemediumObject> arguments;

	public RemediumRunObject(int referenceID, String methodName, List<RemediumObject> arguments) {
		init(referenceID, methodName, arguments);
	}
	
	public RemediumRunObject() {

	}

	public void init(int referenceID, String methodName, List<RemediumObject> arguments) {
		this.referenceID = referenceID;
		this.methodName = methodName;
		this.arguments = arguments;
	}

	@Override
	public void sendSpecificTo(ChannelHandler channel, RemediumTransmitContext context) {
		channel.write(TYPE_DATA);
		channel.write(RemediumClient.intToByteArray(referenceID));
		RemediumString.writeStringTo(methodName, channel);
		RemediumList.writeListTo(arguments, channel, context);
	}

	@Override
	public void execute(RemediumClient client) {
		RemediumLocalReference reference = client.getReference(referenceID);
		reference.call(methodName, arguments, null);
	}

}
