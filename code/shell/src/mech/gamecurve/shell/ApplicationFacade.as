
////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2008 Mecheye Independent Studios
//  Some Rights Reserved.
//  Source Code written by JP St. Pierre
//
////////////////////////////////////////////////////////////////////////////////


package mech.gamecurve.shell {	
	
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	import mech.gamecurve.shell.controller.StartupCommand;
	import mech.gamecurve.shell.controller.StartModuleCommand;

	/**
	 * The main shell Facade.
	 */
	public class ApplicationFacade extends Facade {
		
		/**
		 * The name of the notification sent when a module is loaded. 
		 */
		public static const MODULE_LOADED:String = "moduleLoaded";
		
		/**
		 * The name of the notification sent on application startup.
		 */
		public static const STARTUP:String = "startup";
		
		/**
		 * Constructor.
		 */
		public function ApplicationFacade ( key:String ):void {
			super ( key );
		}
		
		/**
		 * Multiton factory method.
		 */
		public static function getInstance ( key:String ):ApplicationFacade {
			if ( instanceMap [ key ] == null ) instanceMap [ key ] = new ApplicationFacade ( key );
			return instanceMap [ key ] as ApplicationFacade;
		}

		/**
		 * Initialize the controller (and add our commands).
		 */
		override public function initializeController ( ):void {
			super.initializeController ( );
			registerCommand ( STARTUP, StartupCommand );
			registerCommand ( ExternalModuleLoader.MODULE_SETUP, StartModuleCommand );
		}
		
		/**
		 * Function called by MXML to start everything up.
		 */
		public function startup ( ):void {
			sendNotification ( STARTUP, this );
		}
		
	}
	
}
