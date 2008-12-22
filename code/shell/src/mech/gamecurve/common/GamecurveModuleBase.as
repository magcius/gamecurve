
////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2008 Mecheye Independent Studios
//  Some Rights Reserved.
//  Source Code written by JP St. Pierre
//
////////////////////////////////////////////////////////////////////////////////


package mech.gamecurve.common {
	
	import mx.modules.ModuleBase;
	
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeAware;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeFitting;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.JunctionMediator;	
	
	/**
	 * A base class for a PureMVC compatible Flex Module. 
	 */
	public class GamecurveModuleBase extends ModuleBase implements IPipeAware, IGamecurveModule {
		
		/**
		 * The pipe name for communicating messages from modules to the shell.
		 */
		public static const MODULE_TO_MODULE:String = "moduleToModule";
		
		/**
		 * The pipe name for communicating messages from modules to the shell.
		 */
		public static const MODULE_TO_SHELL:String = "moduleToShell";
		
		/**
		 * The pipe name for communicating messages from the shell to modules.
		 */
		public static const SHELL_TO_MODULE:String = "shellToModule";
		/**
		 * The module's facade.
		 */
		protected var facade:IFacade;
		
		/**
		 * Constructor.
		 * In subclasses, pass your application facade in here.
		 */
		public function GamecurveModuleBase ( facade:IFacade ):void {
			super ( );
			this.facade = facade;
		}
		
		/**
		 * The module's name. Must be overridden.
		 */
		public function getName ( ):String {
			throw new AbstractClassError ( "GamecurveModuleBase::getName() must be overridden." );
		}
		
		/**
		 * The modules's unique internal name
		 * used to pass messages through the system.
		 * Must be overridden.
		 */
		public function getInternalName ( ):String {
			throw new AbstractClassError ( "GamecurveModuleBase::getInternalName() must be overridden." );
		}
		
		/**
		 * The module's version. Must be overridden.
		 */
		public function getVersion ( ):String {
			throw new AbstractClassError ( "GamecurveModuleBase::getVersion() must be overridden." );
		}
		
		/**
		 * The author of this gamecurve module. Must be overridden.
		 */
		public function getAuthor ( ):String {
			throw new AbstractClassError ( "GamecurveModuleBase::getAuthor() must be overridden." );
		}
		
		/**
		 * A short summary of the module and what its features are.
		 * Must be overridden.
		 */
		public function getDescription ( ):String {
			throw new AbstractClassError ( "GamecurveModuleBase::getDescription() must be overridden." );
		}
		
		/**
		 * Called when the module is loaded. Must be overridden.
		 */
		public function startup ( ):void {
			throw new AbstractClassError ( "GamecurveModuleBase::startup() must be overridden." );
		}
		
		/**
		 * Called when the module is unloaded and needs to be disposed.
		 * Must be overridden.
		 */
		public function dispose ( ):void {
			throw new AbstractClassError ( "GamecurveModuleBase::dispose() must be overridden." );
		}
		
		/**
		 * Accept an input pipe.
		 * Registers an input pipe with this module's Junction.
		 */
		public function acceptInputPipe ( name:String, pipe:IPipeFitting ):void {
			facade.sendNotification ( JunctionMediator.ACCEPT_INPUT_PIPE, pipe, name );
		}
		
		/**
		 * Accept an output pipe.
		 * Registers an output pipe with this module's Junction.
		 */
		public function acceptOutputPipe ( name:String, pipe:IPipeFitting ):void {
			facade.sendNotification ( JunctionMediator.ACCEPT_OUTPUT_PIPE, pipe, name );
		}
		
		
	}
}
