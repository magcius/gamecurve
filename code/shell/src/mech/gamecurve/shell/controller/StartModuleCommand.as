
////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2008 Mecheye Independent Studios
//  Some Rights Reserved.
//  Source Code written by JP St. Pierre
//
////////////////////////////////////////////////////////////////////////////////


package mech.gamecurve.shell.controller {

	import flash.events.IEventDispatcher;
	
	import mx.core.IFlexModuleFactory;
	import mx.events.FlexEvent;
	import mx.modules.IModuleInfo;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	import mech.gamecurve.common.IGamecurveModule;
	import mech.gamecurve.shell.ApplicationFacade;
	import mech.gamecurve.shell.ExternalModuleLoader;
	
	/**
	 * Start a module.
	 */
	public class StartModuleCommand extends SimpleCommand implements ICommand {
		
		private var module:IEventDispatcher;
		
		override public function execute ( note:INotification ):void {
			
			// Start the module.
			var moduleInfo:IModuleInfo = ( note.getBody ( ) as IModuleInfo );
			module = moduleInfo.factory.create ( ) as IEventDispatcher;
			
			// If the loaded SWF is not a Gamecurve Module, send an error.
			if ( !module is IGamecurveModule ) {
				module = null;
				moduleInfo.error = true;
				sendNotification ( ExternalModuleLoader.MODULE_ERROR, moduleInfo );
			}
			
			module.addEventListener ( FlexEvent.INITIALIZE, moduleReady );
			
		}
		
		private function moduleReady ( event:FlexEvent ):void {
			sendNotification ( ApplicationFacade.MODULE_LOADED, module );
		}
		
	}
	
}
