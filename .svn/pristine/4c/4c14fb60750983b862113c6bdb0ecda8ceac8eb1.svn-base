package com.jkgh.remedium.objects;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;

import com.jkgh.remedium.helpers.RemediumReceiveContext;
import com.jkgh.remedium.helpers.RemediumTransmitContext;

public class RemediumDouble extends RemediumObject {

	private static final byte[] TYPE_DATA = new byte[] {RemediumObject.DOUBLE};

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
	public void sendSpecificTo(DataOutputStream os, RemediumTransmitContext context) throws IOException {
		os.write(TYPE_DATA);
		os.writeDouble(value);
	}

	public static RemediumDouble receiveDouble(DataInputStream is, RemediumReceiveContext context) throws IOException {
		double ret = is.readDouble();
		return new RemediumDouble(ret);
	}

}
