package com.jkgh.remedium.objects;

import com.jkgh.asin.ChannelHandler;
import com.jkgh.remedium.RemediumClient;
import com.jkgh.remedium.helpers.RemediumTransmitContext;
import com.jkgh.remedium.states.ReceiveRemediumObjectState;

public class RemediumDouble extends RemediumObject {

	private static final byte[] TYPE_DATA = new byte[] {ReceiveRemediumObjectState.DOUBLE};

	private double value;

	public RemediumDouble(double value) {
		this.setValue(value);
	}

	public double getValue() {
		return value;
	}

	public void setValue(double value) {
		this.value = value;
	}

	@Override
	public void sendSpecificTo(ChannelHandler channel, RemediumTransmitContext context) {
		channel.write(TYPE_DATA);
		channel.write(RemediumClient.doubleToByteArray(value));
	}

}
