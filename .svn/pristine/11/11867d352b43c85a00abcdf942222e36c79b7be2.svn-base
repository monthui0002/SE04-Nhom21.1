package com.jkgh.remedium.helpers;

import java.concurrent.Semaphore;

import com.jkgh.remedium.objects.RemediumObject;

public class RemediumReturner {

	private final Semaphore semaphore;
	private RemediumObject result;

	public RemediumReturner() {
		this.semaphore = new Semaphore();
		semaphore.close();
	}
	
	public void onReturn(RemediumObject result) {
		this.result = result;
		semaphore.open();
	}

	public RemediumObject waitForResult() {
		semaphore.pass();
		return result;
	}
}
