package com.jkgh.remedium.objects;

import com.jkgh.remedium.RemediumClient;

public abstract class RemediumLocalReference extends RemediumReference {

	public RemediumLocalReference(RemediumClient client) {
		super(client.getHostID(), client.getNextReferenceID());
		client.registerReference(referenceID, this);
	}

}
