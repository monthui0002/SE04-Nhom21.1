package com.jkgh.remedium.objects;

import java.io.DataOutputStream;
import java.io.IOException;
import java.util.List;

import com.jkgh.remedium.helpers.RemediumTransmitContext;

public class RemediumCallOrder extends RemediumObject {

	private static final byte[] TYPE_DATA = new byte[] {RemediumObject.CALL};

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
	public void sendSpecificTo(DataOutputStream os, RemediumTransmitContext context) throws IOException {
		os.write(TYPE_DATA);
		os.writeInt(hostID);
		os.writeInt(referenceID);
		RemediumString.writeStringTo(methodName, os);
		RemediumList.writeListTo(arguments, os, context);
	}
}
