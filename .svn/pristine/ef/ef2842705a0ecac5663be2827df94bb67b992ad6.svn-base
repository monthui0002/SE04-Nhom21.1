package com.jkgh.remedium.helpers;

import java.util.ArrayList;
import java.util.List;

import com.jkgh.remedium.RemediumClient;
import com.jkgh.remedium.objects.RemediumObject;

public class RemediumReceiveContext {

	private final RemediumClient client;
	private final List<RemediumObject> history;

	public RemediumReceiveContext(RemediumClient client) {
		this.client = client;
		this.history = new ArrayList<RemediumObject>();
	}

	public RemediumObject fromHistory(int index) {
		return history.get(index);
	}
	
	public void toHistory(RemediumObject object) {
		history.add(object);
	}
	
	public RemediumClient getClient() {
		return client;
	}

}
