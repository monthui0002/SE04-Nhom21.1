package com.jkgh.remedium.objects;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.jkgh.remedium.helpers.RemediumReceiveContext;
import com.jkgh.remedium.helpers.RemediumTransmitContext;

public class RemediumList extends RemediumObject {

	private static final byte[] TYPE_DATA = new byte[] {RemediumObject.LIST};

	private final List<RemediumObject> list;

	public RemediumList() {
		this.list = new ArrayList<RemediumObject>();
	}
	
	public RemediumList(int length) {
		this.list = new ArrayList<RemediumObject>(length);
	}

	public void set(int i, RemediumObject item) {
		list.set(i, item);
	}

	public void add(RemediumObject item) {
		list.add(item);
	}
	
	@Override
	public void sendSpecificTo(DataOutputStream os, RemediumTransmitContext context) throws IOException {
		os.write(TYPE_DATA);
		writeListTo(list, os, context);
	}

	public List<RemediumObject> getValue() {
		return list;
	}

	public static void writeListTo(List<RemediumObject> list, DataOutputStream os, RemediumTransmitContext context) throws IOException {
		os.writeInt(list.size());
		for (RemediumObject ro: list) {
			ro.sendTo(os, context);
		}
	}

	public static RemediumList receiveList(DataInputStream is, RemediumReceiveContext context) throws IOException {
		int length = is.readInt();
		RemediumList ret = new RemediumList(length);
		for (int i=0; i<length; ++i) {
			RemediumObject o = RemediumObject.receiveObject(is, context);
			ret.add(o);
		}
		return ret;
	}
}
