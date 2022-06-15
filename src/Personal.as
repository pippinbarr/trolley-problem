package
{
	import flash.events.*;
	import flash.text.*;
	
	import org.flixel.*;
	
	public class Personal extends GameStage
	{
		

		
		public function Personal() {
			super();
		}
		
		public override function create():void {
			super.create();
			
			Cookie.currentStage = "Personal";
			Cookie.flush();
			
			_currentStage = "Personal";
			_nextStage = "Results";
			_explanationTexts = Texts._personal;
			
			setupStage();
			
			_personName = new TextField();
			_personName.defaultTextFormat = _personNameFormat;
			_personName.embedFonts = true;
			_personName.wordWrap = true;
			_personName.autoSize = "center";
			_personName.selectable = false;
			
			_personName.width = 300; 
			_personName.height = (FlxG.height * Globals.ZOOM_LEVEL) - 40;
			_personName.visible = true;
			
			_personName.text = "";
			
			_personName.x = (Globals.ZOOM_LEVEL * 90);
			_personName.y = 10;

			FlxG.stage.addChild(_personName);
			
			_timer.start(1,1,explanationHandler);
		}
		
		public override function update():void {
			super.update();
			
			if (_switchStage) {
				FlxG.switchState(new Results());		
			}
			
			if (_endingStage) return;
			
			checkDeaths();
			
			if (_trolley.pathSpeed == 0 && _trolley.velocity.x != 0) _trolley.velocity.x = 0;
			
			if (_decision == 1) {
				_track.frame = TRACK_TOP;
				_switch.play("right");
				_point1.y = TOP_TRACK_Y;
				_point2.y = TOP_TRACK_Y;
				_point2.x = 170;
			}
			
			if ((_trolley.x > 0 && _trolley.velocity.x == 0 && _trolley.velocity.y == 0) ||
				_trolley.x > FlxG.width) {
				if (_decision == 1) {
					Cookie.personalDecision = "ON LEVEL FOUR YOU CHOSE TO PULL THE SWITCH. " + _personName.text + " DIED. THREE PEOPLE LIVED.";
				}
				else {
					Cookie.personalDecision = "ON LEVEL FOUR YOU CHOSE NOT TO PULL THE SWITCH. THREE PEOPLE DIED. " + _personName.text + " LIVED.";
				}
				_timer.start(2,1,endStage);
				_endingStage = true;
			}

			
		}
		
		private function checkDeaths():void {
			if (_trolley.overlapsAt(_trolley.x - _trolley.width/2,_trolley.y,_lowerPerson1) && _lowerPerson1.alive) {
				_lowerPerson1.play("dead");
				Assets._hit.play(true);
				_lowerPerson1.alive = false;
			}
			if (_trolley.overlapsAt(_trolley.x - _trolley.width/2,_trolley.y,_lowerPerson2) && _lowerPerson2.alive) {
				_lowerPerson2.play("dead");
				Assets._hit.play(true);
				_lowerPerson2.alive = false;
			}
			if (_trolley.overlapsAt(_trolley.x - _trolley.width/2,_trolley.y,_lowerPerson3) && _lowerPerson3.alive) {
				_lowerPerson3.play("dead");
				Assets._hit.play(true);
				_lowerPerson3.alive = false;
			}
			if (_trolley.overlapsAt(_trolley.x - _trolley.width/2,_trolley.y,_upperPerson) && _upperPerson.alive) {
				_upperPerson.play("dead");
				_personName.setTextFormat(_personNameDeadFormat,0,_personName.text.length);
				Assets._hit.play(true);
				_upperPerson.alive = false;
			}
		}
		
		private function setupStage():void {
			// TRACK
			_track = new FlxSprite(0,0);
			_track.loadGraphic(Assets.StandardTrackSS,true,false,FlxG.width,FlxG.height);
			add(_track);
			
			// PEOPLE
			_lowerPerson1 = new Person(100,26,Assets.StandardPersonWidth,Assets.StandardPersonHeight,Assets.StandardPersonSS);
			_lowerPerson2 = new Person(110,26,Assets.StandardPersonWidth,Assets.StandardPersonHeight,Assets.StandardPersonSS);
			_lowerPerson3 = new Person(120,26,Assets.StandardPersonWidth,Assets.StandardPersonHeight,Assets.StandardPersonSS);
			_upperPerson = new Person(110,5,Assets.StandardPersonWidth,Assets.StandardPersonHeight,Assets.StandardPersonSS);
			
			add(_lowerPerson1);
			add(_lowerPerson2);
			add(_lowerPerson3);
			add(_upperPerson);
			
			// TROLLEY
			_trolley = new FlxSprite();
			_trolley.loadGraphic(Assets.TrolleySS,true,false,11,11);
			_trolley.x = -_trolley.width;
			_trolley.y = 26;
			_trolley.frame = TROLLEY_RIGHT;
			add(_trolley);
			
			// TROLLEY PATH
			_trolleyPath = new FlxPath();
			
			_pivotPoint = new FlxPoint(PIVOT_X,BOTTOM_TRACK_Y);
			_point1 = new FlxPoint(PIVOT_X,BOTTOM_TRACK_Y);
			_point2 = new FlxPoint(140,BOTTOM_TRACK_Y);
			
			_trolleyPath.addPoint(new FlxPoint(0,BOTTOM_TRACK_Y));
			_trolleyPath.addPoint(_pivotPoint,true);
			_trolleyPath.addPoint(_point1,true);
			_trolleyPath.addPoint(_point2,true);
			
			// FRAME
			_frame = new FlxSprite(0,0);
			_frame.loadGraphic(Assets.FrameSS,false,false,FlxG.width,FlxG.height);
			add(_frame);
			
			// SWITCH
			_switch = new FlxSprite(40,15);
			_switch.loadGraphic(Assets.SwitchSS,true,false,Assets.SwitchWidth,Assets.SwitchHeight);
			_switch.addAnimation("left",[0],10,false);
			_switch.addAnimation("right",[1],10,false);
			_switch.play("left");
			add(_switch);
			
			_stageReady = true;
		}
		
		public override function destroy():void {
			if (_personName != null && FlxG.stage.contains(_personName)) FlxG.stage.removeChild(_personName);
			
			super.destroy();
		}
		
	}
}