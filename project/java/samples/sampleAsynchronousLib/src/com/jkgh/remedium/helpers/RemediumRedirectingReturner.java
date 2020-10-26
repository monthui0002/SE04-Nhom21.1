package com.jkgh.remedium.helpers;

import com.jkgh.remedium.RemediumClient;
import com.jkgh.remedium.objects.RemediumObject;
import com.jkgh.remedium.objects.RemediumReturnOrder;

public class RemediumRedirectingReturner implements RemediumReturner {
	
	private final int callerID;
	private final int callID;
	private final RemediumClient client;

	public RemediumRedirectingReturner(RemediumClient client, int callerID, int callID) {
		this.client = client;
		this.callerID = callerID;
		this.callID = callID;
	}

	@Override
	public void returned(RemediumObject result) {
		RemediumReturnOrder returnObject = new RemediumReturnOrder(callerID, callID, result);
		returnObject.sendTo(client, new RemediumTransmitContext());
	}


}
