
////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2008 Mecheye Independent Studios
//  Some Rights Reserved.
//  Source Code written by JP St. Pierre
//
////////////////////////////////////////////////////////////////////////////////


package mech.gamecurve.modules.logger.view {
	
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeMessage;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.Junction;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.JunctionMediator;
	
	/**
	 * The main class of the logger for handling pipe messages.
	 */
	public class LoggerJunctionMediator extends JunctionMediator {
		
		public static const NAME:String = "LoggerJunctionMediator";
		
		/**
		 * Constructor.
		 */
		public function LoggerJunctionMediator ( ):void {
			super ( NAME, new Junction ( ) );
		}
		
		/**
		 * Handle our pipe messages.
		 */
		override public function handlePipeMessage ( note:IPipeMessage ):void {
			
		}
		
	}
	
}
