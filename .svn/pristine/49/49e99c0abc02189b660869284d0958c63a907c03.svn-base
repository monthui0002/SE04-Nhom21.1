package com.jkgh.remedium.objects;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;

import com.jkgh.remedium.helpers.RemediumReceiveContext;
import com.jkgh.remedium.helpers.RemediumTransmitContext;

public class RemediumMap extends RemediumObject {

	private static final byte[] TYPE_DATA = new byte[] {RemediumObject.MAP};

	private Map<String, RemediumObject> map;

	public RemediumMap() {
		this.map = new HashMap<String, RemediumObject>();
	}

	public void put(String value, RemediumObject item) {
		map.put(value, item);
	}
	
	@Override
	public void sendSpecificTo(DataOutputStream os, RemediumTransmitContext context) throws IOException {
		os.write(TYPE_DATA);
		os.writeInt(map.size());
		for (Entry<String, RemediumObject> e: map.entrySet()) {
			RemediumString.writeStringTo(e.getKey(), os);
			e.getValue().sendTo(os, context);
		}
	}

	public static RemediumMap receiveMap(DataInputStream is, RemediumReceiveContext context) throws IOException {
		RemediumMap ret = new RemediumMap();
		int count = is.readInt();
		for (int i=0; i<count; ++i) {
			RemediumString key = RemediumString.receiveString(is, context);
			RemediumObject value = RemediumObject.receiveObject(is, context);
			ret.put(key.getValue(), value);
		}
		return ret;
	}
}
