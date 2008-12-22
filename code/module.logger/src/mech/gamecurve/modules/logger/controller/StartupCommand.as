
////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2008 Mecheye Independent Studios
//  Some Rights Reserved.
//  Source Code written by JP St. Pierre
//
////////////////////////////////////////////////////////////////////////////////


package mech.gamecurve.modules.logger.controller {
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	import mech.gamecurve.modules.logger.model.LoggerProxy;
	import mech.gamecurve.modules.logger.view.LoggerJunctionMediator;
	
	/**
	 * Start up the logger module.
	 */
	public class StartupCommand extends SimpleCommand implements ICommand {
		
		override public function execute ( note:INotification ):void {
			// Add our data.
			facade.registerProxy ( new LoggerProxy ( ) );
			// Add our junction mediator to recieve/send pipe messages.
			facade.registerMediator ( new LoggerJunctionMediator ( ) );
		}
		
	}
	
}