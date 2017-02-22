package com.flashalchemy.pmvc.multicore.pureas3.appskeleton
{
    import com.flashalchemy.pmvc.multicore.pureas3.appskeleton.controller.StartupCommand;
    
    import org.puremvc.as3.multicore.interfaces.IFacade;
    import org.puremvc.as3.multicore.patterns.facade.Facade;
    import org.puremvc.as3.multicore.utilities.loadup.controller.LoadupResourceFailedCommand;
    import org.puremvc.as3.multicore.utilities.loadup.controller.LoadupResourceLoadedCommand;
    import org.puremvc.as3.multicore.utilities.statemachine.StateMachine;
    
    public class ApplicationFacade extends Facade implements IFacade 
    {
        public static const NAME:String                         = "appFacade";
        public static const STARTUP:String          			= "startup";		
        public static const STYLE_SHEET_LOADING:String 			= "styleSheetLoading";
        public static const STYLE_SHEET_LOADED:String 			= "styleSheetLoaded";
        public static const STYLE_SHEET_FAILED:String 			= "styleSheetFailed";		
        public static const SITE_DATA_LOADING:String 			= "siteDataLoading";
        public static const SITE_DATA_LOADED:String 			= "siteDataLoaded";
        public static const SITE_DATA_FAILED:String 		    = "siteDataFailed";	
        
        private static var instance:ApplicationFacade;
		
		public static var _stateMachine:StateMachine;
        
        public function ApplicationFacade() {
			_stateMachine = new StateMachine();
            super(NAME);
			
        }
		
		public static function get stateMachine():StateMachine{
			return _stateMachine;
		}
		
		
        public static function getInstance(): ApplicationFacade 
        {            
            if (instance == null) 
            {
                instance = new ApplicationFacade();
            }
            return instance as ApplicationFacade;
        }
        
        override protected function initializeController():void 
        {
            super.initializeController();		
            registerCommand( STARTUP, StartupCommand );			
            
            registerCommand( STYLE_SHEET_LOADED, LoadupResourceLoadedCommand );
            registerCommand( SITE_DATA_LOADED, LoadupResourceLoadedCommand );
            
            registerCommand( STYLE_SHEET_FAILED, LoadupResourceFailedCommand );
            registerCommand( SITE_DATA_FAILED, LoadupResourceFailedCommand );
        }
        
        public function startup( stage:Object ):void 
        {
            sendNotification( STARTUP, stage );
        }
        
    }
}