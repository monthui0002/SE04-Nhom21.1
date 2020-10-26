package com.jkgh.remedium.objects;

import java.util.ArrayList;
import java.util.List;

import com.jkgh.asin.ChannelHandler;
import com.jkgh.remedium.RemediumClient;
import com.jkgh.remedium.helpers.RemediumTransmitContext;
import com.jkgh.remedium.states.ReceiveRemediumObjectState;

public class RemediumList extends RemediumObject {

	private static final byte[] TYPE_DATA = new byte[] {ReceiveRemediumObjectState.LIST};

	private final List<RemediumObject> list;

	public RemediumList() {
		this.list = new ArrayList<RemediumObject>();
	}
	
	public RemediumList(int length) {
		this.list = new ArrayList<RemediumObject>(length);
	}

	public void set(int i, RemediumObject item) {
		list.set(i, item);
	}

	public void add(RemediumObject item) {
		list.add(item);
	}
	
	@Override
	public void sendSpecificTo(ChannelHandler channel, RemediumTransmitContext context) {
		channel.write(TYPE_DATA);
		writeListTo(list, channel, context);
	}

	public List<RemediumObject> getValue() {
		return list;
	}

	public static void writeListTo(List<RemediumObject> list, ChannelHandler channel, RemediumTransmitContext context) {
		channel.write(RemediumClient.intToByteArray(list.size()));
		for (RemediumObject ro: list) {
			ro.sendTo(channel, context);
		}
	}
}
