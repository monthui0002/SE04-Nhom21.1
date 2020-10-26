package com.jkgh.jvm.gateways {
	
	import com.jkgh.jvm.runtime.execution.JVMArrayObject;
	
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	
	public class ClientSocket {
		
		private var socket:Socket;
		private var handle:int;
		private var code:int;
		private var waiting:Function;
		
		public function ClientSocket(host:String, port:int, onReturn:Function) {
			
			this.handle = 0;
			this.code = 0;
			this.socket = new Socket();
			
			var thisReference:ClientSocket = this;
			var pending:Boolean = true;
			socket.addEventListener(Event.CONNECT, function(e:Event):void {
				if (pending) {
					pending = false;
					handle = ClientSocketGateway.register(thisReference);
					onReturn(handle);
				}
			});
			socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, function(e:SecurityErrorEvent):void {
				if (pending) {
					pending = false;
					onReturn(-1);
				}
			});
			socket.addEventListener(IOErrorEvent.IO_ERROR, function(e:IOErrorEvent):void {
				if (e.errorID == 2031) {
					if (pending) {
						pending = false;
						onReturn(-2);
					}
				} else {
					ioErrorOccurred();
				}
			});
			socket.addEventListener(ProgressEvent.SOCKET_DATA, onSocketData);
			socket.addEventListener(Event.CLOSE, function(e:Event):void {
				code = -1;
				if (waiting != null) {
					waiting(code);
					waiting = null;
				}
			});
			
			socket.connect(host, port);
		}
		
		private function onSocketData(event:ProgressEvent):void {
			if (waiting != null) {
				try {
					var b:int = socket.readByte();
					waiting(b);
					waiting = null;
				} catch (ioe:IOError) {
					this.code = -2;
					ioErrorOccurred();
					waiting(code);
					waiting = null;
				}
			}
		}
		
		public function ioErrorOccurred():void {
			this.code = -2;
			socket.close();
		}
		
		public function read(onReturn:Function):void {
			if (code == 0) {
				if (socket.bytesAvailable > 0) {
					try {
						var read:int = socket.readByte();
						onReturn(read);
					} catch(e:IOError) {
						ioErrorOccurred();
						onReturn(code);
					}
				} else {
					waiting = onReturn;
				}
			} else if (code == -1) {
				onReturn(-1);
			} else if (code == -2) {
				onReturn(code);
				this.code = -1;
				ClientSocketGateway.unregister(handle);
				return;
			}
		}
		
		public function write(data:int, onReturn:Function):void {
			try {
				socket.writeByte(data);
				onReturn(0);
			} catch (e:IOError) {
				this.code = -2;
				onReturn(code);
			}
		}
		
		public function flush(onReturn:Function):void {
			try {
				socket.flush();
				onReturn(0);
			} catch (e:IOError) {
				this.code = -2;
				onReturn(code);
			}
		}
		
		public function close():void {
			socket.close();
		}
		
		public function fillAvailable(b:JVMArrayObject, off:int, len:int, onReturn:Function):void {
			if (code == 0) {
				if (socket.bytesAvailable > 0) {
					try {
						var count:int = Math.min(socket.bytesAvailable, len);
						for (var i:int = 0; i<count; ++i) {
							var read:int = socket.readByte();
							b.setElement(off+i, read);
						}
						onReturn(count);
					} catch(e:IOError) {
						ioErrorOccurred();
						onReturn(code);
					}
				} else {
					onReturn(0);
				}
			} else if (code == -1) {
				onReturn(code);
			} else if (code == -2) {
				onReturn(code);
				this.code = -1;
				ClientSocketGateway.unregister(handle);
				return;
			}
		}
	}
}