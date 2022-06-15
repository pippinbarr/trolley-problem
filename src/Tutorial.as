package
{
	import flash.events.*;
	import flash.text.*;
	
	import org.flixel.*;
	
	public class Tutorial extends GameStage {
		
		public function Tutorial() {
			super();
		}
		
		public override function create():void {
			super.create();
			
			Cookie.currentStage = "Tutorial";
			Cookie.flush();
			_nextStage = "Standard";
			_explanationTexts = Texts._tutorial;
			
			setupStage();
			
			_timer.start(1,1,explanationHandler);
		}
		
		public override function update():void {
			super.update();
			
			if (_switchStage) {
				FlxG.switchState(new Standard());		
			}
			
			if (_endingStage) return;
			
			if (_decision == 1 && _track.frame != TRACK_TOP) {
				_track.frame = TRACK_TOP;
				_switch.play("right");
				_point1.y = TOP_TRACK_Y;
				_point2.y = TOP_TRACK_Y;
			}
			
			if (_trolley.x > FlxG.width && _trolley.velocity.x > 0) {
				_timer.start(2,1,endStage);
				_endingStage = true;
			}
			
		}
		
		private function setupStage():void {
			// TRACK
			_track = new FlxSprite(0,0);
			_track.loadGraphic(Assets.StandardTrackSS,true,false,FlxG.width,FlxG.height);
			add(_track);
			
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
			_point2 = new FlxPoint(150,BOTTOM_TRACK_Y);
			
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
			super.destroy();
		}
		
	}
}