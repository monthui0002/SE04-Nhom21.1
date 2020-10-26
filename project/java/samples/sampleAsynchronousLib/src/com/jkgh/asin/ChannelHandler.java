package com.jkgh.asin;

import java.nio.ByteBuffer;

public interface ChannelHandler {
	
	public void disconnectAfterAllWrites();
	public void disconnect();
	public void disconnected();
	public void bytesRead(ByteBuffer data);
	public void write(byte[] data);
}
