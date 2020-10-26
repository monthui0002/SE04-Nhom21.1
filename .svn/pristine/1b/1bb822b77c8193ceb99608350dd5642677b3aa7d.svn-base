package com.jkgh.remedium.objects;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;

import com.jkgh.remedium.helpers.RemediumReceiveContext;
import com.jkgh.remedium.helpers.RemediumTransmitContext;

public class RemediumInteger extends RemediumObject {

	private static final byte[] TYPE_DATA = new byte[] {RemediumObject.INTEGER};

	private int value;

	public RemediumInteger(int value) {
		this.setValue(value);
	}

	public int getValue() {
		return value;
	}

	public void setValue(int value) {
		this.value = value;
	}

	@Override
	public void sendSpecificTo(DataOutputStream os, RemediumTransmitContext context) throws IOException {
		os.write(TYPE_DATA);
		os.writeInt(value);
	}

	public static RemediumInteger receiveInteger(DataInputStream is, RemediumReceiveContext context) throws IOException {
		int ret = is.readInt();
		return new RemediumInteger(ret);
	}
}
