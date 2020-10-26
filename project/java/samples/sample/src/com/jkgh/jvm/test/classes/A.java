package com.jkgh.jvm.test.classes;

public class A {

	protected int p;
	
	public static native void syso(String output);
	
	public A() {
		this.p = 2;
	}

	public int getP() {
		return p;
	}
	
	public static B getB() {
		return B.getB();
	}
	
	public static A getA() {
		return B.getA();
	}
}
