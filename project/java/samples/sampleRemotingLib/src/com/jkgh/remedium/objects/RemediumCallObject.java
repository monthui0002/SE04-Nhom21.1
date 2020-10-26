package com.jkgh.remedium.objects;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.util.List;

import com.jkgh.remedium.RemediumClient;
import com.jkgh.remedium.helpers.RemediumReceiveContext;
import com.jkgh.remedium.helpers.RemediumTransmitContext;

public class RemediumCallObject extends RemediumOrder {

	private static final byte[] TYPE_DATA = new byte[] {RemediumObject.CALL_OBJECT};

	private final int referenceID;
	private final String methodName;
	private final List<RemediumObject> arguments;
	private final int callerHostID;
	private final int callID;

	public RemediumCallObject(int referenceID, String methodName, List<RemediumObject> arguments, int callerHostID, int callID) {
		this.referenceID = referenceID;
		this.methodName = methodName;
		this.arguments = arguments;
		this.callerHostID = callerHostID;
		this.callID = callID;
	}

	@Override
	public void sendSpecificTo(DataOutputStream os, RemediumTransmitContext context) throws IOException {
		os.write(TYPE_DATA);
		os.writeInt(referenceID);
		RemediumString.writeStringTo(methodName, os);
		RemediumList.writeListTo(arguments, os, context);
		os.writeInt(callerHostID);
		os.writeInt(callID);
	}

	@Override
	public void execute(RemediumClient client) throws IOException {
		RemediumLocalReference reference = client.getReference(referenceID);
		RemediumObject ret = reference.call(methodName, arguments);
		RemediumReturnOrder returnObject = new RemediumReturnOrder(callerHostID, callID, ret);
		client.lockOutput();
		returnObject.sendTo(client.getOutputStream(), new RemediumTransmitContext(client));
		client.getOutputStream().flush();
		client.unlockOutput();
	}

	public static RemediumCallObject receiveCallObject(DataInputStream is, RemediumReceiveContext context) throws IOException {
		int referenceID = is.readInt();
		RemediumString methodName = RemediumString.receiveString(is, context);
		RemediumList arguments = RemediumList.receiveList(is, context);
		int callerHostID = is.readInt();
		int callID = is.readInt();
		return new RemediumCallObject(referenceID, methodName.getValue(), arguments.getValue(), callerHostID, callID);
	}

}
