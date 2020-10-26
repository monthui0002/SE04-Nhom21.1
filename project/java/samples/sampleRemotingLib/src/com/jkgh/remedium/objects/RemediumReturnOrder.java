package com.jkgh.remedium.objects;

import java.io.DataOutputStream;
import java.io.IOException;

import com.jkgh.remedium.helpers.RemediumTransmitContext;

public class RemediumReturnOrder extends RemediumObject {

	private static final byte[] TYPE_DATA = new byte[] {RemediumObject.RETURN};

	private final int hostID;
	private final int callID;
	private final RemediumObject result;

	public RemediumReturnOrder(int hostID, int callID, RemediumObject result) {
		this.hostID = hostID;
		this.callID = callID;
		this.result = result;
	}

	@Override
	public void sendSpecificTo(DataOutputStream os, RemediumTransmitContext context) throws IOException {
		os.write(TYPE_DATA);
		os.writeInt(hostID);
		os.writeInt(callID);
		result.sendTo(os, context);
	}
}
