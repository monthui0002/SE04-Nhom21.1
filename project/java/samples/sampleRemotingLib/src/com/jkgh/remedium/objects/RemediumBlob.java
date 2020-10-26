package com.jkgh.remedium.objects;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;

import com.jkgh.remedium.helpers.RemediumReceiveContext;
import com.jkgh.remedium.helpers.RemediumTransmitContext;

public class RemediumBlob extends RemediumObject {

	private static final byte[] TYPE_DATA = new byte[] {RemediumObject.BLOB};
	
	private byte[] value;

	public RemediumBlob(byte[] value) {
		this.setValue(value);
	}

	public RemediumBlob() {
		this(new byte[0]);
	}

	public byte[] getValue() {
		return value;
	}

	public void setValue(byte[] value) {
		this.value = value;
	}

	@Override
	public void sendSpecificTo(DataOutputStream os, RemediumTransmitContext context) throws IOException {
		os.write(TYPE_DATA);
		os.writeInt(value.length);
		os.write(value);
	}

	public static RemediumBlob receiveBlob(DataInputStream is, RemediumReceiveContext context) throws IOException {
		int length = is.readInt();
		byte[] ret = new byte[length];
		is.readFully(ret);
		return new RemediumBlob(ret);
	}

}
