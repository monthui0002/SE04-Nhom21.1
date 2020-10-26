package com.jkgh.remedium.objects;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;

import com.jkgh.remedium.RemediumClient;
import com.jkgh.remedium.helpers.RemediumReceiveContext;
import com.jkgh.remedium.helpers.RemediumTransmitContext;

public class RemediumReturnObject extends RemediumOrder {

	private static final byte[] TYPE_DATA = new byte[] {RemediumObject.RETURN_OBJECT};
	
	private final int callID;
	private final RemediumObject result;

	public RemediumReturnObject(int callID, RemediumObject result) {
		this.callID = callID;
		this.result = result;
	}

	@Override
	public void sendSpecificTo(DataOutputStream os, RemediumTransmitContext context) throws IOException {
		os.write(TYPE_DATA);
		os.writeInt(callID);
		result.sendTo(os, context);
	}

	@Override
	public void execute(RemediumClient client) throws IOException {
		client.fireReturner(callID, result);
	}

	public static RemediumReturnObject receiveReturnObject(DataInputStream is, RemediumReceiveContext context) throws IOException {
		int callID = is.readInt();
		RemediumObject result = RemediumObject.receiveObject(is, context);
		return new RemediumReturnObject(callID, result);
	}

}
