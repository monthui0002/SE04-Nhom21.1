package com.jkgh.remedium.objects;

import java.io.IOException;
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
	public RemediumObject call(String methodName, List<RemediumObject> arguments) throws IOException {
		RemediumCallOrder order = new RemediumCallOrder(hostID, referenceID, methodName, arguments);
		client.lockOutput();
		RemediumReturner returner = client.createReturner();
		order.sendTo(client.getOutputStream(), new RemediumTransmitContext(client));
		client.getOutputStream().flush();
		client.unlockOutput();
		
		RemediumObject ret = returner.waitForResult();
		return ret;
	}
	
	public void run(String methodName, List<RemediumObject> arguments) throws IOException {
		RemediumRunOrder order = new RemediumRunOrder(hostID, referenceID, methodName, arguments);
		client.lockOutput();
		order.sendTo(client.getOutputStream(), new RemediumTransmitContext(client));
		client.getOutputStream().flush();
		client.unlockOutput();
	}
}
