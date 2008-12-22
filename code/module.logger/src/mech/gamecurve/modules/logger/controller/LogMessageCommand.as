
////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2008 Mecheye Independent Studios
//  Some Rights Reserved.
//  Source Code written by JP St. Pierre
//
////////////////////////////////////////////////////////////////////////////////


package mech.gamecurve.modules.logger.controller {
	
	import mech.gamecurve.modules.logger.model.LoggerProxy;	

	import org.puremvc.as3.multicore.interfaces.INotification;	
	import org.puremvc.as3.multicore.interfaces.ICommand;	
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;	
	
	public class LogMessageCommand extends SimpleCommand implements ICommand {

		override public function execute ( note:INotification ):void {
			var proxy:LoggerProxy = facade.retrieveProxy ( LoggerProxy.NAME ) as LoggerProxy;
			proxy.addLogMessage ( note.getBody ( ) );
		}
		
	}
	
}
