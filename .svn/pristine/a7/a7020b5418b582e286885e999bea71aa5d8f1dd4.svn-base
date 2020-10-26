package com.jkgh.remedium.helpers;

import java.util.HashMap;
import java.util.Map;

import com.jkgh.remedium.RemediumClient;
import com.jkgh.remedium.objects.RemediumObject;

public class RemediumTransmitContext {

	private final RemediumClient client;
	private final Map<RemediumObject, Integer> history;

	public RemediumTransmitContext(RemediumClient client) {
		this.client = client;
		this.history = new HashMap<RemediumObject, Integer>();
	}

	public RemediumClient getClient() {
		return client;
	}
	
	public int toHistory(RemediumObject object) {
		Integer index = history.get(object);
		int ret = -1;
		if (index == null) {
			history.put(object, history.size());
		} else {
			ret = index;
		}
		return ret;
	}

}
