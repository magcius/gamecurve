
////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2008 Mecheye Independent Studios
//  Some Rights Reserved.
//  Source Code written by JP St. Pierre
//
////////////////////////////////////////////////////////////////////////////////


package mech.gamecurve.modules.logger.model {
	
	import mx.collections.ArrayCollection;
	
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	
	public class LoggerProxy extends Proxy {
		
		public static const NAME:String = "LoggerProxy";
		
		/**
		 * Constructor.
		 */
		public function LoggerProxy ( ):void {
			super ( NAME, new ArrayCollection ( ) );
		}
		
		/**
		 * Add a log message to the array.
		 */
		public function addLogMessage ( msg:Object ):void {
			messages.addItem ( msg );
		}
		
		public function get messages ( ):ArrayCollection {
			return data as ArrayCollection;
		}
	}
}
