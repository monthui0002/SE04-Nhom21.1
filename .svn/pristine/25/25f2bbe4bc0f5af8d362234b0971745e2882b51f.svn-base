package com.jkgh.remedium.objects;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.nio.charset.Charset;
import java.nio.charset.UTF_8;

import com.jkgh.remedium.helpers.RemediumReceiveContext;
import com.jkgh.remedium.helpers.RemediumTransmitContext;

public class RemediumString extends RemediumObject {

	private static final byte[] TYPE_DATA = new byte[] {RemediumObject.STRING};
	public static final Charset UTF8 = new UTF_8();

	private String value;

	public RemediumString() {
		this("");
	}
	
	public RemediumString(String value) {
		this.setValue(value);
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public static void writeStringTo(String string, DataOutputStream os) throws IOException {
		byte[] bytes = string.getBytes(UTF8);
		os.writeInt(bytes.length);
		os.write(bytes);
	}

	@Override
	public void sendSpecificTo(DataOutputStream os, RemediumTransmitContext context) throws IOException {
		os.write(TYPE_DATA);
		writeStringTo(value, os);
	}

	public static RemediumString receiveString(DataInputStream is, RemediumReceiveContext context) throws IOException {
		int length = is.readInt();
		byte[] buffer = new byte[length];
		is.readFully(buffer);
		return new RemediumString(new String(buffer, UTF8));
	}

}
