package com.flashalchemy.pmvc.multicore.pureas3.appskeleton.model.vo
{

	import flash.utils.Dictionary;
	
	public class StatesVO
	{
		private var _state:String;
		
		public static const STATE_ONE:String = 'starting up';
		public static const STATE_ONE_STARTING:String = 'entering startup';
		public static const STATE_ONE_EXITING:String = 'exiting startup';
		public static const STATE_ONE_CHANGED:String = 'changed startup';
		
		public static const STYLE_SHEET_LOADING:String = 'styleSheetLoading';
		public static const STATE_TWO_STARTING:String = 'entering stylesheet';
		public static const STATE_TWO_EXITING:String = 'exiting stylesheet';
		public static const STATE_TWO_CHANGED:String = 'changed stylesheet';
		
		public static const SITE_DATA_LOADING:String = 'siteDataLoading';
		public static const STATE_THREE_STARTING:String = 'entering data xml loading';
		public static const STATE_THREE_EXITING:String = 'exiting data xml loading';
		public static const STATE_THREE_CHANGED:String = 'changed data xml loading';
		
		private var stateTest:Dictionary = new Dictionary();
		
		private static const UNLOCKED:uint = 0;
		private static const ACTIVE:uint = 1;
		private static const LOCKED:uint = 2;
		
		/**
		 * Lock
		 */
		private static var instanceLock:uint = UNLOCKED;
		private static var instance:StatesVO;
		/**
		 * Instance holder
		 */
		public static function getInstance():StatesVO
		{
			if (instanceLock == UNLOCKED)
			{
				instanceLock = ACTIVE;
				instance = new StatesVO();
				instanceLock = LOCKED;
			}
			
			return instance;
		}
		
		/**
		 * @throws Error
		 */
		public function StatesVO()
		{
			
			if (instanceLock == ACTIVE)
			{
				try
				{
					// YOUR INSTANTIATION CODE
					trace('New instantiation code')
				}
				catch (Error)
				{
					// if instantiation failed, keep the class usable
					instanceLock = UNLOCKED;
				}
			}
			else
			{
				//throw new Error("Singleton ERROR: " + instanceLock == UNLOCKED ? "Using class constructor is not allowed!" : "Multiple instances of " + this + " are not allowed!");
			}
		}


		public function get state():String
		{
			return _state;
		}
		

	}
}