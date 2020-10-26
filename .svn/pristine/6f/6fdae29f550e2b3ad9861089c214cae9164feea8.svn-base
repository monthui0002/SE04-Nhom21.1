package com.jkgh.jvm.test.classes;

import java.concurrent.Lock;

public class ThreadStarter {

	public static void main(String[] args) {
		
		final Lock lock = new Lock();
		
		new Thread() {
			
			public void run() {
				
				A.syso("A1");
				lock.lock();
				A.syso("A2");
				A.syso("A3");
				A.syso("A4");
				A.syso("A5");
				A.syso("A6");
				lock.unlock();
				A.syso("A7");
				A.syso("A8");
			};
			
		}.start();
		
		new Thread() {
			
			public void run() {
				
				lock.lock();
				
				A.syso("B1");
				A.syso("B2");
				A.syso("B3");
				A.syso("B4");
				A.syso("B5");
				A.syso("B6");
				A.syso("B7");
				A.syso("B8");
				
				lock.unlock();
			};
			
		}.start();
	}
}
