package
{
	import org.flixel.FlxGame;
	import org.flixel.FlxG;
	
	import flash.display.*;
	import flash.geom.Rectangle;
	import flash.system.fscommand;
	
	[SWF(width = "900", height = "450", backgroundColor = "#FFFFFF")]
//	[Frame(factoryClass="TrolleyProblemPreloader")]
	
	public class TrolleyProblem extends FlxGame
	{
		public function TrolleyProblem() {			
			super(150,75,TitleScreen,Globals.ZOOM_LEVEL);
			
			this.useSoundHotKeys = false;
			FlxG.volume = 1.0;
			FlxG.debug = false; //Globals.DEBUG_MODE;
			FlxG.visualDebug = false; //Globals.DEBUG_HITBOXES;	
			FlxG.mouse.hide();
			
			/////////////////////////////////
			
			
			FlxG.stage.showDefaultContextMenu = false;
			FlxG.stage.displayState = StageDisplayState.FULL_SCREEN;
			FlxG.stage.scaleMode = StageScaleMode.SHOW_ALL;
			FlxG.stage.fullScreenSourceRect = new Rectangle(0,0,900,450);
			
			FlxG.stage.align = StageAlign.TOP;
			
			fscommand("trapallkeys","true");
		}
	}
}