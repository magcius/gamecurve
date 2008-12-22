
////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2008 Mecheye Independent Studios
//  Some Rights Reserved.
//  Source Code written by JP St. Pierre
//
////////////////////////////////////////////////////////////////////////////////


package mech.gamecurve.common {
	
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeMessage;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.Junction;
	
	/**
	 * A module junction is a junction with the ability
	 * to send messages through the shell to other modules,
	 * knowing the module's internal name.
	 */
	public class ModuleJunction extends Junction {
		
		/**
		 * Constructor.
		 */
		public function ModuleJunction ( ):void {
			super ( );
		}
		
		/**
		 * Send a message to a named module.
		 */
		public function sendMessageToModule ( moduleInternalName:String, message:IPipeMessage ):void {
			this.sendMessage ( GamecurveModuleBase.MODULE_TO_MODULE, new RedirectMessage ( moduleInternalName, message ) );
		}
		
	}
	
}
