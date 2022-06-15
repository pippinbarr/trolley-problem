package
{
	import org.flixel.FlxSound;

	public class Assets
	{
		
		[Embed(source="assets/Font/Commodore Pixelized v1.2.ttf", fontName="COMMODORE", fontWeight="Regular", embedAsCFF="false")]
		public static const COMMODORE_FONT:Class;
		
		[Embed(source="assets/Sound/TrolleyProblemTitleTrack.mp3")]
		public static var SoundTrack:Class;
		
		[Embed(source="assets/Sound/hit.mp3")]
		public static var HitSound:Class;
		public static var _hit:FlxSound;
		
		[Embed(source="assets/SpriteSheet/Frame.png")]
		public static var FrameSS:Class;
		
		[Embed(source="assets/SpriteSheet/LongStandardTrackSS.png")]
		public static var StandardTrackSS:Class;
		
		[Embed(source="assets/SpriteSheet/LoopTrackSS.png")]
		public static var LoopTrackSS:Class;
		
		[Embed(source="assets/SpriteSheet/StraightTrackSS.png")]
		public static var StraightTrackSS:Class;
		
		[Embed(source="assets/SpriteSheet/TrolleySS.png")]
		public static var TrolleySS:Class;
		
		[Embed(source="assets/SpriteSheet/StandardPersonSS.png")]
		public static var StandardPersonSS:Class;
		public static const StandardPersonWidth:uint = 11;
		public static const StandardPersonHeight:uint = 17;
		
		[Embed(source="assets/SpriteSheet/FatPersonSS.png")]
		public static var FatPersonSS:Class;
		public static const FatPersonWidth:uint = 13;
		public static const FatPersonHeight:uint = 16;
		
		public static var _aliveFrames:Array = new Array(0,1);
		public static var _deadFrames:Array = new Array(2,2);
		
		[Embed(source="assets/SpriteSheet/SwitchSS.png")]
		public static var SwitchSS:Class;
		public static const SwitchWidth:uint = 9;
		public static const SwitchHeight:uint = 7;
		
		[Embed(source="assets/SpriteSheet/BridgeSS.png")]
		public static var BridgeSS:Class;
		public static const BridgeWidth:uint = 21;
		public static const BridgeHeight:uint = 7;
		
		public function Assets() {
		}
	}
}