
////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2008 Mecheye Independent Studios
//  Some Rights Reserved.
//  Source Code written by JP St. Pierre
//
////////////////////////////////////////////////////////////////////////////////


package mech.gamecurve.common {
	
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeMessage;
	
	/**
	 * A custom class that takes care of redirecting
	 * messages through the shell to other modules.
	 * 
	 * This class is designed for internal use only.
	 */
	public class RedirectMessage implements IPipeMessage {
		
		public static const REDIRECT:String = MessageTypes.BASE + "redirectMessage";
		
		public var message:IPipeMessage;
		public var moduleKey:String;
		
		public function RedirectMessage ( moduleKey:String, message:IPipeMessage ):void {
			this.moduleKey = moduleKey;
			this.message = message;
		}
		
		
		public function getType ( ):String {
			return REDIRECT;
		}
		
		public function setType ( type:String ):void { }
		
		public function getPriority ( ):int {
			return message.getPriority ( );
		}
		
		public function setPriority ( priority:int ):void {
			message.setPriority ( priority );
		}
		
		public function getHeader ( ):Object {
			return message.getHeader ( );
		}
		
		public function setHeader ( header:Object ):void {
			message.setHeader ( header );
		}
		
		public function getBody ( ):Object {
			return message.getBody ( );
		}
		
		public function setBody ( body:Object ):void {
			message.setBody ( body );
		}
		
	}
	
}
