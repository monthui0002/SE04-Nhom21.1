package com.jkgh.jvm.gateways {

	import com.jkgh.jvm.gateways.ClientSocket;
	import com.jkgh.jvm.runtime.execution.JVMArrayObject;
	
	import flash.net.Socket;
	import flash.utils.Dictionary;

	public class ClientSocketGateway {
		
		private static var idGenerator:int = 0;
		private static var sockets:Dictionary = new Dictionary();
		
		public static function connect(host:String, port:int, onReturn:Function):void {
			var socket:ClientSocket = new ClientSocket(host, port, onReturn);			
		}
		
		public static function read(handle:int, onReturn:Function):void {
			var socket:ClientSocket = sockets[handle];
			if (socket == null) {
				onReturn(-1);
			} else {
				socket.read(onReturn);
			}
		}
		
		public static function write(handle:int, data:int, onReturn:Function):void {
			var socket:ClientSocket = sockets[handle];
			if (socket == null) {
				onReturn(-2);
			} else {
				socket.write(data, onReturn);
			}
		}
		
		public static function flush(handle:int, onReturn:Function):void {
			var socket:ClientSocket = sockets[handle];
			if (socket == null) {
				onReturn(-2);
			} else {
				socket.flush(onReturn);
			}
		}
		
		public static function close(handle:int):void {
			var socket:ClientSocket = sockets[handle];
			if (socket != null) {
				socket.close();
			}
		}
		
		private static function nextID():int {
			return ++idGenerator;
		}
		
		public static function register(socket:ClientSocket):int {
			var handle:int = nextID();
			sockets[handle] = socket;
			return handle;
		}
		
		public static function unregister(handle:int):void {
			delete sockets[handle];
		}
		
		public static function fillAvailable(handle:int, b:JVMArrayObject, off:int, len:int, onReturn:Function):void {
			var socket:ClientSocket = sockets[handle];
			if (socket == null) {
				onReturn(-1);
			} else {
				socket.fillAvailable(b, off, len, onReturn);
			}
		}
	}
}