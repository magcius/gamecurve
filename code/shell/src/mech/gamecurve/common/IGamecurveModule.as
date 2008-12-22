
////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2008 Mecheye Independent Studios
//  Some Rights Reserved.
//  Source Code written by JP St. Pierre
//
////////////////////////////////////////////////////////////////////////////////


package mech.gamecurve.common {
	
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeAware;	

	/**
	 * Gamecurve Module interface.
	 * 
	 * Used to describe modules that can interact with the gamecurve core.
	 */
	public interface IGamecurveModule extends IPipeAware {
		
		/**
		 * The module's name.
		 */
		function getName ( ):String;
		
		/**
		 * The modules's unique internal name
		 * used to pass messages through the system.
		 */
		function getInternalName ( ):String;
		
		/**
		 * The module's version.
		 */
		function getVersion ( ):String;
		
		/**
		 * The author of this gamecurve module.
		 */
		function getAuthor ( ):String;
		
		/**
		 * A short summary of the module and what its features are.
		 */
		function getDescription ( ):String;
		
		/**
		 * Called when the module is loaded.
		 */
		function startup ( ):void;
		
		/**
		 * Called when the module is unloaded and needs to be disposed.
		 */
		function dispose ( ):void;
		
	}
}
