package com.jkgh.remedium.states;

import com.jkgh.asin.State;
import com.jkgh.remedium.helpers.RemediumReceiveContext;

public abstract class RemediumState extends State {

	protected final RemediumReceiveContext context;

	public RemediumState(RemediumReceiveContext context) {
		this.context = context;
	}
}
