package
{
	import flash.events.*;
	import flash.text.*;
	import flash.utils.getDefinitionByName;

	import org.flixel.*;

	public class TitleScreen extends FlxState
	{
		private var _frame:FlxSprite;
		private var _trolley:FlxSprite;
		private var _timer:FlxTimer;
		private var _title1:TextField;
		private var _title2:TextField;
		private var _titleFormat:TextFormat = new TextFormat("COMMODORE",50,0x000000,null,null,null,null,null,"center");
		private var _continue:TextField;
		private var _continueFormat:TextFormat = new TextFormat("COMMODORE",24,0x000000,null,null,null,null,null,"center");
		
		private var _soundTrack:FlxSound;
		
		public function TitleScreen() {
			super();
		}
		
		public override function create():void {
			super.create();
			
			FlxG.stage.focus = null;
			
			FlxG.bgColor = 0xFFFFFFFF;
			
			_soundTrack = new FlxSound();
			_soundTrack.loadEmbedded(Assets.SoundTrack,true);
			_soundTrack.play();
			
			Assets._hit = new FlxSound();
			Assets._hit.loadEmbedded(Assets.HitSound);
			
			_frame = new FlxSprite(0,0);
			_frame.loadGraphic(Assets.FrameSS,false,false,FlxG.width,FlxG.height);
			
			_trolley = new FlxSprite(0,0);
			_trolley.loadGraphic(Assets.TrolleySS,true,false,11,11);
			_trolley.x = FlxG.width/2 - _trolley.width/2;
			_trolley.y = FlxG.height/2 - _trolley.height/2;
			_trolley.visible = false;
			
			_title1 = new TextField();
			_title1.defaultTextFormat = _titleFormat;
			_title1.embedFonts = true;
			_title1.wordWrap = true;
			_title1.autoSize = "left";
			_title1.selectable = false;
			
			_title1.width = (FlxG.width * Globals.ZOOM_LEVEL); 
			_title1.visible = true;
			
			_title1.text = "TROLLEY";
			
			_title1.x = -_title1.width;
			_title1.y = 50;
			
			_title2 = new TextField();
			_title2.defaultTextFormat = _titleFormat;
			_title2.embedFonts = true;
			_title2.wordWrap = true;
			_title2.autoSize = "left";
			_title2.selectable = false;
			
			_title2.width = (FlxG.width * Globals.ZOOM_LEVEL); 
			_title2.visible = true;
			_title2.text = "PROBLEM";
			
			_title2.x = _title1.width;
			_title2.y = 100;

			_continue = new TextField();
			_continue.defaultTextFormat = _continueFormat;
			_continue.embedFonts = true;
			_continue.wordWrap = true;
			_continue.autoSize = "left";
			_continue.selectable = false;
			
			_continue.width = (FlxG.width * Globals.ZOOM_LEVEL); 
			_continue.visible = false;
			_continue.text = "( PRESS SPACE TO BEGIN )";
			
			_continue.x = 0;
			_continue.y = 330;
			
			add(_frame);
			add(_trolley);
			FlxG.stage.addChild(_title1);
			FlxG.stage.addChild(_title2);
			FlxG.stage.addChild(_continue);			
		}
		
		public override function update():void {
			super.update();
			
			if (_title1.x < 0) {
				_title1.x+=10;
			}
			if (_title2.x > 0) {
				_title2.x-=10;
			}
			if (_title1.x == 0 && _title2.x == 0 && _timer == null) {
				_timer = new FlxTimer();
				_timer.start(1,1,showTrolley);
			}
			
		}
		
		private function showTrolley(t:FlxTimer):void {
			_trolley.visible = true;
			_timer.start(1,1,showContinue);
		}
		
		private function showContinue(t:FlxTimer):void {
			_continue.visible = true;
			FlxG.stage.addEventListener(KeyboardEvent.KEY_UP,startGame);
		}
		
		private function startGame(e:KeyboardEvent):void {
			if (e.keyCode == 32) {
				FlxG.stage.removeEventListener(KeyboardEvent.KEY_UP,startGame);
				
				Cookie.load();
				Cookie.erase();
				Cookie.flush();
				Cookie.load();
				
				//Cookie.currentStage = "Standard";
				
				FlxG.switchState(new Tutorial());

//				if (Cookie.currentStage == "Tutorial" || Cookie.currentStage == "") {
//					FlxG.switchState(new Tutorial());
//				}
//				else if (Cookie.currentStage == "Standard") {
//					FlxG.switchState(new Standard());
//				}
//				else if (Cookie.currentStage == "Loop") {
//					FlxG.switchState(new Loop());
//				}
//				else if (Cookie.currentStage == "Shove") {
//					FlxG.switchState(new Shove());
//				}
//				else if (Cookie.currentStage == "Personal") {
//					FlxG.switchState(new Personal());
//				}
//				else if (Cookie.currentStage == "Results") {
//					FlxG.switchState(new Results());
//				}
			}
		}
		
		public override function destroy():void {			
			_timer.destroy();
			_trolley.destroy();
			_frame.destroy();
			_soundTrack.destroy();
			
			FlxG.stage.removeChild(_title1);
			FlxG.stage.removeChild(_title2);
			FlxG.stage.removeChild(_continue);
			
			FlxG.stage.focus = null;
			
			super.destroy();
		}
	}
}