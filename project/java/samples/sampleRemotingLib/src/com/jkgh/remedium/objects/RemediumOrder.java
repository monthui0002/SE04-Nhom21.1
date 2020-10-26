package com.jkgh.remedium.objects;

import java.io.IOException;

import com.jkgh.remedium.RemediumClient;

public abstract class RemediumOrder extends RemediumObject {

	public abstract void execute(RemediumClient client) throws IOException;

}
