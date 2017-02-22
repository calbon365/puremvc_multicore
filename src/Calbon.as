package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import com.flashalchemy.pmvc.multicore.pureas3.appskeleton.ApplicationFacade;
	
	public class Calbon extends Sprite
	{
		public function Calbon()
		{
			super();
			
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			var facade:ApplicationFacade = ApplicationFacade.getInstance();
			facade.startup( this.stage );
			
		}
	}
}