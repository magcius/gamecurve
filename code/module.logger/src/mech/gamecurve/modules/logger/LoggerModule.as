
////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2008 Mecheye Independent Studios
//  Some Rights Reserved.
//  Source Code written by JP St. Pierre
//
////////////////////////////////////////////////////////////////////////////////


package mech.gamecurve.modules.logger {
	
	import mech.gamecurve.common.GamecurveModuleBase;
	
	/**
	 * The logger module.
	 */
	public class LoggerModule extends GamecurveModuleBase {
		
		/**
		 * Constructor.
		 */
		public function LoggerModule ( ):void {
			super ( LoggerModuleFacade.getInstance ( this.getInternalName ( ) ) );
		}
		
		override public function getName ( ):String {
			return "Logging Module";
		}
		
		override public function getInternalName ( ):String {
			return "mech.gamecurve.modules.logger";
		}
		
		override public function getAuthor ( ):String {
			return "Mecheye Independent Studios";
		}
		
		override public function getVersion ( ):String {
			return "0.1";
		}
		
		override public function getDescription ( ):String {
			return "Adds logging features to gamecurve for debug purposes.";
		}
		
		override public function startup ( ):void {
			( this.facade as LoggerModuleFacade ).startup ( );
		}
		
		override public function dispose ():void {
			( this.facade as LoggerModuleFacade ).dispose ( );
		}
	}
	
}
