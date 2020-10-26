package com.jkgh.remedium.objects;

import com.jkgh.asin.ChannelHandler;
import com.jkgh.remedium.RemediumClient;
import com.jkgh.remedium.helpers.RemediumTransmitContext;
import com.jkgh.remedium.states.ReceiveRemediumObjectState;

public class RemediumInitialData extends RemediumObject {

	private static final byte[] TYPE_DATA = new byte[] {ReceiveRemediumObjectState.INITIAL_DATA};

	private int hostID;
	private RemediumObject mainObject;

	public RemediumInitialData(int hostID, RemediumObject mainObject) {
		init(hostID, mainObject);
	}

	public void init(int hostID, RemediumObject mainObject) {
		this.hostID = hostID;
		this.mainObject = mainObject;
	}

	public RemediumInitialData() {

	}

	public int getHostID() {
		return hostID;
	}

	public RemediumObject getMainObject() {
		return mainObject;
	}

	@Override
	public void sendSpecificTo(ChannelHandler channel, RemediumTransmitContext context) {
		channel.write(TYPE_DATA);
		channel.write(RemediumClient.intToByteArray(hostID));
		mainObject.sendTo(channel, context);
	}

}
