
////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2008 Mecheye Independent Studios
//  Some Rights Reserved.
//  Source Code written by JP St. Pierre
//
////////////////////////////////////////////////////////////////////////////////


package mech.gamecurve.shell.view {
	
	import de.polygonal.ds.HashMap;
	
	import mech.gamecurve.common.GamecurveModuleBase;
	import mech.gamecurve.common.IGamecurveModule;
	import mech.gamecurve.common.MessageTypes;
	import mech.gamecurve.common.RedirectMessage;
	import mech.gamecurve.shell.ApplicationFacade;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeMessage;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.Junction;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.JunctionMediator;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.Pipe;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.TeeMerge;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.TeeSplit;
	
	/**
	 * The ShellJunctionMediator controls the interaction between
	 * the shell and the modules loaded.
	 */
	public class ShellJunctionMediator extends JunctionMediator {
		
		public static const NAME:String = "ShellJunctionMediator";
		
		protected var redirectPipe:TeeMerge;
		protected var inputPipe:TeeMerge;
		protected var outputPipe:TeeSplit;
		
		protected const pipeMatches:HashMap = new HashMap ( );
		protected const modules:HashMap = new HashMap ( );
		
		/**
		 * Constructor.
		 */
		public function ShellJunctionMediator ( ):void {
			super ( NAME, new Junction ( ) );
		}
		
		/**
		 * Called when the Mediator is registered.
		 */
		override public function onRegister ( ):void {
			redirectPipe = new TeeMerge ( );
			junction.registerPipe ( GamecurveModuleBase.MODULE_TO_MODULE, Junction.INPUT, redirectPipe );
			junction.addPipeListener ( GamecurveModuleBase.MODULE_TO_MODULE, this, redirectPipeMessage );
			
			inputPipe = new TeeMerge ( );
			junction.registerPipe ( GamecurveModuleBase.MODULE_TO_SHELL, Junction.INPUT, inputPipe );
			junction.addPipeListener ( GamecurveModuleBase.MODULE_TO_SHELL, this, handlePipeMessage );
			
			outputPipe = new TeeSplit ( );
			junction.registerPipe ( GamecurveModuleBase.SHELL_TO_MODULE, Junction.OUTPUT, outputPipe );
		}

		/**
		 * What messages are we interested in?
		 */
		override public function listNotificationInterests ( ):Array {
			return super.listNotificationInterests ( ).concat ( [ApplicationFacade.MODULE_LOADED] );
		}
		
		/**
		 * Handle our notifications.
		 */
		override public function handleNotification ( note:INotification ):void {
			switch ( note.getName ( ) ) {
				case ApplicationFacade.MODULE_LOADED:
					
					// Connect this module to the shell.
					if ( note.getBody ( ) is IGamecurveModule ) {
						
						var module:IGamecurveModule = note.getBody ( ) as IGamecurveModule;
						
						// FIXME: Should we throw an error here?
						if ( modules.find ( module.getInternalName ( ) ) != null ) {
							return;
						}
						
						var moduleToShell:Pipe = new Pipe ( );
						module.acceptOutputPipe ( GamecurveModuleBase.MODULE_TO_SHELL, moduleToShell );
						inputPipe.connectInput ( moduleToShell );
						
						// Interesting communication tidbit.
						var moduleToModule:Pipe = new Pipe ( );
						module.acceptOutputPipe ( GamecurveModuleBase.MODULE_TO_MODULE, moduleToModule );
						redirectPipe.connectInput ( moduleToModule );
						
						var shellToModule:Pipe = new Pipe ( );
						module.acceptInputPipe ( GamecurveModuleBase.SHELL_TO_MODULE, shellToModule );
						outputPipe.connect ( shellToModule );
						junction.registerPipe ( module.getInternalName ( ), Junction.OUTPUT, shellToModule );
						
						for each ( var key:String in pipeMatches.getKeySet ( ) ) {
							if ( isMatch ( key, module.getInternalName ( ) ) ) {
								for each ( var body:Object in pipeMatches.find ( key ) ) {
									var pipe:Pipe = new Pipe ( );
									module.acceptOutputPipe ( body.name, pipe );
									body.pipe.connect ( pipe );
								}
							}
						}
						
						module.startup ( );
						
						modules.insert ( module.getInternalName ( ), module );
						
					}
					break;
				default:
					super.handleNotification ( note );
					break;
			}
		}
		
		/**
		 * Finds modules using the internal name, while
		 * allowing wildcards ("*"). If internalName is blank,
		 * the shell is returned.
		 */
		protected function findModules ( internalName:String ):Array {
			if ( internalName == "" )
				return [ this ];
			
			if ( internalName.indexOf ( "*" ) > 0 ) {
				if ( internalName.length == 1 ) // a lone "*"
					return modules.getKeySet ( ).map ( modules.find );
				
				var filteredModules:Array = [];
				for each ( var key:String in modules.getKeySet ( ) ) {
					if ( isMatch ( internalName, key ) ) filteredModules.push ( modules.find ( key ) );
				}
				return filteredModules;
			}
			return [ modules.find ( internalName ) ];
		}
		
		protected function isMatch ( pattern:String, key:String ):Boolean {
			var parts:Array = pattern.split ( "*" );
			var lastIndex:int = 0;
			for each ( var part:String in parts ) {
				if ( key.indexOf ( part, lastIndex ) < lastIndex ) { // includes -1
					return true;
				}
				lastIndex = key.indexOf( part, lastIndex );
			}
		}
		
		/**
		 * Redirect our pipe message.
		 */
		protected function redirectPipeMessage ( redirMessage:RedirectMessage ):void {
			junction.sendMessage ( redirMessage.moduleKey, redirMessage.message );
		}
		
		/**
		 * Handle our pipe messages.
		 */
		override public function handlePipeMessage ( message:IPipeMessage ):void {
			
			switch ( message.getType ( ) ) {
				case RedirectMessage.REDIRECT:
					// Uh oh... we got a RedirectMessage in MODULE_TO_SHELL
					// Let's try redirecting it.
					redirectPipeMessage ( message as RedirectMessage );
					break;
				case MessageTypes.REQUEST_INPUT_PIPE:
					// REQUEST_INPUT_PIPE:
					// Header = module names (can use wildcards as "*", blank goes to shell)
					// Body   = {name: pipe name, module: the module you sent the message from}
					
					var body:Object = message.getBody ( );
					var sender:IGamecurveModule = body.module as IGamecurveModule;
					var teeSplit:TeeSplit = new TeeSplit ( );
					
					sender.acceptInputPipe ( body.name, teeSplit );
					// if ( body.name)
					//pipeMatches.( message.getHeader ( ) as String, teeSplit );
					var modulePattern:String = message.getHeader ( ) as String;
					if ( modulePattern.indexOf ( "*" ) > 1 ) {
						if ( pipeMatches.containsKey ( modulePattern ) ) {
							pipeMatches.find ( modulePattern ).push ( {name: body.name, pipe: teeSplit} );
						} else {
							pipeMatches.insert ( modulePattern, {name: body.name, pipe: teeSplit} );
						}
					}
					
					var modules:Array = findModules ( modulePattern );
					
					var n:int = modules.length;
					while ( n -- ) {
						var module:IGamecurveModule = modules[n] as IGamecurveModule;
						var outputPipe:Pipe = new Pipe ( );
						module.acceptOutputPipe ( body.name, outputPipe );
						teeSplit.connect ( outputPipe );
					}
					break;
			}
			
		}
		
	}
	
}
