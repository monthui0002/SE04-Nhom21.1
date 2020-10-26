package com.jkgh.remedium.objects;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.util.List;

import com.jkgh.remedium.helpers.RemediumReceiveContext;
import com.jkgh.remedium.helpers.RemediumTransmitContext;

public abstract class RemediumReference extends RemediumObject {

	private static final byte[] TYPE_DATA = new byte[] {RemediumObject.REFERENCE};

	protected final int referenceID;
	protected final int hostID;

	public RemediumReference(int hostID, int referenceID) {
		this.hostID = hostID;
		this.referenceID = referenceID;
	}

	@Override
	public void sendSpecificTo(DataOutputStream os, RemediumTransmitContext context) throws IOException {
		os.write(TYPE_DATA);
		os.writeInt(hostID);
		os.writeInt(referenceID);
	}

	public abstract RemediumObject call(String methodName, List<RemediumObject> arguments) throws IOException;

	public static RemediumReference receiveReference(DataInputStream is, RemediumReceiveContext context) throws IOException {
		int hostID = is.readInt();
		int referenceID = is.readInt();
		return context.getClient().getReference(hostID, referenceID);
	}

}
