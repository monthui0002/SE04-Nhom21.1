package com.jkgh.remedium;

import java.concurrent.Lock;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.ClientSocket;
import java.util.HashMap;
import java.util.Map;

import com.jkgh.remedium.helpers.RemediumReceiveContext;
import com.jkgh.remedium.helpers.RemediumReturner;
import com.jkgh.remedium.objects.RemediumInitialData;
import com.jkgh.remedium.objects.RemediumLocalReference;
import com.jkgh.remedium.objects.RemediumObject;
import com.jkgh.remedium.objects.RemediumOrder;
import com.jkgh.remedium.objects.RemediumRedirectingReference;
import com.jkgh.remedium.objects.RemediumReference;

public class RemediumClient {

	private final Map<Integer, RemediumLocalReference> references;
	private final Map<Integer, RemediumReturner> returners;
	private final Map<Long, RemediumRedirectingReference> redirectingReferences;
	
	private final ClientSocket socket;
	private final DataOutputStream os;
	private final DataInputStream is;
	
	private int hostID;
	private final RemediumObject mainObject;
	private final Thread thread;
	
	private final Lock outputLock;
	
	private int nextCallID;
	private int nextReferenceID;
	

	public RemediumClient(String host, int port) throws IOException {
		this.references = new HashMap<Integer, RemediumLocalReference>();
		this.returners = new HashMap<Integer, RemediumReturner>();
		this.redirectingReferences = new HashMap<Long, RemediumRedirectingReference>();
		this.nextReferenceID = 0;
		this.nextCallID = 0;
		this.socket = new ClientSocket(host, port);
		this.os = new DataOutputStream(socket.getOutputStream());
		this.is = new DataInputStream(socket.getInputStream());
		this.outputLock = new Lock();
		this.hostID = -1;
		
		os.writeByte('S');
		os.flush();
		
		RemediumInitialData initialData = (RemediumInitialData) RemediumObject.receiveObject(is, new RemediumReceiveContext(this));
		
		this.hostID = initialData.getHostID();
		this.mainObject = initialData.getMainObject();
				
		this.thread = new Thread() {
			
			@Override
			public void run() {
				while (true) {
					try {
						final RemediumOrder order = (RemediumOrder) RemediumObject.receiveObject(is, new RemediumReceiveContext(RemediumClient.this));
						new Thread("Execution of "+order+".") {
							
							public void run() {
								try {
									order.execute(RemediumClient.this);
								} catch (IOException e) {
									throw new RuntimeException(e);
								}
							};
						}.start();
					} catch (Exception e) {
						throw new RuntimeException(e);
					}
				}
			}
		};
		thread.start();
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

	public RemediumReturner createReturner() {
		RemediumReturner ret = new RemediumReturner();
		returners.put(getNextCallID(), ret);
		return ret;
	}

	public void fireReturner(int callID, RemediumObject result) {
		RemediumReturner returner = returners.remove(callID);
		returner.onReturn(result);
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

	public DataOutputStream getOutputStream() {
		return os;
	}

	public RemediumObject getMainObject() {
		return mainObject;
	}

	public void lockOutput() {
		outputLock.lock();
	}

	public void unlockOutput() {
		outputLock.unlock();
	}

}
