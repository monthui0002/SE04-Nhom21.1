package com.jkgh.remedium.objects;

import java.util.List;

import com.jkgh.asin.ChannelHandler;
import com.jkgh.remedium.RemediumClient;
import com.jkgh.remedium.helpers.RemediumRedirectingReturner;
import com.jkgh.remedium.helpers.RemediumTransmitContext;
import com.jkgh.remedium.states.ReceiveRemediumObjectState;

public class RemediumCallObject extends RemediumOrder {

	private static final byte[] TYPE_DATA = new byte[] {ReceiveRemediumObjectState.CALL_OBJECT};

	private int referenceID;
	private String methodName;
	private List<RemediumObject> arguments;
	private int callerHostID;
	private int callID;

	public RemediumCallObject(int referenceID, String methodName, List<RemediumObject> arguments, int callerHostID, int callID) {
		init(referenceID, methodName, arguments, callerHostID, callID);
	}
	
	public RemediumCallObject() {
		
	}
	
	public void init(int referenceID, String methodName, List<RemediumObject> arguments, int callerHostID, int callID) {
		this.referenceID = referenceID;
		this.methodName = methodName;
		this.arguments = arguments;
		this.callerHostID = callerHostID;
		this.callID = callID;
	}

	@Override
	public void sendSpecificTo(ChannelHandler channel, RemediumTransmitContext context) {
		channel.write(TYPE_DATA);
		channel.write(RemediumClient.intToByteArray(referenceID));
		RemediumString.writeStringTo(methodName, channel);
		RemediumList.writeListTo(arguments, channel, context);
		channel.write(RemediumClient.intToByteArray(callerHostID));
		channel.write(RemediumClient.intToByteArray(callID));
	}

	@Override
	public void execute(RemediumClient client) {
		RemediumLocalReference reference = client.getReference(referenceID);
		reference.call(methodName, arguments, new RemediumRedirectingReturner(client, callerHostID, callID));
	}

}
