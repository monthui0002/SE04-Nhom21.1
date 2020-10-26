package com.jkgh.jvm.test.classes;


public class SynchronizationStarter {
	
	public Object lock = new Object();
	
	public static void main(final String[] args) {
		
		final SynchronizationStarter starter1 = new SynchronizationStarter();
		final SynchronizationStarter starter2 = new SynchronizationStarter();
		
		starter1.add(0, 0, 0);
		
		new Thread() {
			
			public void run() {
				for (int i=0; i<10; ++i) {
					int a = i*2;
					int b = i*3;
					int c = starter2.add(a, b, 1);
					i += c;
					i -= c;
				}
			}
			
		}.start();

		starter1.add(0, 0, 0);
		
		new Thread() {
			
			public void run() {
				for (int i=0; i<10; ++i) {
					int a = i*2;
					int b = i*3;
					int c = starter2.add(a, b, 2);
					c = c+1;
				}
			}
			
		}.start();
		
		starter1.add(0, 0, 0);
	}
	
	public int add(int a, int b, int id) {
		synchronized (lock) {
			A.syso("IN  "+id);
			a = a ^ b;
			b = a ^ b;
			a = a ^ b;
			a = a ^ b;
			b = a ^ b;
			a = a ^ b;
			if (id > 0) {
				add(a, b, -id);
			}
			//Thread.sleep(300);
			a = a ^ b;
			b = a ^ b;
			a = a ^ b;
			a = a ^ b;
			b = a ^ b;
			a = a ^ b;
			A.syso("OUT "+id);
			return a+b;
		}
	}

}
