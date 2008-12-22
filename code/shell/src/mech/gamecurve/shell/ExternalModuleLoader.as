
////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2008 Mecheye Independent Studios
//  Some Rights Reserved.
//  Source Code written by JP St. Pierre
//
////////////////////////////////////////////////////////////////////////////////


package mech.gamecurve.shell {
	
	import flash.system.ApplicationDomain;
	
	import mx.events.ModuleEvent;
	import mx.modules.ModuleManager;
	import mx.modules.IModuleInfo;
	
	import de.polygonal.ds.LinkedQueue;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	
	/**
	 * Load and instantiate our module SWFs from a URL.
	 */
	public class ExternalModuleLoader {
		
		/**
		 * The name of the notification sent when a module has an error.
		 */
		public static const MODULE_ERROR:String = "moduleError";
		
		/**
		 * The name of the notification sent when a module has load progress.
		 */
		public static const MODULE_PROGRESS:String = "moduleProgress";
		
		/**
		 * The name of the notification sent when a module is ready.
		 */
		public static const MODULE_READY:String = "moduleReady";
		
		/**
		 * The name of the notification sent when a module is set up.
		 */
		public static const MODULE_SETUP:String = "moduleSetup";
		
		/**
		 * The name of the notification sent when a module is unloaded.
		 */
		public static const MODULE_UNLOAD:String = "moduleUnload";
		
		
		/**
		 * The queue to load objects from.
		 */
		private const loadQueue:LinkedQueue = new LinkedQueue ( );

		/**
		 * The facade to send notifications to.
		 */
		private var facade:Facade;
		
		/**
		 * The application domain to load the module into.
		 */
		public var applicationDomain:ApplicationDomain = null;

		/**
		 * Constructor.
		 */
		public function ExternalModuleLoader ( facade:Facade ):void {
			this.facade = facade;
		}
		
		/**
		 * Add a module's URL to the queue. If the queue previously
		 * had no objects, start the queue.
		 */
		public function addModule ( url:String ):void {
			var moduleInfo:IModuleInfo = ModuleManager.getModule ( url );
			loadQueue.enqueue ( moduleInfo );
			if ( loadQueue.size <= 1 ) {
				load ( );
			}
		}
		
		/**
		 * Load a module.
		 */
		protected function load ( ):void {
			var info:IModuleInfo = ( loadQueue.dequeue ( ) as IModuleInfo );
			if ( info != null ) {
				info.addEventListener ( ModuleEvent.ERROR, moduleError );
				info.addEventListener ( ModuleEvent.PROGRESS, moduleProgress );
				info.addEventListener ( ModuleEvent.READY, moduleReady );
				info.addEventListener ( ModuleEvent.SETUP, moduleSetup );
				info.addEventListener ( ModuleEvent.UNLOAD, moduleUnload );
				info.load ( applicationDomain );
			}
		}
		
		/**
		 * @private
		 */
		protected function moduleError ( event:ModuleEvent ):void {
			facade.sendNotification ( MODULE_ERROR, event.errorText );
		}
		
		/**
		 * @private
		 */
		protected function moduleProgress ( event:ModuleEvent ):void {
			facade.sendNotification ( MODULE_PROGRESS, event );
		}
		
		/**
		 * @private
		 */
		protected function moduleReady ( event:ModuleEvent ):void {
			facade.sendNotification ( MODULE_READY, event.target );
		}
		
		/**
		 * @private
		 */
		protected function moduleSetup ( event:ModuleEvent ):void {
			facade.sendNotification ( MODULE_SETUP, event.target );
			// if there are more modules, load the next object.
			if ( loadQueue.size > 0 ) {
				load ( );
			}
		}
		
		/**
		 * @private
		 */
		protected function moduleUnload ( event:ModuleEvent ):void {
			facade.sendNotification ( MODULE_UNLOAD, event.target );
		}
		
	}
}
