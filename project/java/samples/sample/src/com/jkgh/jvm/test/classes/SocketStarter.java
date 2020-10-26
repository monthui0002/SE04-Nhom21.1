package com.jkgh.jvm.test.classes;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.ClientSocket;
import java.net.ConnectException;

public class SocketStarter {

	public static void main(String[] args) throws IOException {
		
		A.syso("Starting");
		
		ClientSocket cs;
		try {
			cs = new ClientSocket("localhost", 43434);
			A.syso("Connected");
		} catch (ConnectException e) {
			A.syso("Cannot connect due to exception: "+e);
			return;
		}
		
		BufferedReader reader = new BufferedReader(new InputStreamReader(cs.getInputStream()));
		PrintWriter writer = new PrintWriter(cs.getOutputStream());
		
		writer.println("Hahaha :)");
		while (true) {
			int r = reader.read();
			A.syso("Read: "+r);
			if (r == -1) {
				break;
			}
		}
	}
}
