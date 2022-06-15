package
{
	import flash.events.*;
	import flash.text.*;
	import flash.utils.getDefinitionByName;
	
	import org.flixel.*;
	
	
	public class GameStage extends FlxState {
		
		protected const TRACK_BOTTOM:uint = 0;
		protected const TRACK_TOP:uint = 1;
		
		protected const PIVOT_X:uint = 81;
		protected const TOP_TRACK_Y:uint = 12;
		protected const BOTTOM_TRACK_Y:uint = 33;
		
		protected const TROLLEY_RIGHT:uint = 0;
		protected const TROLLEY_UP:uint = 1;
		protected const TROLLEY_DOWN:uint = 2;
		
		// FRAME
		protected var _frame:FlxSprite;
		
		// TRACK
		protected var _track:FlxSprite;
		
		// TROLLEY
		protected var _trolley:FlxSprite;
		protected var _trolleyPath:FlxPath;
		protected var _pivotPoint:FlxPoint;
		protected var _point1:FlxPoint;
		protected var _point2:FlxPoint;
		protected var _point3:FlxPoint;
		
		// PEOPLE
		protected var _lowerPerson1:Person;
		protected var _lowerPerson2:Person;
		protected var _lowerPerson3:Person;
		protected var _upperPerson:Person;
		
		// SWITCH
		protected var _switch:FlxSprite;
		
		// BRIDGE
		protected var _bridge:FlxSprite;
		
		
		// TEXT
		protected var _explanationText:TextField;
		protected var _resultText:TextField;
		protected var _textFormat:TextFormat = new TextFormat("COMMODORE",20,0x000000);
		protected var _resultFormat:TextFormat = new TextFormat("COMMODORE",20,0xFFFFFF,null,null,null,null,null,"center",null,null);
		protected var _resultBG:FlxSprite;
		
		protected var _currentExplanationIndex:uint = 0;
		
		protected var _explanationDone:Boolean = false;
		protected var _stageReady:Boolean = false;
		protected var _resultDisplayed:Boolean = false;
		
		protected var _explanationTexts:Array;
		
		protected var _personName:TextField;
		protected var _personNameFormat:TextFormat = new TextFormat("COMMODORE",20,0x000000,null,null,null,null,null,"center",null,null);
		protected var _personNameDeadFormat:TextFormat = new TextFormat("COMMODORE",20,0xFF0000,null,null,null,null,null,"center",null,null);
		
		
		// TIMER
		protected var _timer:FlxTimer;
		
		// NEXT STAGE
		protected var _nextStage:String = "";
		protected var _currentStage:String;
		protected var _switchStage:Boolean = false;
		protected var _decision:int = -1;
		protected var _endingStage:Boolean = false;
		
		public function GameStage() {
			super();
		}
		
		public override function create():void {
			
			super.create();
			
//			FlxG.volume = 0.3;
			
			// TIMER
			_timer = new FlxTimer();
			
			// TEXTS		
			_explanationText = new TextField();
			_explanationText.defaultTextFormat = _textFormat;
			_explanationText.embedFonts = true;
			_explanationText.wordWrap = true;
			_explanationText.autoSize = "left";
			_explanationText.selectable = false;
			
			_explanationText.width = (FlxG.width * Globals.ZOOM_LEVEL) - 100; 
			_explanationText.height = (FlxG.height * Globals.ZOOM_LEVEL) - 40;
			_explanationText.visible = true;
			
			_explanationText.x = 50;
			_explanationText.y = (FlxG.height * Globals.ZOOM_LEVEL) - 160;
			
			_currentExplanationIndex = 0;
			
			FlxG.stage.addChild(_explanationText);
		}
		
		public override function update():void {
			super.update();
			
			if (_trolley.velocity.y < 0) {
				_trolley.frame = TROLLEY_UP;
			}
			else if (_trolley.velocity.y > 0) {
				_trolley.frame = TROLLEY_DOWN;
			}
			else if (_trolley.velocity.x > 0) {
				_trolley.frame = TROLLEY_RIGHT;
			}
			
			if (FlxG.keys.ESCAPE)
			{
				FlxG.switchState(new TitleScreen);
			}
		}
		
		protected function explanationHandler(t:FlxTimer):void {
			if (_currentExplanationIndex < _explanationTexts.length) {
				_explanationText.visible = true;
				_explanationText.text = _explanationTexts[_currentExplanationIndex];
				_currentExplanationIndex++;
				FlxG.stage.addEventListener(KeyboardEvent.KEY_UP,explanationKeyUp);
			}
			else {
				t.start(1,1,startTrolley);
				FlxG.stage.addEventListener(KeyboardEvent.KEY_DOWN,decisionKeyUp);
			}
		}
		
		protected function explanationKeyUp(e:KeyboardEvent):void {
			if (_currentStage == "Personal" && _currentExplanationIndex == 3) {
				if (String.fromCharCode(e.charCode).toUpperCase() == "W") {
					_personName.text = "YOUR WIFE";
				}
				else if (String.fromCharCode(e.charCode).toUpperCase() == "H") {
					_personName.text = "YOUR HUSBAND";
				}
				else if (String.fromCharCode(e.charCode).toUpperCase() == "M") {
					_personName.text = "YOUR MOTHER";
				}
				else if (String.fromCharCode(e.charCode).toUpperCase() == "F") {
					_personName.text = "YOUR FATHER";
				}
				else if (String.fromCharCode(e.charCode).toUpperCase() == "S") {
					_personName.text = "YOUR SISTER";
				}
				else if (String.fromCharCode(e.charCode).toUpperCase() == "B") {
					_personName.text = "YOUR BROTHER";
				}
				else if (String.fromCharCode(e.charCode).toUpperCase() == "D") {
					_personName.text = "YOUR DAUGHTER";
				}
				else if (String.fromCharCode(e.charCode).toUpperCase() == "N") {
					_personName.text = "YOUR SON";
				}
				else if (String.fromCharCode(e.charCode).toUpperCase() == "G") {
					_personName.text = "YOUR GIRLFRIEND";
				}
				else if (String.fromCharCode(e.charCode).toUpperCase() == "O") {
					_personName.text = "YOUR BOYFRIEND";
				}
				if (_personName.text != "") {
					_explanationText.visible = false;
					_timer.start(1,1,explanationHandler);
					_explanationTexts[2] += _personName.text.toLowerCase() + ".";
					FlxG.stage.removeEventListener(KeyboardEvent.KEY_UP,explanationKeyUp);
				}
			}
			else if (e.keyCode == 32) {
				_explanationText.visible = false;
				_timer.start(0.2,1,explanationHandler);
				FlxG.stage.removeEventListener(KeyboardEvent.KEY_UP,explanationKeyUp);
			}
		}
		
		protected function startTrolley(t:FlxTimer):void {
			_trolley.followPath(_trolleyPath,20);
		}
		
		protected function decisionKeyUp(e:KeyboardEvent):void {
			if (e.keyCode != 32) return;		
			
			// This won't work in all situations.
			if (_trolley.x > _pivotPoint.x - _trolley.width) return;
			if (_upperPerson != null && _trolley.x + _trolley.width >= _upperPerson.x && Cookie.currentStage == "Personal") return;

			_decision = 1;
			
			FlxG.stage.removeEventListener(KeyboardEvent.KEY_DOWN,decisionKeyUp);
			
			// Play a sound
			Assets._hit.play(true);
		}
		
		
		protected function endStage(t:FlxTimer):void {
			
			if (_personName != null) _personName.visible = false;
			
			_resultBG = new FlxSprite(0,0);
			_resultBG.makeGraphic(FlxG.width,FlxG.height,0xFF000000);
			add(_resultBG);
			
			_resultText = new TextField();
			_resultText.defaultTextFormat = _resultFormat;
			_resultText.embedFonts = true;
			_resultText.wordWrap = true;
			_resultText.autoSize = "left";
			_resultText.selectable = false;
			
			if (_decision == 1) {
				if (Cookie.currentStage == "Shove") {
					_resultText.text = "YOU SHOVED THE VERY LARGE PERSON.\n\nOKAY.";
				}
				else {
					_resultText.text = "YOU PULLED THE SWITCH.\n\nOKAY.";
				}
			}
			else if (_decision == -1) {
				if (Cookie.currentStage == "Shove") {
					_resultText.text = "YOU DIDN'T SHOVE THE VERY LARGE PERSON.\n\nOKAY.";
				}
				else {
					_resultText.text = "YOU DIDN'T PULL THE SWITCH.\n\nOKAY.";
				}
			}
			
			_resultText.width = (FlxG.width * Globals.ZOOM_LEVEL) - 40; 
			_resultText.height = (FlxG.height * Globals.ZOOM_LEVEL) - 40;
			_resultText.visible = true;
			
			_resultText.x = 20;
			_resultText.y = (FlxG.height * Globals.ZOOM_LEVEL) / 2 - 50;
			
			FlxG.stage.addChild(_resultText);
			
			_timer.start(2,1,nextStage);	
		}
		
		private function nextStage(t:FlxTimer):void {
			FlxG.stage.addEventListener(KeyboardEvent.KEY_DOWN,nextStagePressed);
			_resultText.appendText("\n\n(PRESS SPACE)");
		}
		
		private function nextStagePressed(e:KeyboardEvent):void {
			if (e.keyCode == 32) {
				FlxG.stage.removeEventListener(KeyboardEvent.KEY_DOWN,nextStagePressed);
				_switchStage = true;
			}
		}
		
		public override function destroy():void {
			_timer.destroy();
			
			if (_track != null)
			{
				remove(_track);
				_track.destroy();
			}
			if (_switch != null) {
				remove(_switch);
				_switch.destroy();
			}
			
			if (_trolley != null)
			{
			remove(_trolley);
			_trolley.destroy();
			_trolleyPath.destroy();
			}
			
			if (_upperPerson != null) {
				remove(_upperPerson);
				_upperPerson.destroy();
				remove(_lowerPerson1);
				_lowerPerson1.destroy();
				remove(_lowerPerson2);
				_lowerPerson2.destroy();
				remove(_lowerPerson3);
				_lowerPerson3.destroy();
			}
			
			if (_resultBG != null)
			{
			remove(_resultBG);
			_resultBG.destroy();
			}
			
			if (_explanationText != null && FlxG.stage.contains(_explanationText)) FlxG.stage.removeChild(_explanationText);
			if (_resultText != null && FlxG.stage.contains(_resultText)) FlxG.stage.removeChild(_resultText);
			super.destroy();
		}
	}
}