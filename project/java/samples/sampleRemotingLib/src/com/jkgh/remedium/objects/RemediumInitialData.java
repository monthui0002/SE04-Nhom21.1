package com.jkgh.remedium.objects;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;

import com.jkgh.remedium.helpers.RemediumReceiveContext;
import com.jkgh.remedium.helpers.RemediumTransmitContext;

public class RemediumInitialData extends RemediumObject {

	private static final byte[] TYPE_DATA = new byte[] {RemediumObject.INITIAL_DATA};

	private final int hostID;
	private final RemediumObject mainObject;

	public RemediumInitialData(int hostID, RemediumObject mainObject) {
		this.hostID = hostID;
		this.mainObject = mainObject;
	}

	public int getHostID() {
		return hostID;
	}

	public RemediumObject getMainObject() {
		return mainObject;
	}

	@Override
	public void sendSpecificTo(DataOutputStream os, RemediumTransmitContext context) throws IOException {
		os.write(TYPE_DATA);
		os.writeInt(hostID);
		mainObject.sendTo(os, context);
	}

	public static RemediumInitialData receiveInitialData(DataInputStream is, RemediumReceiveContext context) throws IOException {
		int hostID = is.readInt();
		RemediumObject mainObject = RemediumObject.receiveObject(is, context);
		return new RemediumInitialData(hostID, mainObject);
	}

}
