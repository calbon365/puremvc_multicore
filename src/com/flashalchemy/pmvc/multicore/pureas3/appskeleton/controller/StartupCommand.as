package com.flashalchemy.pmvc.multicore.pureas3.appskeleton.controller 
{
    import com.flashalchemy.pmvc.multicore.pureas3.appskeleton.model.SiteDataProxy;
    import com.flashalchemy.pmvc.multicore.pureas3.appskeleton.model.StyleSheetProxy;
    import com.flashalchemy.pmvc.multicore.pureas3.appskeleton.model.vo.StatesVO;
    import com.flashalchemy.pmvc.multicore.pureas3.appskeleton.view.StageMediator;
    
    import flash.display.Stage;
    
    import org.puremvc.as3.multicore.interfaces.ICommand;
    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
    import org.puremvc.as3.multicore.patterns.mediator.Mediator;
    import org.puremvc.as3.multicore.utilities.loadup.interfaces.ILoadupProxy;
    import org.puremvc.as3.multicore.utilities.loadup.model.LoadupMonitorProxy;
    import org.puremvc.as3.multicore.utilities.loadup.model.LoadupResourceProxy;
    import org.puremvc.as3.multicore.utilities.statemachine.State;
    import org.puremvc.as3.multicore.utilities.statemachine.StateMachine;

    
    public class StartupCommand extends SimpleCommand implements ICommand 
    {
        private var _monitor:LoadupMonitorProxy;
        
        override public function execute( note:INotification ):void    
        {
            var stage:Stage = note.getBody() as Stage;
            facade.registerMediator( new StageMediator( stage ) );
			
			
			var stateMachine:StateMachine = new StateMachine();
			var states:StatesVO = new StatesVO();
			var state:State = new State(StatesVO.SITE_DATA_LOADING, StatesVO.STATE_ONE_STARTING, StatesVO.STATE_ONE_EXITING, StatesVO.STATE_ONE_CHANGED);
			stateMachine.registerState(state, true);
			
			state = new State(StatesVO.STYLE_SHEET_LOADING, StatesVO.STATE_TWO_STARTING, StatesVO.STATE_TWO_EXITING, StatesVO.STATE_TWO_CHANGED);
			stateMachine.registerState(state);
			
			state = new State(StatesVO.STYLE_SHEET_LOADING, StatesVO.STATE_THREE_STARTING, StatesVO.STATE_THREE_EXITING, StatesVO.STATE_THREE_CHANGED);
			stateMachine.registerState(state);
			
            facade.registerProxy( new LoadupMonitorProxy() );
            _monitor = facade.retrieveProxy( LoadupMonitorProxy.NAME ) as LoadupMonitorProxy;
            //_monitor.defaultTimeout = 30;
            
            //var styleSheetProxy:ILoadupProxy = new StyleSheetProxy();
            //var siteDataProxy:ILoadupProxy = new SiteDataProxy();
            
            var styleSheetProxy:StyleSheetProxy = new StyleSheetProxy();
            var siteDataProxy:SiteDataProxy = new SiteDataProxy();
            
            facade.registerProxy( styleSheetProxy );
            facade.registerProxy( siteDataProxy );
            
            var rStyleSheetProxy:LoadupResourceProxy = makeAndRegisterStartupResource( StyleSheetProxy.SRNAME, styleSheetProxy );
            var rSiteDataProxy:LoadupResourceProxy = makeAndRegisterStartupResource( SiteDataProxy.SRNAME, siteDataProxy );
            
            rSiteDataProxy.requires = [ rStyleSheetProxy ];
			
			facade.registerMediator(stateMachine);
            
            _monitor.loadResources();
        }
		

        private function makeAndRegisterStartupResource( proxyName:String, appResourceProxy:ILoadupProxy ):LoadupResourceProxy 
        {
            var r:LoadupResourceProxy = new LoadupResourceProxy( proxyName, appResourceProxy );
            facade.registerProxy( r );
            _monitor.addResource( r );
            return r;
        }
    }
}