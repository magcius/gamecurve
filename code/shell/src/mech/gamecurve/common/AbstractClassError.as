
////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2008 Mecheye Independent Studios
//  Some Rights Reserved.
//  Source Code written by JP St. Pierre
//
////////////////////////////////////////////////////////////////////////////////


package mech.gamecurve.common {
	
	/**
	 * Error thrown when 
	 */
	public class AbstractClassError extends Error {
		
		/**
		 * Constructor.
		 */
		public function AbstractClassError ( message:String, id:int = 0 ):void {
			super ( message, id );
		}
		
		/**
		 * Returns a string representation of this Error object.
		 */
		public function toString ( ):String {
			return "Abstract Class error: " + message;
		}
		
	}
	
}
