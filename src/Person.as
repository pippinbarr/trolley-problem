package
{
	import org.flixel.*;
	
	public class Person extends FlxSprite
	{
		public function Person(X:int,Y:int,W:uint,H:uint,PersonGraphic:Class) {
			super(X,Y);
			this.loadGraphic(PersonGraphic,true,false,W,H);
			this.addAnimation("alive",[0,1],3,true);
			this.addAnimation("dead",[2,2],3,false);
			this.play("alive");
			this.alive = true;
		}
		
		public override function update():void {
			super.update();
		}
		
		public override function destroy():void {
			super.destroy();
		}
	}
}