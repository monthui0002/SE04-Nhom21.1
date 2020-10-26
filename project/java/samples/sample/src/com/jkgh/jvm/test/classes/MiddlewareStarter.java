package com.jkgh.jvm.test.classes;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import com.jkgh.remedium.RemediumClient;
import com.jkgh.remedium.helpers.RemediumReturner;
import com.jkgh.remedium.objects.RemediumInteger;
import com.jkgh.remedium.objects.RemediumLocalReference;
import com.jkgh.remedium.objects.RemediumObject;
import com.jkgh.remedium.objects.RemediumReference;
import com.jkgh.remedium.objects.RemediumString;
import com.jkgh.remedium.tools.BlockingChannelHandler;
import com.jkgh.remedium.tools.SocketThread;

public class MiddlewareStarter {

	public static void main(String[] args) throws IOException {
		
		String m = "Czesc "+Math.random();
		A.syso(m);
		
		BlockingChannelHandler chatClient = new RemediumClient() {

			@Override
			public void disconnected() {
				A.syso("Client disconnected.");
			}

			@Override
			public void connected(RemediumObject mainObject) {
				A.syso(mainObject+" received.");
				final RemediumReference chatServer = (RemediumReference) mainObject;
				final RemediumObject myListener = new RemediumLocalReference(this) {
					
					@Override
					public void call(String methodName, List<RemediumObject> arguments, RemediumReturner returner) {
						A.syso("> "+((RemediumString) arguments.get(0)).getValue());
					}

				};
				chatServer.call("addMainRoomListener", Arrays.<RemediumObject>asList(myListener), new RemediumReturner() {
					
					@Override
					public void returned(RemediumObject result) {
						final RemediumReference chatUser = (RemediumReference) result;
						A.syso(result+" received.");
						
						new Thread() {
							
							@Override
							public void run() {
								while (true) {
									Thread.sleep((long) (3000+Math.random()*5000));
									chatUser.call("isItMe", Arrays.<RemediumObject>asList(chatUser), new RemediumReturner() {
										
										@Override
										public void returned(RemediumObject result) {
											RemediumInteger ri = (RemediumInteger) result;
											A.syso("Me? "+ri.getValue());
										}
									});
									chatUser.call("isItMyListener", Arrays.<RemediumObject>asList(myListener), new RemediumReturner() {
										
										@Override
										public void returned(RemediumObject result) {
											RemediumInteger ri = (RemediumInteger) result;
											A.syso("My? "+ri.getValue());
										}
									});
									chatUser.call("messageArrived", Arrays.<RemediumObject>asList(new RemediumString("Czesc "+Math.random())), null);
								}
							};
						}.start();
					}
				});
			}
			
		};
		new SocketThread("localhost", 23432, chatClient).start();
	}
}
