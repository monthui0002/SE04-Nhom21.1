package com.jkgh.remedium.objects;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.util.List;

import com.jkgh.remedium.RemediumClient;
import com.jkgh.remedium.helpers.RemediumReceiveContext;
import com.jkgh.remedium.helpers.RemediumTransmitContext;

public class RemediumRunObject extends RemediumOrder {

	private static final byte[] TYPE_DATA = new byte[] {RemediumObject.RUN_OBJECT};

	private final int referenceID;
	private final String methodName;
	private final List<RemediumObject> arguments;

	public RemediumRunObject(int referenceID, String methodName, List<RemediumObject> arguments) {
		this.referenceID = referenceID;
		this.methodName = methodName;
		this.arguments = arguments;
	}

	@Override
	public void sendSpecificTo(DataOutputStream os, RemediumTransmitContext context) throws IOException {
		os.write(TYPE_DATA);
		os.writeInt(referenceID);
		RemediumString.writeStringTo(methodName, os);
		RemediumList.writeListTo(arguments, os, context);
	}

	@Override
	public void execute(RemediumClient client) throws IOException {
		RemediumLocalReference reference = client.getReference(referenceID);
		reference.call(methodName, arguments);
	}

	public static RemediumRunObject receiveRunObject(DataInputStream is, RemediumReceiveContext context) throws IOException {
		int referenceID = is.readInt();
		RemediumString methodName = RemediumString.receiveString(is, context);
		RemediumList arguments = RemediumList.receiveList(is, context);
		return new RemediumRunObject(referenceID, methodName.getValue(), arguments.getValue());
	}

}
