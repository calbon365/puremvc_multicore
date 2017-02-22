package com.flashalchemy.pmvc.multicore.pureas3.appskeleton.model.vo
{

	public class SectionVO
	{
		private var _id:uint;
		private var _label:String;
		private var _content:String;
		
		public function SectionVO( id:uint, label:String, content:String )
		{
			_id = id;
			_label = label;
			_content = content;
		}

		public function get id():uint
		{
			return _id;
		}
		
		public function get label():String
		{
			return _label;
		}
		
		public function get content():String
		{
			return _content;
		}
		
	}
}