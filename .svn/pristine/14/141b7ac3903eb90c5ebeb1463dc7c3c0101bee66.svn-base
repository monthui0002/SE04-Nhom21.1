package com.jkgh.remedium.objects;

import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;

import com.jkgh.asin.ChannelHandler;
import com.jkgh.remedium.RemediumClient;
import com.jkgh.remedium.helpers.RemediumTransmitContext;
import com.jkgh.remedium.states.ReceiveRemediumObjectState;

public class RemediumMap extends RemediumObject {

	private static final byte[] TYPE_DATA = new byte[] {ReceiveRemediumObjectState.MAP};

	private Map<String, RemediumObject> map;

	public RemediumMap() {
		this.map = new HashMap<String, RemediumObject>();
	}

	public void put(String value, RemediumObject item) {
		map.put(value, item);
	}
	
	@Override
	public void sendSpecificTo(ChannelHandler channel, RemediumTransmitContext context) {
		channel.write(TYPE_DATA);
		channel.write(RemediumClient.intToByteArray(map.size()));
		for (Entry<String, RemediumObject> e: map.entrySet()) {
			RemediumString.writeStringTo(e.getKey(), channel);
			e.getValue().sendTo(channel, context);
		}
	}
}
