package com.jkgh.remedium;

import java.util.HashMap;
import java.util.Map;

import com.jkgh.asin.State;
import com.jkgh.asin.StateMachineChannelHandler;
import com.jkgh.remedium.helpers.RemediumReceiveContext;
import com.jkgh.remedium.helpers.RemediumReturner;
import com.jkgh.remedium.objects.RemediumInitialData;
import com.jkgh.remedium.objects.RemediumLocalReference;
import com.jkgh.remedium.objects.RemediumObject;
import com.jkgh.remedium.objects.RemediumOrder;
import com.jkgh.remedium.objects.RemediumRedirectingReference;
import com.jkgh.remedium.objects.RemediumReference;
import com.jkgh.remedium.states.ReceiveRemediumObjectState;

public abstract class RemediumClient extends StateMachineChannelHandler {

	private final Map<Integer, RemediumLocalReference> references;
	private final Map<Integer, RemediumReturner> returners;
	private final Map<Long, RemediumRedirectingReference> redirectingReferences;
	
	private int hostID;
	
	private int nextCallID;
	private int nextReferenceID;

	public RemediumClient() {
		this.references = new HashMap<Integer, RemediumLocalReference>();
		this.returners = new HashMap<Integer, RemediumReturner>();
		this.redirectingReferences = new HashMap<Long, RemediumRedirectingReference>();
		this.nextReferenceID = 0;
		this.nextCallID = 0;
		this.hostID = -1;
	}
	
	public abstract void connected(RemediumObject mainObject);

	@Override
	public State startState() {
		write(new byte[] {'A'});
		return new ReceiveRemediumObjectState(new RemediumReceiveContext(this)) {
			
			@Override
			protected State onReceived(RemediumObject initialObject) {
				RemediumInitialData initialData = (RemediumInitialData) initialObject;
				hostID = initialData.getHostID();
				connected(initialData.getMainObject());
				return awaitOrderState();
			}
		};
	}

	private State awaitOrderState() {
		return new ReceiveRemediumObjectState(new RemediumReceiveContext(this)) {

			@Override
			protected State onReceived(RemediumObject object) {
				RemediumOrder order = (RemediumOrder) object;
				order.execute(RemediumClient.this);
				return awaitOrderState();
			}
			
		};
	}

	public static final byte[] intToByteArray(int value) {
        return new byte[] {(byte) (value >>> 24), (byte) (value >>> 16), (byte) (value >>> 8), (byte) value};
	}

	public static double byteArrayToDouble(byte[] received) {
		long l = (long) (received[0] & 255) << 56 | (long) (received[1] & 255) << 48 | (long) (received[2] & 255) << 40 | (long) (received[3] & 255) << 32 | (long) (received[4] & 255) << 24 | (long) (received[5] & 255) << 16 | (long) (received[6] & 255) << 8 | (long) (received[7] & 255) << 0;
		return Double.longBitsToDouble(l);
	}
	
	public static byte[] doubleToByteArray(double d) {
	    long l = Double.doubleToRawLongBits(d);
	    return new byte[] {(byte) ((l >> 56) & 255), (byte) ((l >> 48) & 255), (byte) ((l >> 40) & 255), (byte) ((l >> 32) & 255), (byte) ((l >> 24) & 255), (byte) ((l >> 16) & 255), (byte) ((l >> 8) & 255), (byte) ((l >> 0) & 255)};
	}

	public RemediumLocalReference getReference(int referenceID) {
		return references.get(referenceID);
	}

	public int getNextCallID() {
		++nextCallID;
		return nextCallID;
	}
	
	public int getNextReferenceID() {
		++nextReferenceID;
		return nextReferenceID;
	}

	public int getHostID() {
		return hostID;
	}

	public void registerReturner(RemediumReturner returner) {
		returners.put(getNextCallID(), returner);
	}

	public RemediumReturner retrieveReturner(int callID) {
		return returners.remove(callID);
	}

	public RemediumReference getReference(int sourceHostID, int referenceID) {
		if (hostID == sourceHostID) {
			return getReference(referenceID);
		} else {
			long key = intPairToLong(sourceHostID, referenceID);
			RemediumRedirectingReference redirectingReference = redirectingReferences.get(key);
			if (redirectingReference == null) {
				redirectingReference = new RemediumRedirectingReference(this, sourceHostID, referenceID);
				redirectingReferences.put(key, redirectingReference);
			}
			return redirectingReference;
		}
	}

	private long intPairToLong(int sourceHostID, int referenceID) {
		return (((long) sourceHostID) << 32) | (long) referenceID;
	}

	public void registerReference(int referenceID, RemediumLocalReference remediumLocalReference) {
		references.put(referenceID, remediumLocalReference);
	}

}
