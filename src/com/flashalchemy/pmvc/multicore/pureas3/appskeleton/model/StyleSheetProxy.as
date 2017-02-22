package com.flashalchemy.pmvc.multicore.pureas3.appskeleton.model 
{
	import com.flashalchemy.pmvc.multicore.pureas3.appskeleton.ApplicationFacade;
	import com.flashalchemy.pmvc.multicore.pureas3.appskeleton.model.EntityProxy;
	
	import flash.events.*;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.StyleSheet;
	
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	import org.puremvc.as3.multicore.utilities.loadup.interfaces.ILoadupProxy;
	
	public class StyleSheetProxy extends EntityProxy implements ILoadupProxy
	{
		public static const NAME:String = "StyleSheetProxy";
        public static const SRNAME:String = "StyleSheetSRProxy";

		public function StyleSheetProxy() 
		{
			super( NAME );
		}
		
		public function load() :void 
		{
            sendNotification( ApplicationFacade.STYLE_SHEET_LOADING );
			
			var request:URLRequest = new URLRequest("styles.css");
			var loader:URLLoader = new URLLoader();
			
			loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
            loader.addEventListener(Event.COMPLETE, loaderCompleteHandler);
			
			loader.load(request);
        }
		
		private function loaderCompleteHandler(event:Event):void 
		{
			data = new StyleSheet();
			data.parseCSS( URLLoader(event.target).data );
			sendLoadedNotification( ApplicationFacade.STYLE_SHEET_LOADED, NAME, SRNAME );
		}
		
		private function errorHandler(e:IOErrorEvent):void 
		{
            sendLoadedNotification( ApplicationFacade.STYLE_SHEET_FAILED, NAME, SRNAME );
        }
		
		public function get css():StyleSheet
        {
            return data as StyleSheet;
        }

	}
}