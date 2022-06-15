package
{
	
	import org.flixel.*;
	
	public class Cookie
	{
		
		private static var _save:FlxSave;
		private static var _loaded:Boolean = false;
		private static var _tempCurrentStage:String;	
		private static var _tempStandardDecision:String;
		private static var _tempLoopDecision:String;
		private static var _tempShoveDecision:String;
		private static var _tempPersonalDecision:String;
		
		public function Cookie() {
		}
		
		public static function load():void {
			
			_save = new FlxSave();
			_loaded = _save.bind("MrCookie");
			if (_loaded && _save.data.currentStage == null) _save.data.currentStage = "Tutorial";
			if (_loaded && _save.data.standardDecision == null) _save.data.standardDecision = "";
			if (_loaded && _save.data.loopDecision == null) _save.data.loopDecision = "";
			if (_loaded && _save.data.shoveDecision == null) _save.data.shoveDecision = "";
			if (_loaded && _save.data.personalDecision == null) _save.data.personalDecision = "";
			
		}
		
		public static function flush():void {
			if (_loaded) _save.flush();
		}
		
		public static function erase():void {
			if (_loaded) _save.erase();
		}
		
		public static function set currentStage(value:String):void {
			if (_loaded) {
				_save.data.currentStage = value;
			}
			else {
				_tempCurrentStage = value;
			}
		}
		
		public static function get currentStage():String {
			if (_loaded)
			{
				return _save.data.currentStage;
			}
			else
			{
				return _tempCurrentStage;
			}
		}
		
		public static function set standardDecision(value:String):void {
			if (_loaded) {
				_save.data.standardDecision = value;
			}
			else {
				_tempStandardDecision = value;
			}
		}
		
		public static function get standardDecision():String {
			if (_loaded)
			{
				return _save.data.standardDecision;
			}
			else
			{
				return _tempStandardDecision;
			}
		}
		
		public static function set loopDecision(value:String):void {
			if (_loaded) {
				_save.data.loopDecision = value;
			}
			else {
				_tempLoopDecision = value;
			}
		}
		
		public static function get loopDecision():String {
			if (_loaded)
			{
				return _save.data.loopDecision;
			}
			else
			{
				return _tempLoopDecision;
			}
		}
		
		public static function set shoveDecision(value:String):void {
			if (_loaded) {
				_save.data.shoveDecision = value;
			}
			else {
				_tempShoveDecision = value;
			}
		}
		
		public static function get shoveDecision():String {
			if (_loaded)
			{
				return _save.data.shoveDecision;
			}
			else
			{
				return _tempShoveDecision;
			}
		}
		
		public static function set personalDecision(value:String):void {
			if (_loaded) {
				_save.data.personalDecision = value;
			}
			else {
				_tempPersonalDecision = value;
			}
		}
		
		public static function get personalDecision():String {
			if (_loaded)
			{
				return _save.data.personalDecision;
			}
			else
			{
				return _tempPersonalDecision;
			}
		}
	}
}