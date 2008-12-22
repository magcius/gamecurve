
////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2008 Mecheye Independent Studios
//  Some Rights Reserved.
//  Source Code written by JP St. Pierre
//
////////////////////////////////////////////////////////////////////////////////


package mech.gamecurve.modules.logger.model {
	
	public interface ILogMessage {
		
		/**
		 * The senderModule property should contain
		 * the internal name of the module that sent
		 * this message.
		 */
		function get senderModule ( ):String;
		
		/**
		 * The senderComponent property should contain
		 * the specific component in the module that
		 * sent this message.
		 */
		function get senderComponent ( ):String;
		
		/**
		 * The log message.
		 */
		function get message ( ):String;
		
		/**
		 * The time this message was created and sent.
		 */
		function get timeSent ( ):Date;
		
		/**
		 * Returns a textual representation of this log message.
		 */
		function toString ( ):String;
		
	}
	
}