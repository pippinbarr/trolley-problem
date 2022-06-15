package
{
	import flash.display.*;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.*;
	import flash.utils.getTimer;
	
	import org.flixel.system.FlxPreloader;
	
	[SWF(width = "900", height = "450", backgroundColor = "#FFFFFF")]
	
	public class TrolleyProblemPreloader extends FlxPreloader {
		
		[Embed(source="assets/Font/Commodore Pixelized v1.2.ttf", fontName="COMMODORE", fontWeight="Regular", embedAsCFF="false")]
		private var COMMODORE_FONT:Class;
		
		[Embed(source="assets/SpriteSheet/Frame.png")]
		private var Frame:Class;
		[Embed(source="assets/SpriteSheet/StraightTrackSS.png")]
		private var Track:Class;
				
		private var _loadingText:TextField;
		private var _loadingTextFormat:TextFormat;
		
		private var _bg:Bitmap;
		private var _loadingBar:Bitmap;
		private var _track:Bitmap;
		
		private var _playButton:TextField;
		private var _playButtonFormat:TextFormat;
		
		private var _timer:uint = 0;
		
		public function TrolleyProblemPreloader() {			
			className = "TrolleyProblem";
			super();
		}
		
		override protected function create():void {
			
			Font.registerFont(COMMODORE_FONT);
			
			// Set minimum running time of the preload
			_min = 8000000;
			
			// Create a buffer Sprite
			_buffer = new Sprite();
			addChild(_buffer);	
			
			_bg = new Frame();
			_bg.x = 0;
			_bg.y = 0;
			_bg.scaleX = 6;
			_bg.scaleY = 6;
						
			// Textfield to display boarding messages
			_loadingTextFormat = new TextFormat("COMMODORE",50,0x000000,null,null,false,null,null,"center",null,null,null,null);
			_loadingText = new TextField();
			_loadingText.width = stage.stageWidth;
			_loadingText.x = stage.x;
			_loadingText.y = stage.stageHeight/2 - 100;
			_loadingText.embedFonts = true;
			_loadingText.selectable = false;
			_loadingText.defaultTextFormat = _loadingTextFormat;
			_loadingText.text = "LOADING";
						
			_playButton = new TextField();
			_playButtonFormat = new TextFormat("COMMODORE",30,0xFF0000,null,null,false,null,null,"center",null,null,null,null);
			_playButton.width = stage.stageWidth;
			_playButton.x = stage.x;
			_playButton.y = stage.stageHeight/2 + 50;
			_playButton.embedFonts = true;
			_playButton.selectable = false;
			_playButton.defaultTextFormat = _playButtonFormat;
			_playButton.text = "CLICK TO PLAY!";
			
			_track = new Track();
			_track.x = 0;
			_track.y = 0;
			_track.scaleX = 6;
			_track.scaleY = 6;
			
			_loadingBar = new Bitmap(new BitmapData(1,50,false,0xFFFFFF));			
			_loadingBar.x = 6;
			_loadingBar.y = stage.stageHeight/2 - 20;
			_loadingBar.scaleX = stage.stageWidth - 12;
			
			_buffer.addChild(_track);
			_buffer.addChild(_bg);
			_buffer.addChild(_loadingBar);	
			_buffer.addChild(_loadingText);	

			
		}
		
		override protected function update(Percent:Number):void {
			
			var ActualPercent:Number = root.loaderInfo.bytesLoaded / root.loaderInfo.bytesTotal;
			_loadingBar.scaleX = 1/(ActualPercent * stage.stageWidth-12);
			
			if (root.loaderInfo.bytesLoaded < root.loaderInfo.bytesTotal && getTimer() < _min) {
				_timer++;
			}
			else {
				_loadingText.text = "LOADED";
				_buffer.addChild(_playButton);
				stage.addEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
			}
			
		}
		
		private function mouseDown(e:MouseEvent):void {
			_min = 3000;
			stage.focus = null;
		}
		
	}
}