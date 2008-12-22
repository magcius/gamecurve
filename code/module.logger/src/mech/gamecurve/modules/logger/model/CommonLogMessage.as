
////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2008 Mecheye Independent Studios
//  Some Rights Reserved.
//  Source Code written by JP St. Pierre
//
////////////////////////////////////////////////////////////////////////////////


package mech.gamecurve.modules.logger.model {

	public class CommonLogMessage implements ILogMessage {
		
		protected var _message:String;
		protected var _senderComponent:String;
		protected var _senderModule:String;
		protected var _timeSent:Date;
		
		public function CommonLogMessage ( message:String, senderComponent:String, senderModule:String ):void {
			this._message = message;
			this._senderComponent = senderComponent;
			this._senderModule = senderModule;
			this._timeSent = new Date ( );
		}

		public function get message ( ):String { return _message; }
		public function get senderComponent ( ):String { return _senderComponent; }
		public function get senderModule ( ):String { return _senderModule; }
		public function get timeSent ( ):Date { return _timeSent; }
		
		public function toString ( ):String { return _message; }
		
	}

}