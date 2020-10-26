package com.jkgh.jvm.test;

import java.io.IOException;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import com.jkgh.remedium.RemediumClient;
import com.jkgh.remedium.objects.RemediumLocalReference;
import com.jkgh.remedium.objects.RemediumObject;
import com.jkgh.remedium.objects.RemediumRedirectingReference;
import com.jkgh.remedium.objects.RemediumReference;
import com.jkgh.remedium.objects.RemediumString;

public class Main {

	public native static void writeMessage(String s);
	public native static String readMessage();
	
	public static void main(String[] args) throws IOException {
		
		writeMessage("Starting client.");
		
		String host = args[0];
		int port = Integer.parseInt(args[1]);
		String name = args[2];
		
		writeMessage("Connecting to server "+host+" on port "+port+".");
		
		RemediumClient rc = new RemediumClient(host, port);
				
		RemediumReference remote = (RemediumReference) rc.getMainObject();
						
		RemediumString r = (RemediumString) remote.call("getServerName", Collections.<RemediumObject>emptyList());
				
		writeMessage("Connected to "+r.getValue()+".");

		RemediumRedirectingReference delegate = (RemediumRedirectingReference) remote.call("addMainRoomListener", Arrays.<RemediumObject>asList(new RemediumLocalReference(rc) {

			@Override
			public RemediumObject call(String methodName, List<RemediumObject> arguments) throws IOException {
				if (methodName.equals("onMessageArrived")) {
					String s = ((RemediumString) arguments.get(0)).getValue();
					writeMessage(s);
				}
				return null;
			}
			
		}));
		
		writeMessage("Listener registered.");

		delegate.run("setName", Arrays.<RemediumObject>asList(new RemediumString(name)));
		
		writeMessage("Name set to "+name+".");
		
		while (true) {
			String m = readMessage();
			if (m.startsWith("!name=")) {
				delegate.run("setName", Arrays.<RemediumObject>asList(new RemediumString(m.substring("!name=".length()))));
			} else {
				delegate.run("sendMessage", Arrays.<RemediumObject>asList(new RemediumString(m)));
			}
		}
	}
}
