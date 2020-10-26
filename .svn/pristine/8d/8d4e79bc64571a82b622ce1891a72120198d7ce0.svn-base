package com.jkgh.remedium.objects;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;

import com.jkgh.remedium.helpers.RemediumReceiveContext;
import com.jkgh.remedium.helpers.RemediumTransmitContext;

public class RemediumByte extends RemediumObject {

	private static final byte[] TYPE_DATA = new byte[] {RemediumObject.BYTE};
	
	private byte value;

	public RemediumByte(byte value) {
		this.setValue(value);
	}

	public byte getValue() {
		return value;
	}

	public void setValue(byte value) {
		this.value = value;
	}

	@Override
	public void sendSpecificTo(DataOutputStream os, RemediumTransmitContext context) throws IOException {
		os.write(TYPE_DATA);
		os.write(new byte[] {value});		
	}

	public static RemediumByte receiveByte(DataInputStream is, RemediumReceiveContext context) throws IOException {
		return new RemediumByte(is.readByte());
	}
}
