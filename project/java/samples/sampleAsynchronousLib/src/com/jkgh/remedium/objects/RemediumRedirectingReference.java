package com.jkgh.remedium.objects;

import java.util.List;

import com.jkgh.remedium.RemediumClient;
import com.jkgh.remedium.helpers.RemediumReturner;
import com.jkgh.remedium.helpers.RemediumTransmitContext;

public class RemediumRedirectingReference extends RemediumReference {

	private final RemediumClient client;

	public RemediumRedirectingReference(RemediumClient client, int hostID, int referenceID) {
		super(hostID, referenceID);
		this.client = client;
	}

	@Override
	public void call(String methodName, List<RemediumObject> arguments, RemediumReturner returner) {
		RemediumCallOrder order = new RemediumCallOrder(hostID, referenceID, methodName, arguments);
		client.registerReturner(returner);
		order.sendTo(client, new RemediumTransmitContext());
	}
}
