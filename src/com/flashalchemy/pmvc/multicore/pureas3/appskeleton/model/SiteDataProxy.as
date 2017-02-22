package com.flashalchemy.pmvc.multicore.pureas3.appskeleton.model 
{

	import com.flashalchemy.pmvc.multicore.pureas3.appskeleton.ApplicationFacade;
	import com.flashalchemy.pmvc.multicore.pureas3.appskeleton.model.EntityProxy;
	import com.flashalchemy.pmvc.multicore.pureas3.appskeleton.model.vo.SectionVO;
	import com.flashalchemy.pmvc.multicore.pureas3.appskeleton.view.StageMediator;
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	import org.puremvc.as3.multicore.utilities.loadup.interfaces.ILoadupProxy;
	import org.puremvc.as3.multicore.utilities.statemachine.State;
	import org.puremvc.as3.multicore.utilities.statemachine.StateMachine;
	
	public class SiteDataProxy extends EntityProxy implements ILoadupProxy
	{
		public static const NAME:String = "SiteDataProxy";
        public static const SRNAME:String = "SiteDataSRProxy";
		
		private var stateMachine:StateMachine;


		public function SiteDataProxy() 
		{
			super( NAME );	
			var AppFac:ApplicationFacade = ApplicationFacade.getInstance();
			stateMachine = new StateMachine();
		}
		
		public function load() :void 
		{
            sendNotification( ApplicationFacade.SITE_DATA_LOADING );
	//		stateMachine.sendNotification(stateMachine.statesMachine.STATE)
			var request:URLRequest = new URLRequest("data.xml");
			var loader:URLLoader = new URLLoader();
			
			loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
            loader.addEventListener(Event.COMPLETE, loaderCompleteHandler);
			
			loader.load(request);

        }
		
		private function loaderCompleteHandler(event:Event):void 
		{			
			var xml:XML = new XML( event.target.data );
			xml.ignoreWhitespace = true;
			
			var title:String = xml.title.children().toXMLString();
			var sections:Array = new Array();
			var sectionsXMLList:XMLList = xml.sections.section;
			
			for ( var i:uint=0; i<sectionsXMLList.length(); i++ )
			{
				var section:XML = sectionsXMLList[i];
				var id:uint = section.@id;
				var sectionVO:SectionVO = new SectionVO( id, section.@label, section.content );
				sections.push( sectionVO );
			}
			
			data = new Object();
			data.title = title;
			data.sections = sections;
			
			sendLoadedNotification( ApplicationFacade.SITE_DATA_LOADED, NAME, SRNAME );
		}
		
		private function errorHandler(e:IOErrorEvent):void 
		{
            sendLoadedNotification( ApplicationFacade.SITE_DATA_FAILED, NAME, SRNAME );
        }
		
		public function get title():String
        {
            return data.title as String;
        }
		
		public function get sections():Array
        {
            return data.sections as Array;
        }

	}
}