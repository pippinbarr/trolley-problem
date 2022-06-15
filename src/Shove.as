package
{
	import flash.events.*;
	import flash.text.*;
	
	import org.flixel.*;
	
	public class Shove extends GameStage
	{
		
		public function Shove() {
			super();
		}
		
		public override function create():void {
			super.create();
			
			Cookie.currentStage = "Shove";
			Cookie.flush();

			
			_nextStage = "Personal";
			_explanationTexts = Texts._shove;
			
			setupStage();
			
			_timer.start(1,1,explanationHandler);
		}
		
		public override function update():void {
			super.update();
			
			if (_switchStage) {
				FlxG.switchState(new Personal());		
			}
			
			if (_endingStage) return;
			
			checkDeaths();
			
			if (_trolley.pathSpeed == 0 && _trolley.velocity.x != 0) _trolley.velocity.x = 0;
			
			if (_decision == 1 && _trolley.x + _trolley.width < _upperPerson.x) {
				_upperPerson.y = 30;
				_pivotPoint.x = 75;
				_point1.x = 75;
				_point2.x = 75;
			}
			
			if ((_trolley.x > 0 && _trolley.velocity.x == 0 && _trolley.velocity.y == 0) ||
				_trolley.x > FlxG.width) {
				if (_decision == 1) {
					Cookie.shoveDecision = "ON LEVEL THREE YOU CHOSE TO SHOVE THE VERY LARGE PERSON. THE VERY LARGE PERSON DIED. THREE PEOPLE LIVED.";
				}
				else {
					Cookie.shoveDecision = "ON LEVEL THREE YOU CHOSE NOT TO SHOVE THE VERY LARGE PERSON. THREE PEOPLE DIED. THE VERY LARGE PERSON LIVED.";
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
			if (_decision == 1 && 
				_upperPerson.y == 30 &&
				_trolley.overlapsAt(_trolley.x - _trolley.width/2,_trolley.y,_upperPerson) && 
				_upperPerson.alive) {
				_upperPerson.play("dead");
				Assets._hit.play(true);
				_upperPerson.alive = false;
			}
		}
		
		private function setupStage():void {
			// TRACK
			_track = new FlxSprite(0,0);
			_track.loadGraphic(Assets.StraightTrackSS,true,false,FlxG.width,FlxG.height);
			add(_track);
			
			_bridge = new FlxSprite(50,27);
			_bridge.loadGraphic(Assets.BridgeSS,true,false,Assets.BridgeWidth,Assets.BridgeHeight);
			add(_bridge);
			
			// PEOPLE
			_lowerPerson1 = new Person(100,26,Assets.StandardPersonWidth,Assets.StandardPersonHeight,Assets.StandardPersonSS);
			_lowerPerson2 = new Person(110,26,Assets.StandardPersonWidth,Assets.StandardPersonHeight,Assets.StandardPersonSS);
			_lowerPerson3 = new Person(120,26,Assets.StandardPersonWidth,Assets.StandardPersonHeight,Assets.StandardPersonSS);
			
			_upperPerson = new Person(54,12,Assets.FatPersonWidth,Assets.FatPersonHeight,Assets.FatPersonSS);
			
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
			
			_stageReady = true;
		}
		
		public override function destroy():void {
			super.destroy();
		}
		
	}
}