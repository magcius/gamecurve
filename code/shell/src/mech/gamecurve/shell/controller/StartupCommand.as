
////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2008 Mecheye Independent Studios
//  Some Rights Reserved.
//  Source Code written by JP St. Pierre
//
////////////////////////////////////////////////////////////////////////////////


package mech.gamecurve.shell.controller {
	
	import mech.gamecurve.shell.view.ShellJunctionMediator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	/**
	 * Start up the main application/shell.
	 */
	public class StartupCommand extends SimpleCommand implements ICommand {
		
		override public function execute ( note:INotification ):void {
			// Add a junction mediator to process pipe messages.
			facade.registerMediator ( new ShellJunctionMediator ( ) );
		}
		
	}
	
}
