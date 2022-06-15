package
{
	
	import flash.text.*;
	
	import org.flixel.*;

	public class Results extends FlxState
	{
		protected var _timer:FlxTimer;
		protected var _frame:FlxSprite;
		protected var _resultText:TextField;
		protected var _resultFormat:TextFormat = new TextFormat("COMMODORE",20,0x000000,null,null,null,null,null,"left",null,null);
		protected var _thanksFormat:TextFormat = new TextFormat("COMMODORE",20,0xFF0000,null,null,null,null,null,"left",null,null);

		public function Results() {
		}
		
		public override function create():void {
			super.create();
			
			Cookie.currentStage = "Results";
			Cookie.flush();
			
			_timer = new FlxTimer();
			
			_resultText = new TextField();
			
			_resultText.defaultTextFormat = _resultFormat;
			_resultText.embedFonts = true;
			_resultText.wordWrap = true;
			_resultText.autoSize = "left";
			_resultText.selectable = false;
			
			_resultText.width = (FlxG.width * Globals.ZOOM_LEVEL) - 100; 
			_resultText.height = (FlxG.height * Globals.ZOOM_LEVEL) - 100;
			_resultText.visible = true;
			
			_resultText.x = 50;
			_resultText.y = 0 + 50;
			
			_resultText.text = "TROLLEY PROBLEM RESULTS\n\n";
			_resultText.appendText(Cookie.standardDecision + "\n\n");
			_resultText.appendText(Cookie.loopDecision + "\n\n");
			_resultText.appendText(Cookie.shoveDecision + "\n\n");
			_resultText.appendText(Cookie.personalDecision);
			
			FlxG.stage.addChild(_resultText);
			trace("Added result text: " + _resultText.text);
			
			_frame = new FlxSprite(0,0);
			_frame.loadGraphic(Assets.FrameSS,false,false,FlxG.width,FlxG.height);
			add(_frame);
			trace("Added frame.");
			
			_timer.start(2,1,thankYou);
			
		}
		
		private function thankYou(t:FlxTimer):void {
			var end:uint = _resultText.text.length;
			_resultText.appendText("\n\nTHANKS FOR PLAYING TROLLEY PROBLEM.");
			_resultText.setTextFormat(_thanksFormat,end,_resultText.text.length);
		}
		
		public override function update():void {
			super.update();
			
			if (FlxG.keys.ESCAPE)
			{
				FlxG.switchState(new TitleScreen);
			}
		}
		
		public override function destroy():void {
			super.destroy();
			
			_timer.destroy();
			_frame.destroy();
			if (_resultText != null && FlxG.stage.contains(_resultText)) FlxG.stage.removeChild(_resultText);
		}
	}
}