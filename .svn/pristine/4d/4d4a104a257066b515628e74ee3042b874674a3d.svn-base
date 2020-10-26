package com.jkgh.remedium.objects;

import java.nio.charset.Charset;
import java.nio.charset.UTF_8;

import com.jkgh.asin.ChannelHandler;
import com.jkgh.remedium.RemediumClient;
import com.jkgh.remedium.helpers.RemediumTransmitContext;
import com.jkgh.remedium.states.ReceiveRemediumObjectState;

public class RemediumString extends RemediumObject {

	private static final byte[] TYPE_DATA = new byte[] {ReceiveRemediumObjectState.STRING};
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

	public static void writeStringTo(String string, ChannelHandler channel) {
		byte[] bytes = string.getBytes(UTF8);
		channel.write(RemediumClient.intToByteArray(bytes.length));
		channel.write(bytes);
	}

	@Override
	public void sendSpecificTo(ChannelHandler channel, RemediumTransmitContext context) {
		channel.write(TYPE_DATA);
		writeStringTo(value, channel);
	}

}
