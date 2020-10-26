package com.jkgh.remedium.objects;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;

import com.jkgh.remedium.helpers.RemediumReceiveContext;
import com.jkgh.remedium.helpers.RemediumTransmitContext;

public abstract class RemediumObject {

	public static final byte LIST = 1;
	public static final byte MAP = 2;
	public static final byte REFERENCE = 3;
	public static final byte BYTE = 4;
	public static final byte INTEGER = 5;
	public static final byte DOUBLE = 6;
	public static final byte STRING = 7;
	public static final byte BLOB = 8;
	public static final byte INITIAL_DATA = 9;
	public static final byte CALL = 10;
	public static final byte RUN = 11;
	public static final byte RETURN = 12;
	public static final byte CALL_OBJECT = 13;
	public static final byte RUN_OBJECT = 14;
	public static final byte RETURN_OBJECT = 15;
	public static final byte HISTORY_INDEX = 16;
	
	public final void sendTo(DataOutputStream os, RemediumTransmitContext context) throws IOException {
		int historyIndex = context.toHistory(this);
		if (historyIndex != -1) {
			os.write(HISTORY_INDEX);
			os.writeInt(historyIndex);
		} else {
			sendSpecificTo(os, context);
		}
	}

	protected abstract void sendSpecificTo(DataOutputStream os, RemediumTransmitContext context) throws IOException;
	
	public static RemediumObject receiveObject(DataInputStream is, RemediumReceiveContext context) throws IOException {
		byte typeCode = is.readByte();
				
		RemediumObject ret;
		if (typeCode == HISTORY_INDEX) {
			int index = is.readInt();
			ret = context.fromHistory(index);
		} else {
			ret = receiveSpecificObject(is, context, typeCode);
			context.toHistory(ret);
		}
		return ret;
	}
	
	private static RemediumObject receiveSpecificObject(DataInputStream is, RemediumReceiveContext context, byte typeCode) throws IOException {
		
		switch (typeCode) {
		
			case LIST: return RemediumList.receiveList(is, context);
			case MAP: return RemediumMap.receiveMap(is, context);
			case REFERENCE: return RemediumReference.receiveReference(is, context);
			case BYTE: return RemediumByte.receiveByte(is, context);
			case INTEGER: return RemediumInteger.receiveInteger(is, context);
			case DOUBLE: return RemediumDouble.receiveDouble(is, context);
			case STRING: return RemediumString.receiveString(is, context);
			case BLOB: return RemediumBlob.receiveBlob(is, context);
			case INITIAL_DATA: return RemediumInitialData.receiveInitialData(is, context);
			case CALL_OBJECT: return RemediumCallObject.receiveCallObject(is, context);
			case RUN_OBJECT: return RemediumRunObject.receiveRunObject(is, context);			
			case RETURN_OBJECT: return RemediumReturnObject.receiveReturnObject(is, context);
			default: throw new IllegalStateException("Illegal type code: "+typeCode+".");
		
		}
	}
}
