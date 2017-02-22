package com.flashalchemy.pmvc.multicore.pureas3.appskeleton.view.components
{
	
	import flash.display.Sprite;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
		
	public class TitleView extends Sprite 
	{
		private var _title:String;
		private var _css:StyleSheet;
		private var _titleTextField:TextField;
				
		public function TitleView( title:String, css:StyleSheet ) 
		{
			_title = title;
			_css = css; 

			_titleTextField = new TextField();
			_titleTextField.autoSize = TextFieldAutoSize.LEFT;
			_titleTextField.x = 20;
			_titleTextField.y = 20;
			_titleTextField.width = 350;
			_titleTextField.wordWrap = false;
			_titleTextField.multiline = false;
			_titleTextField.styleSheet = _css;
			_titleTextField.htmlText = '<p class="title">' + _title + '</p>';
						
			addChild( _titleTextField );
		}
		
	}
}