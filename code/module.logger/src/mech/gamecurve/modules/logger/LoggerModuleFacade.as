
////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2008 Mecheye Independent Studios
//  Some Rights Reserved.
//  Source Code written by JP St. Pierre
//
////////////////////////////////////////////////////////////////////////////////


package mech.gamecurve.modules.logger {
	import mech.gamecurve.modules.logger.controller.LogMessageCommand;	
	import mech.gamecurve.modules.logger.controller.StartupCommand;	

	import org.puremvc.as3.multicore.patterns.facade.Facade;
	
	/**
	 * The ModuleFacade for the Logger Module.
	 */
	public class LoggerModuleFacade extends Facade {
		
		public static const STARTUP:String = "startup";
		public static const LOG_MESSAGE:String = "logMessage";
		
		/**
		 * Constructor.
		 */
		public function LoggerModuleFacade ( key:String ):void {
			super ( key );
		}
		
		/**
		 * ModuleFacade factory method.
		 */
		public static function getInstance ( key:String ):LoggerModuleFacade {
			if ( instanceMap [ key ] == null ) instanceMap [ key ] = new LoggerModuleFacade ( key );
			return instanceMap [ key ];
		}
		
		/**
		 * Initialize the controller (and add our commands).
		 */
		override protected function initializeController ( ):void {
			registerCommand ( STARTUP, StartupCommand );
			registerCommand ( LOG_MESSAGE, LogMessageCommand );
		}
		
		/**
		 * Start the module.
		 */
		public function startup ( ):void {
			sendNotification ( STARTUP );
		}
		
		/**
		 * Unload the module.
		 */
		public function dispose ( ):void {
		}
		
	}
}
